From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/4] Re: Undocumented git-diff syntax
Date: Mon, 11 Oct 2010 11:02:24 -0500
Message-ID: <20101011160224.GA25842@burratino>
References: <20101011150342.292ad725@chalon.bertin.fr>
 <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:05:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Ksn-00037Y-8F
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab0JKQFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 12:05:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64708 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab0JKQFm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 12:05:42 -0400
Received: by gyg13 with SMTP id 13so818716gyg.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0PPdakaKGsU/hwEz31Vv2V16YjvhqclsaQr435WujLE=;
        b=NN7QqRopVg1PTdm+fY93OCQlTZBDSUdNt2iQhKF/nio1YusYFVVGJnNnjoalV2szAn
         M1qWlKk5mYu7wc5n6p27lz8cQr79v8LzVaNaIfJ9Msk+GiD65UVQOWtkb0gjhw4lIZ9J
         k4pqk1E9jYqnm34iI5d/QXcAOtRhyUnSUoW90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nC/6gdwmn92qJ4yNFDjqDIGSGnHhId9P5Fh+15hGNIcWvOOBGxTqUWYgMS8bcQt0jI
         jvqgd+Ux6Zj2/y7Mtpp3zStoFeoSeW3FlxkJp1Vjbmh0ePckUKXy9Ge5nWMoULd7L0Aj
         oP69O2vnee6RHAnOadC9KoTuifOZwtZ1YuesU=
Received: by 10.42.110.84 with SMTP id o20mr2199557icp.286.1286813141826;
        Mon, 11 Oct 2010 09:05:41 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id in12sm7410290ibb.3.2010.10.11.09.05.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 09:05:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011161721.35940919@chalon.bertin.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158770>

Yann Dirson wrote:

> OTOH, that appears not to be 100% accurate (my tests would have
> shown me): although --no-index does give me the expected results when
> one or two of the files are untracked, I have to explicitely add it,
> which seem to contradict this part of the doc.

Yep, the doc is out of date.  Luckily I had a series updating it
rotting in my local tree.

Patch 5 gives --no-index its own prominent mention in the DESCRIPTION
section.  I suspect that is a bad idea --- too much to learn for new
users --- and that the description should go under OPTIONS, but I ran
out of time.

Maybe patches 1-4 can help?

Jonathan Nieder (5):
  Documentation: gitrevisions is in section 7
  Documentation: diff can compare blobs
  Documentation: expand 'git diff' SEE ALSO section
  Documentation: update "git diff --no-index" description
  Documentation: expand diff --no-index description

 Documentation/git-cat-file.txt         |    2 +-
 Documentation/git-check-ref-format.txt |    2 +-
 Documentation/git-cherry-pick.txt      |    2 +-
 Documentation/git-diff.txt             |   36 ++++++++++++++++++++++++--------
 Documentation/git-fast-import.txt      |    2 +-
 Documentation/git-format-patch.txt     |    2 +-
 Documentation/git-log.txt              |    2 +-
 Documentation/git-push.txt             |    2 +-
 Documentation/git-reflog.txt           |    2 +-
 Documentation/git-revert.txt           |    2 +-
 Documentation/git-show-branch.txt      |    2 +-
 Documentation/git-show.txt             |    2 +-
 Documentation/git.txt                  |    2 +-
 Documentation/gitcore-tutorial.txt     |    2 +-
 Documentation/gitk.txt                 |    2 +-
 Documentation/user-manual.txt          |    8 +++---
 16 files changed, 45 insertions(+), 27 deletions(-)

-- 
1.7.2.3

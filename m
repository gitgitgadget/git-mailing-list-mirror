From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Mon, 21 Jul 2008 12:23:45 +0200
Message-ID: <200807211223.45707.jnareb@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <200807210029.31543.jnareb@gmail.com> <1216601739.6523.48.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joshua Roys <roysjosh@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 12:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKsZY-0007qX-Rk
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 12:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814AbYGUKXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 06:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674AbYGUKXx
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 06:23:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:41535 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757229AbYGUKXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 06:23:52 -0400
Received: by nf-out-0910.google.com with SMTP id d3so435131nfc.21
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cD9LBVbPVz9/EyqVbzaHqMc0lzYnlMmsNIQyNtkwmFQ=;
        b=m8zlm5S3GUB3+EsSIBGKoG0j7WEQ+xvq0oOAp0tYKUwqWz9rHJArgRzW5BJYtvBXpt
         vT/2CYTA9Kj0JXhwo2wLx66BAY6l1ic5kBVWF1+AgGQMVOjTS9AzJo1b06nkL6APT87y
         XCTdJR/WTIdXBcUTJtDknwItdq5klDMdm1e3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WumiO6wKDu0LiOGZGWyCsRsVZlAVcwjaxR0O1PSgL1szw108EkMcNSThT2G20/Llt9
         HmkiLe/AS/le2HDzVhHrV7rla3Xs1tIH7Prl9LqFLzGYsNgHl/y/Mby+0BqQPuJp/Hwo
         Hiv2Ls0ccwNfnOWCCBV7w7oyndDlR3N8VU7YM=
Received: by 10.210.87.19 with SMTP id k19mr3093771ebb.176.1216635831062;
        Mon, 21 Jul 2008 03:23:51 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.212.51])
        by mx.google.com with ESMTPS id z33sm7274706ikz.0.2008.07.21.03.23.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jul 2008 03:23:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1216601739.6523.48.camel@maia.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89335>

On Mon, 21 July 2008, Sam Vilain wrote:
> On Mon, 2008-07-21 at 00:29 +0200, Jakub Narebski wrote:
> >
> > 1. GitTorrent
> >  
> > Student: Joshua Roys
> > Mentor: Sam Vilain
> > 
> > I never got more response than "it is going slower than I would like, 
> > [...] Other than that, it's going well, I think." from Joshua Roys.
> 
> > Mailing list archives for gittorrent mailing list doesn't show anything 
> > interesting, either (last post is from 2007).
> >   http://lists.utsl.gen.nz/pipermail/gittorrent/
> 
> That's a valid complaint.  I've posted a summary of the project status
> there, and will keep as much related discussion as appropriate on-list
> from here.

You can find it on GMane, too:
  http://thread.gmane.org/gmane.comp.version-control.git.gittorrent/1

It would be nice if it was send to git mailing list too, perhaps
directing replies to gittorrent mailing list only by default.

A short summary of this thread (please correct me if I am wrong):

 * Tracker: representing "metainfo" files, working tracker (test)
   is in progress

 * Core infrastructure: "Commit Reel" sorting algorithm implemented[1]
   B-tree index for fast querying.

   To be done is determining minimal set of edge objects which define
   reel (that can be passed to "git rev-list --objects-edge" to get thin
   pack representing reel).

 * Peer to Peer: handshake and two trivial messages[2] implemented.
   To be done are (minimally) "References", "Blocks", "Request" and
   "Play" messages.

Footnotes:
==========
[*1*] "the current implementation is quite slow (requiring two calls to
'git-cat-file' for each object)" <-- why you don't use '--batch' or
'--batch-check' options to git cat file: see also Git::Repo and friends
implementation send by Lea Wiemann to git mailing list as part of
"Gitweb caching" project?  BTW. by keeping discussion off the list,
you are off the knowledge of git community, too.

[*2*] _What_ are those "two trivial messages"?

-- 
Jakub Narebski
Poland

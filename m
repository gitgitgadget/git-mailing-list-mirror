From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] Documentation: update "git diff --no-index" description
Date: Mon, 11 Oct 2010 11:06:18 -0500
Message-ID: <20101011160618.GE25842@burratino>
References: <20101011150342.292ad725@chalon.bertin.fr>
 <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr>
 <20101011160224.GA25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:09:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Kwl-0005Up-MW
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab0JKQJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 12:09:50 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55238 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab0JKQJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 12:09:50 -0400
Received: by qyk5 with SMTP id 5so1243550qyk.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6ytKvzR4MtRvPQDC0YLYd0cxIDnL1JZvPJL+SBXjFR0=;
        b=Q8bNusfnSn22UnFdCjRa02wkgrg7Qr06mASWBl6m1aWofNtV4TtnZ/CrCJEPd9mvay
         aTKoLz1eTXcmzmQpgqr9ym5YeXgGU/mYdoiRSbJJ3Vb/TJNXFIMuT5voi4gYd7QwO32m
         b7TOZQl2jIP+ycptauMdToCrz9tlBUgtY1BFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OKrt/kvzEskcxF1Qa+QqfnawlpiNQtr+Sjw7m8s6pMuxC/ECMMEI24W6VYJLqUon/S
         urlVUuiolswMdwCJ5doPoGV8UGuhOzVrH0139SH83b5K8S0okojTyNytfhXf/pQ2d+ub
         Bbgq3Io2Sv9SEvPhzAsUpd1FptMsv88j+uZj8=
Received: by 10.229.213.212 with SMTP id gx20mr5262894qcb.60.1286813374404;
        Mon, 11 Oct 2010 09:09:34 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id mz11sm3462491qcb.15.2010.10.11.09.09.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 09:09:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011160224.GA25842@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158774>

Originally "git diff --no-index" triggered for untracked files within
the tracked tree, but with v1.5.6-rc1~41 (Merge branch
'jc/diff-no-no-index, 2008-05-26) the command changed to only trigger
when paths outside the tracked tree are mentioned.

Reported-by: Yann Dirson <dirson@bertin.fr>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-diff.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index fe34d4e..dd1fb32 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -23,9 +23,9 @@ tree and the index file, or the index file and the working tree.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 +
-If exactly two paths are given, and at least one is untracked,
-compare the two files / directories. This behavior can be
-forced by --no-index.
+If exactly two paths are given and at least one points outside
+the current repository, 'git diff' will compare the two files /
+directories. This behavior can be forced by --no-index.
 
 'git diff' [--options] --cached [<commit>] [--] [<path>...]::
 
-- 
1.7.2.3

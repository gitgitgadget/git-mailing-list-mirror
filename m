From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: A tiny documentation patch
Date: Mon, 10 Aug 2009 16:44:19 +0200
Message-ID: <20090810144419.GB24183@headley>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GID0FwUMdk1T2AWN"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 16:43:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaW5g-0004nh-Rw
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 16:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbZHJOm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 10:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328AbZHJOm5
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 10:42:57 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51720 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036AbZHJOm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 10:42:57 -0400
Received: by bwz19 with SMTP id 19so2612158bwz.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=rqlj+eWpuPxKrcukQ7qZxFCRNizPhvmtHqDtl2dYOvA=;
        b=nrSh5JVoTwfhhaUtzLLDmyTtvPSzedDCt/dW+ZatwlSuG0Ib1DeGcfMWLu1ZLSHS4j
         tQoMxebENTYs76LEBDEBfOfQ6QBhGk0Kzg9ZuXAV/x+PO3SDyhSgBuy65mIGcCBt5FPN
         6VI35gaOKfFYkASsjvrRWgbnT/RzAQl9xtl0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=wn0hF0/y7m+t+QG6EBDlJPJJuxfWcEInH74M0mBVb0AKHWHEbtLrElHsYlHsFach0n
         GDqDv/KJURyesoGY2rbi1cw97edSwJXY6Ll2JS7aIZo4rta11yZP/pcPZtVz3e/BFARy
         /RgpEWWbGOiZKU1GmXXA0UIfLA6sLye1dSzQ4=
Received: by 10.204.63.208 with SMTP id c16mr6076307bki.131.1249915376913;
        Mon, 10 Aug 2009 07:42:56 -0700 (PDT)
Received: from localhost (topol.nat.praha12.net [78.102.11.1])
        by mx.google.com with ESMTPS id 22sm6859847fkr.30.2009.08.10.07.42.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 07:42:55 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125451>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

 Hello,

I noticed a few typos in the git-remote manpage, so I fixed the txt
source file and here's the patch.

 Best regards and thank you for Git!

Štěpán Němec

--GID0FwUMdk1T2AWN
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-Fix-typos-in-git-remote.txt.patch"

>From 65ae3e5cdb241aaaed96a7aeecffb6d305d0b07c Mon Sep 17 00:00:00 2001
From: =?utf-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@gmail.com>
Date: Mon, 10 Aug 2009 16:29:08 +0200
Subject: [PATCH] Fix typos in git-remote.txt

---
 Documentation/git-remote.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 9e2b4ea..0964cee 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -56,10 +56,10 @@ multiple branches without grabbing all branches.
 With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
-In mirror mode, enabled with `\--mirror`, the refs will not be stored
+In mirror mode, enabled with `--mirror`, the refs will not be stored
 in the 'refs/remotes/' namespace, but in 'refs/heads/'.  This option
 only makes sense in bare repositories.  If a remote uses mirror
-mode, furthermore, `git push` will always behave as if `\--mirror`
+mode, furthermore, `git push` will always behave as if `--mirror`
 was passed.
 
 'rename'::
@@ -114,14 +114,14 @@ These stale branches have already been removed from the remote repository
 referenced by <name>, but are still locally available in
 "remotes/<name>".
 +
-With `--dry-run` option, report what branches will be pruned, but do no
+With `--dry-run` option, report what branches will be pruned, but do not
 actually prune them.
 
 'update'::
 
 Fetch updates for a named set of remotes in the repository as defined by
 remotes.<group>.  If a named group is not specified on the command line,
-the configuration parameter remotes.default will get used; if
+the configuration parameter remotes.default will be used; if
 remotes.default is not defined, all remotes which do not have the
 configuration parameter remote.<name>.skipDefaultUpdate set to true will
 be updated.  (See linkgit:git-config[1]).
-- 
1.6.3.3


--GID0FwUMdk1T2AWN--

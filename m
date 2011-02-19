From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] Documentation: default -u<mode> is 'normal'
Date: Sat, 19 Feb 2011 17:30:08 +0100
Message-ID: <20110219163008.GA16117@localhost>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 17:28:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqpfb-0004Hk-AN
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 17:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab1BSQ2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 11:28:23 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52116 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab1BSQ2W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 11:28:22 -0500
Received: by fxm17 with SMTP id 17so205943fxm.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 08:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-type:content-disposition:user-agent;
        bh=6aKBQryl8G/F93l6Zq4RvDvHjlWAiTvCVCXaMtcFsSk=;
        b=MuqgP+sl/prNKqmk1Xv/xUhb89I+BBsEIIodj1hkwWMOPmrDgLaawwBd6bKPvUaf+V
         Sdy6gWvmqYJ/rj6kD+6K4CseN5m96kGrj5Y5WPNzZiWtuBmVENtIpFHUeYQ5HFtjL7gl
         vR87dHSvbH+JMlO50dKeFuaV0waOFuXI8UeWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-type:content-disposition:user-agent;
        b=e2C9LA+p2axuknPxhprEvwJWLGSiIr6g+bixZGt+qf9oAzXTf6YbGTtGn+/ppqzddF
         G/am2QEFA12IxV+5xyzJM78A7nrKWJTVG2pCU/zgPpfAXQVgc2GCUFPkCAZyB9OzpNIP
         fafFRGWJKHmteYEsAADF3cSzuEbmFti2dhXLg=
Received: by 10.223.81.68 with SMTP id w4mr2622155fak.84.1298132901032;
        Sat, 19 Feb 2011 08:28:21 -0800 (PST)
Received: from darc.lan (p5B22DBEA.dip.t-dialin.net [91.34.219.234])
        by mx.google.com with ESMTPS id n2sm1621978fam.4.2011.02.19.08.28.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 08:28:20 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PqphA-0004DO-Hn; Sat, 19 Feb 2011 17:30:08 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167299>

git-commit's and git-status' default untracked status mode is
'normal', not 'all'.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 Documentation/git-commit.txt |    2 +-
 Documentation/git-status.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b586c0f..b4e2f1b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -214,7 +214,7 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 
 -u[<mode>]::
 --untracked-files[=<mode>]::
-	Show untracked files (Default: 'all').
+	Show untracked files (Default: 'normal').
 +
 The mode parameter is optional, and is used to specify
 the handling of untracked files.
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index dae190a..369277a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -38,7 +38,7 @@ OPTIONS
 
 -u[<mode>]::
 --untracked-files[=<mode>]::
-	Show untracked files (Default: 'all').
+	Show untracked files (Default: 'normal').
 +
 The mode parameter is optional, and is used to specify
 the handling of untracked files. The possible options are:
-- 
1.7.3.1.105.g84915

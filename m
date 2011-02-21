From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] Documentation: clarify -u<mode> option defaults
Date: Mon, 21 Feb 2011 21:05:25 +0100
Message-ID: <20110221200525.GB31181@localhost>
References: <20110219163008.GA16117@localhost>
 <7vei71jkdk.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 21:03:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prbyu-00035h-MR
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 21:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab1BUUDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 15:03:36 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53395 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab1BUUDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 15:03:35 -0500
Received: by fxm17 with SMTP id 17so1894142fxm.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9AUQD216SaGMldlXsT3eONOf2DanFu2Mnf5hlthIauY=;
        b=vKwJhzuXF9aRnFvIMhyx1fnwXP4UCIKUJIt/prZO7vFDoyX6NioxTvUfIARHJ9da8V
         Zzeu9H9J8Rkd2Wyt5WBvWqtWInPelOpazIH8AYmFKlziCduiX1W3IvW1po/EiVhR1m/n
         GGyO+3LTKxhpWvGycV8aJ0cp3OA01EBiU0t9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=W2Y5o0jaZUMczXj966WRX03kPZsDzXhl+7vSFm72Yd/94XyEIAVr5P66tAEAIwabo9
         4jS1V1Qn+Knnn96d3yy7YjgD+GPC30x9Vm/jKnfxl+PSVmChPFAuYd34Itdo05ayaFIQ
         1wlgpMpM9iiQeUDofq5+9NsYVt+M95OfKCVdQ=
Received: by 10.223.74.5 with SMTP id s5mr2381563faj.72.1298318614342;
        Mon, 21 Feb 2011 12:03:34 -0800 (PST)
Received: from darc.lan (p5B22C930.dip.t-dialin.net [91.34.201.48])
        by mx.google.com with ESMTPS id o17sm2659237fal.1.2011.02.21.12.03.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 12:03:33 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Prc0b-0008ET-6P; Mon, 21 Feb 2011 21:05:25 +0100
Content-Disposition: inline
In-Reply-To: <7vei71jkdk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167505>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Hi Junio,

Ok, with that we should be able to avoid any future confusion.
Thanks for clarifying.

Clemens

 Documentation/git-commit.txt |   12 ++++++------
 Documentation/git-status.txt |   16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b586c0f..8f89f6f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -214,10 +214,11 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 
 -u[<mode>]::
 --untracked-files[=<mode>]::
-	Show untracked files (Default: 'all').
+	Show untracked files.
 +
-The mode parameter is optional, and is used to specify
-the handling of untracked files.
+The mode parameter is optional (defaults to 'all'), and is used to
+specify the handling of untracked files; when -u is not used, the
+default is 'normal', i.e. show untracked files and directories.
 +
 The possible options are:
 +
@@ -225,9 +226,8 @@ The possible options are:
 	- 'normal' - Shows untracked files and directories
 	- 'all'    - Also shows individual files in untracked directories.
 +
-See linkgit:git-config[1] for configuration variable
-used to change the default for when the option is not
-specified.
+The default can be changed using the status.showUntrackedFiles
+configuration variable documented in linkgit:git-config[1].
 
 -v::
 --verbose::
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index dae190a..5102a23 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -38,20 +38,20 @@ OPTIONS
 
 -u[<mode>]::
 --untracked-files[=<mode>]::
-	Show untracked files (Default: 'all').
+	Show untracked files.
 +
-The mode parameter is optional, and is used to specify
-the handling of untracked files. The possible options are:
+The mode parameter is optional (defaults to 'all'), and is used to
+specify the handling of untracked files; when -u is not used, the
+default is 'normal', i.e. show untracked files and directories.
++
+The possible options are:
 +
---
 	- 'no'     - Show no untracked files
 	- 'normal' - Shows untracked files and directories
 	- 'all'    - Also shows individual files in untracked directories.
---
 +
-See linkgit:git-config[1] for configuration variable
-used to change the default for when the option is not
-specified.
+The default can be changed using the status.showUntrackedFiles
+configuration variable documented in linkgit:git-config[1].
 
 --ignore-submodules[=<when>]::
 	Ignore changes to submodules when looking for changes. <when> can be
-- 
1.7.3.1.105.g84915

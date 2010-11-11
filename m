From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] git.txt: correct where --work-tree path is relative to
Date: Thu, 11 Nov 2010 21:20:48 +0700
Message-ID: <1289485248-8966-8-git-send-email-pclouds@gmail.com>
References: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 15:25:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGY5C-0001Ma-2P
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342Ab0KKOYf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 09:24:35 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41606 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab0KKOY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 09:24:26 -0500
Received: by pzk28 with SMTP id 28so397686pzk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ccFRQo/rvPWVTZcpQQFc5ahdF8hlIODvQRb1UvljBmA=;
        b=FiQTJT3++x2rN4dFrp6m7pG+qiKZV4606+LhAJ66ISTQNt6ZGIqOaQRj6WRde4j+gB
         CqhAyFij7V3TCYgALHO/BsPkjZTQonpPfeouyKgch5oWRP8SKKYvPBhfKajdQCsR208f
         ifOR6gN4UNOadiR3tMGBlyc4KmZiG4yfmtQXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=t6gQ/5IZflfLmkeCBpY8I2RlxLIMJpeOJ/M93Jr+eMcMmSTFNXDBuO7go3eoebnUbf
         BUflj2V79xyo26Scm1fcscyRoCWWwPuG+GA5uZRHhhc9/7+QUVNk8Y/GG+ePSzmXJjG8
         aF6feP1o11o2mWm/qVszOqS6OmEQrhsnIgE6U=
Received: by 10.142.131.6 with SMTP id e6mr639568wfd.160.1289485465899;
        Thu, 11 Nov 2010 06:24:25 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id x35sm2425758wfd.13.2010.11.11.06.24.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 06:24:24 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Nov 2010 21:23:05 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161261>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b46c6f6..971c52a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -284,7 +284,7 @@ help ...`.
 	This can also be controlled by setting the GIT_WORK_TREE
 	environment variable and the core.worktree configuration
 	variable. It can be an absolute path or relative path to
-	the directory specified by --git-dir or GIT_DIR.
+	current working directory.
 	Note: If --git-dir or GIT_DIR are specified but none of
 	--work-tree, GIT_WORK_TREE and core.worktree is specified,
 	the current working directory is regarded as the top directory
--=20
1.7.3.2.210.g045198

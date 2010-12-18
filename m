From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 4/8] http-fetch docs: use <commit-id> consistently
Date: Sat, 18 Dec 2010 00:38:41 -0500
Message-ID: <1292650725-21149-5-git-send-email-lodatom@gmail.com>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 06:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTpVw-0006oi-HI
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 06:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab0LRFjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 00:39:11 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40775 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab0LRFjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 00:39:04 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so2354117qyj.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 21:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nrQVhRjdHjEUIyzqQiRp61phjHq5J0AJNjx2Lujigpo=;
        b=uZ43GW+jzi1C8gypxaUft/GcMFAfl9wPbHn+kF9iG/zbQZpDfWY8pYEmXntDBtI2ux
         Utwp249PigGSYhOI6bXYFZk1DtI0YBtyLiaHc0LfKKzsxSbyeMIQtW1AP15dBwKCsYnY
         XoKPaGWbtCuW8tc4nLo0pfAuSjMaVRvUIhpxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Lbe7DMb3uWkNItOAkh2iM+/UbRtMmUC7q8mwcCnrGNKtPWl+QP+rzuCK2sBFKrctBd
         I9ubEj1gpRkKqVLPppna4CaDMTWExrkib2F6iDLKJRLTeoVp5sei6zijFDVFNrUdKhlY
         iM4misMlk30ntiwTl87HUf4q8CrCX70jVjI38=
Received: by 10.224.45.72 with SMTP id d8mr1619728qaf.111.1292650743884;
        Fri, 17 Dec 2010 21:39:03 -0800 (PST)
Received: from localhost.localdomain (c-68-49-150-7.hsd1.dc.comcast.net [68.49.150.7])
        by mx.google.com with ESMTPS id n7sm683569qcu.28.2010.12.17.21.39.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 21:39:03 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163900>

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-http-fetch.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index d91cb7f..93449fd 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -8,7 +8,7 @@ git-http-fetch - Download from a remote git repository via HTTP
 
 SYNOPSIS
 --------
-'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
+'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit-id> <url>
 
 DESCRIPTION
 -----------
@@ -16,7 +16,7 @@ Downloads a remote git repository via HTTP.
 
 OPTIONS
 -------
-commit-id::
+<commit-id>::
         Either the hash or the filename under [URL]/refs/ to
         pull.
 
-- 
1.7.3.2

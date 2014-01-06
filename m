From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] completion: complete format.coverLetter
Date: Mon,  6 Jan 2014 22:48:51 +0530
Message-ID: <1389028732-27760-2-git-send-email-artagnon@gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
Cc: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:18:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0DpJ-0000Af-Ky
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbaAFRSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:18:51 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:55108 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838AbaAFRSt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:18:49 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so18282754pde.41
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 09:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yZXo6aPc7sh1Ksyw/el3CEMIc5dBEZgjdmMMC2fOyKA=;
        b=ytNGY5jz4pAKdmBEb9NuKWGayjpPMggeno2B6NOkUeCSFTS3o0zGlfUNzzaY5cttFo
         DdyiP+5KvVO8v+uoct0DiZk0Tmq7KCoRRsviuRFsFZRRnQjWbPGNKDHnyda5ViBcTsPI
         YxLWpNTNIqvBu1SZOy0zGyjLvRRBeQ5RX0k/joDVIPReFd+mUkpcDnOkA383kPEHZzOK
         lTsNLbgfqXSyEhkJLeCrFtsufU02Sqjiz/QLiVFhZ7np/ytvk8sM/A5hgzHZrF2xhKiK
         vKrURqLNeA65pW+InEduzD+iCkGvXDoEh3AvJJmqVT9vu6UV1B9zVi+uS5AA7ieRebu6
         U8lw==
X-Received: by 10.68.242.68 with SMTP id wo4mr130016185pbc.32.1389028729374;
        Mon, 06 Jan 2014 09:18:49 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id jk16sm130131323pbb.34.2014.01.06.09.18.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jan 2014 09:18:48 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.229.g4448466.dirty
In-Reply-To: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240029>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 51c2dd4..39b81f7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1991,6 +1991,7 @@ _git_config ()
 		fetch.unpackLimit
 		format.attach
 		format.cc
+		format.coverLetter
 		format.headers
 		format.numbered
 		format.pretty
-- 
1.8.5.2.229.g4448466.dirty

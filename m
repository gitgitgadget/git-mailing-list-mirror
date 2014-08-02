From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH 5/7] Documentation: git-init: reword parenthetical statements
Date: Sat,  2 Aug 2014 11:06:55 -0700
Message-ID: <1407002817-29221-6-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 20:08:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDdiz-0007yi-6A
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 20:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbaHBSIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 14:08:04 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:33914 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbaHBSID (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 14:08:03 -0400
Received: by mail-yh0-f41.google.com with SMTP id b6so3363075yha.14
        for <git@vger.kernel.org>; Sat, 02 Aug 2014 11:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QSuhWbQAkcvTHk4uP6Q/5VIjdcSVgJwHj65E41kqB+M=;
        b=PiEVvVjcKwxnfclCl+Qqg4RH0c+AeljXJ3kPn7O5/jQr8OfZcOi35chv5C4ueptufE
         kmhpj2uyByflyHH9g7afnyuL9hQVnJK17/S/1pQjPa2aHyqsVy5bH+8dpPtP6pLG6aeb
         a9nie53Pyli5o5qf7mW6ffEzSEGklsO/LFKOwSBCTZFrxmYj1pSXnXqI3gq6b8k57/Gn
         8jeANRB5hIBcvkF584wgBwWq/nooYbOmH7oU9GDQHA4kKyoVOIX1zTa5TKWhNtwb3tjc
         nBegUhNPJi8jg/JLbvQaUaNEAMpBgrybOHdFSFEgpURDuKt/NsUuX4AQaBPDld7dBy4m
         ptjg==
X-Received: by 10.236.23.163 with SMTP id v23mr20425684yhv.58.1407002881316;
        Sat, 02 Aug 2014 11:08:01 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id i24sm20618668yha.12.2014.08.02.11.07.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Aug 2014 11:08:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.3
In-Reply-To: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254710>

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index bf0a7ae..96d6e67 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -108,8 +108,8 @@ By default, the configuration flag 'receive.denyNonFastForwards' is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
-If you name a (possibly non-existent) directory at the end of the command
-line, the command is run inside the directory (possibly after creating it).
+If you provide a 'directory', the command is run inside it. If this directory
+does not exist, it will be created.
 
 --
 
-- 
2.0.3

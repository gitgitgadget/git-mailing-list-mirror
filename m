From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 3/4] Documentation/config.txt: clarify that pull.ff overrides merge.ff
Date: Wed, 13 May 2015 17:52:19 +0800
Message-ID: <1431510740-9710-4-git-send-email-pyokagan@gmail.com>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:53:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsTM5-0004XL-WA
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbbEMJx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:53:27 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33823 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbbEMJxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:53:25 -0400
Received: by pdbqa5 with SMTP id qa5so46490843pdb.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9tDsWHlo7KPJJ9XqFMjRm33XzIu70Y6rrTJuKJfnGzY=;
        b=Z8hpWEaoDXrhqjGHtHSjPk61J9bblQUlIVu8kHPdPZIcyyTCnENCFGZ35EfKIUxFWF
         O0Ar+0WLpR85kwOkWzKSnLNv6U7hasVcy3JGV1DpCQzXOwHRerhhlM7KsHgdW84wTzMH
         Zn3Hz8YsShlxA3JxVfMBp/8a2ITY3rT/p4QnpejGNRPIUAJv3w1yQInhz/6zrk1ySWri
         RFOWcxiKrHTdDHU1pLZq1R7oSJ1Pqfh/EDEtJKlQLCoagsHXiMQHoVa8Bn39UUqQt7Va
         6j9vR9r5qYIuYdszq1pCfm7O8+gTud3S+n6SxUr6uuk+4fSPGxuNWuOxD2AOLERU2U0B
         x3Lg==
X-Received: by 10.68.250.194 with SMTP id ze2mr36378454pbc.24.1431510804790;
        Wed, 13 May 2015 02:53:24 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id k3sm18777927pdr.50.2015.05.13.02.53.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:53:23 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268970>

Since the pull.ff setting was implemented in b814da8 (pull: add pull.ff
configuration, 2014-01-15) pull.ff has always overridden merge.ff,
although not mentioned in the documentation.

As such, clarify that this is so.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 948b8b0..ec0f9ef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2042,7 +2042,7 @@ pull.ff::
 	a case (equivalent to giving the `--no-ff` option from the command
 	line). When set to `only`, only such fast-forward merges are
 	allowed (equivalent to giving the `--ff-only` option from the
-	command line).
+	command line). This setting overrides `merge.ff` when pulling.
 
 pull.rebase::
 	When true, rebase branches on top of the fetched branch, instead
-- 
2.1.4

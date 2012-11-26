From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] Fix typo in remote set-head usage
Date: Mon, 26 Nov 2012 20:21:54 +0100
Message-ID: <1353957714-7330-1-git-send-email-apelisse@gmail.com>
References: <7vwqx8rzzf.fsf@alter.siamese.dyndns.org>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 20:25:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td4J0-0000yP-G7
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 20:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab2KZTZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 14:25:04 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:42564 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab2KZTZC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 14:25:02 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so3792356wib.1
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 11:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sIHlhamwuijPnH9/1RnWnHcE1vPCsQo3fYTL3p8UGK0=;
        b=w/dN6TNqor8aS+oH+CiLSEknrk/DcdzzNiqZBsmD3cuh0EM+mdzHsFI22fSp1hhVGg
         1BHT2M69Xynykpjh3Na2Tpqq4CfNDL3Q40dj+rjkOzP8KGdCIwGfMIxjZiRpyaF6K2ky
         qTkhp91Xj5kWAuFJXPHu2e1I57Ahq1w5BtjZOUJQmyGuZG2jYfwdyaV9atkPf0wBMr2x
         iYyZJ7iwor/vztxu2+jmkvIEo+Xvd8I83ddyzG8cIq9BWttpTB7m9kx6n8OiI4R3zOO3
         noaFoXEKYuc1xvt+w80rmuxdjsinyqMPqQrNJwKwcg8FpBOvZHBw8MuJ5ac3kKh4AKru
         N7fA==
Received: by 10.216.206.154 with SMTP id l26mr4816911weo.68.1353957901804;
        Mon, 26 Nov 2012 11:25:01 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bd7sm359347wib.8.2012.11.26.11.24.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Nov 2012 11:25:00 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vwqx8rzzf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210471>

parenthesis are not matching in `builtin_remote_sethead_usage`
as a square bracket is closing something never opened.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 builtin/remote.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index a5a4b23..937484d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -39,7 +39,7 @@ static const char * const builtin_remote_rm_usage[] = {
 };
 
 static const char * const builtin_remote_sethead_usage[] = {
-	N_("git remote set-head <name> (-a | -d | <branch>])"),
+	N_("git remote set-head <name> (-a | -d | <branch>)"),
 	NULL
 };
 
-- 
1.7.9.5

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/6] CodingGuidelines: mention whitespace preferences for shell scripts
Date: Mon, 29 Nov 2010 15:47:50 +0100
Message-ID: <1291042075-19983-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 15:55:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN58N-0003kS-2s
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 15:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab0K2OzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 09:55:09 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60031 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0K2OzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 09:55:08 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so4505128wyb.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 06:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YVtxigsAt701jprdtacciH2wVapQ2w8flSithTuEwHo=;
        b=c1vsMFU0Oz6fXRkdE3SzE4YF6iRxS3YB2yCqoAJFFzXKgA9y9/yN2xNw2Nz8VKamAo
         g7R1K4tF2WbvGL+eXFAcllniHQGePFRDQ6m5QGNefo4/ol07Op7r+0jpCQOmWDT+86k+
         Pa9ayc40aP3WHogBDluH+fMI5/ZUB62Er4LVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=o8Da8xiCm4nWV8Tv33bENqwU23oxkkCJGXk8h28gdi2Qi8BNAetufbzlYFAIknVr5y
         rxnrmyVF2XVuufV12X5U/8fhz9X0NzyPT7NRmCA6fmlNyCQR2zDWuoQeIoZ1yWbeeEIs
         06wqMPBAdtFXbUwYKoE9c2uhvwwEL3miisQA0=
Received: by 10.227.39.210 with SMTP id h18mr6058565wbe.75.1291042089852;
        Mon, 29 Nov 2010 06:48:09 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id w41sm2425374weq.32.2010.11.29.06.48.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 06:48:08 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.624.gec6c7.dirty
In-Reply-To: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162393>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/CodingGuidelines |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 5aa2d34..7ecce51 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -31,6 +31,12 @@ But if you must have a list of rules, here they are.
 
 For shell scripts specifically (not exhaustive):
 
+ - We use tabs for indentation.
+
+ - The choices in case ... esac statement are not indented with respect
+   to the the case and esac lines. The body of the choices however _is_
+   indented (by one tab).
+
  - We prefer $( ... ) for command substitution; unlike ``, it
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
-- 
1.7.3.2.624.gec6c7.dirty

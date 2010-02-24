From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 10/10] transport: update flags to be in running order
Date: Wed, 24 Feb 2010 20:50:29 +0800
Message-ID: <1267015829-5344-11-git-send-email-rctay89@gmail.com>
References: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@googlemail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:51:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkGi6-0005M5-Sp
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab0BXMvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:51:14 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64550 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844Ab0BXMvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:51:11 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so338835qyk.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7O/PrAYgiXaNwyUwGQDIMNUr+7v0oczM0rI8Pfa+k4k=;
        b=ij5wkN69mnRgdFGwpJx73XZn5Thm1WgnlQhEIl6hdr2plZrHwHVbzSnMabOC0yGoca
         /SiCq50XKfDuQ4Lfp1XeZni5+mcLuOKZcMjj/ZW6Gmi2FYxb+SPA32Eb3DGyJvs3Po3z
         YW9R4suj5MfVjtyE6dubuE1m3sFdXjRL8iHok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n2pwVNVjCb2bqfkDtfiK8cbsz9GeZNsjxQuW5jgOgrgvK3AMXGpnIVFiqL6zxCwmt7
         0BRUI8VSy47uDQ/ZDYICZiHkj7XyWwiguBCauWQgil4aiIOUCunhkZf4ro6NDGw9U6IE
         H0qSANLLbAdAta/HT/T/ipfzaid1mkbddKjnc=
Received: by 10.224.87.159 with SMTP id w31mr7672319qal.50.1267015871092;
        Wed, 24 Feb 2010 04:51:11 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 23sm253680qyk.15.2010.02.24.04.51.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 04:51:10 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1267015829-5344-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140937>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changes from v1:
  - Rebased on git/next and resolved a conflict with the recent
    refactoring of print_push_status() in transports.

 transport.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport.h b/transport.h
index 531731e..c61aacf 100644
--- a/transport.h
+++ b/transport.h
@@ -99,8 +99,8 @@ struct transport {
 #define TRANSPORT_PUSH_FORCE 2
 #define TRANSPORT_PUSH_DRY_RUN 4
 #define TRANSPORT_PUSH_MIRROR 8
-#define TRANSPORT_PUSH_PORCELAIN 32
-#define TRANSPORT_PUSH_SET_UPSTREAM 128
+#define TRANSPORT_PUSH_PORCELAIN 16
+#define TRANSPORT_PUSH_SET_UPSTREAM 32
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)

 /* Returns a transport suitable for the url */
--
1.7.0.20.gcb44ed

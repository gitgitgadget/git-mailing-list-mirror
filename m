From: iheffner@gmail.com
Subject: [PATCH 1/3] add constants for sideband communication channels
Date: Tue, 13 Dec 2011 10:28:49 -0800
Message-ID: <1323800931-37123-2-git-send-email-iheffner@gmail.com>
References: <1323800931-37123-1-git-send-email-iheffner@gmail.com>
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Dave Olszewski" <cxreg@pobox.com>,
	Ivan Heffner <iheffner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 19:29:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaX6o-0001Wb-5R
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 19:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068Ab1LMS3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 13:29:42 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55547 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab1LMS3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 13:29:41 -0500
Received: by mail-ey0-f174.google.com with SMTP id j10so1367623eaa.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 10:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FGnHlIn4dTbqmVmYX8QHHn4MISNnZbgGk4Gz7mvTnlY=;
        b=XhcOFHUARcfOqv5S17Z6MmpAwxwxccsYGf6uUyxmYp+0WM0TAHk1PjjfspPsGfuL1I
         8epSnwkV7Qp0uWOFMlt8UhW+zuXhzPBLyEM0kI1hOpzLhIcL0OiQxzob+UzdGOGuAgrd
         XPS/aENdMFcfwB3JVVNpSEnl9sjM0zcwYzELE=
Received: by 10.204.133.213 with SMTP id g21mr10149598bkt.126.1323800980786;
        Tue, 13 Dec 2011 10:29:40 -0800 (PST)
Received: from localhost.localdomain (sea02-v612-nat.marchex.com. [174.137.113.43])
        by mx.google.com with ESMTPS id 39sm1014563eei.1.2011.12.13.10.29.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 10:29:40 -0800 (PST)
X-Mailer: git-send-email 1.7.6.553.g917d7.dirty
In-Reply-To: <1323800931-37123-1-git-send-email-iheffner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187038>

From: Ivan Heffner <iheffner@gmail.com>

Add constants for sideband channel identifiers.

* SIDEBAND_CHAN_PACK     => 1
* SIDEBAND_CHAN_PROGRESS => 2
* SIDEBAND_CHAN_ERROR    => 3

Signed-off-by: Ivan Heffner <iheffner@gmail.com>
---
 sideband.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sideband.h b/sideband.h
index d72db35..2954979 100644
--- a/sideband.h
+++ b/sideband.h
@@ -2,7 +2,11 @@
 #define SIDEBAND_H
 
 #define SIDEBAND_PROTOCOL_ERROR -2
-#define SIDEBAND_REMOTE_ERROR -1
+#define SIDEBAND_REMOTE_ERROR   -1
+#define SIDEBAND_CHAN_PACK       1
+#define SIDEBAND_CHAN_PROGRESS   2
+#define SIDEBAND_CHAN_ERROR      3
+
 
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
-- 
1.7.6.553.g917d7.dirty

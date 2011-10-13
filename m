From: mhagger@alum.mit.edu
Subject: [PATCH 02/14] struct ref_list: document name member
Date: Thu, 13 Oct 2011 09:58:23 +0200
Message-ID: <1318492715-5931-3-git-send-email-mhagger@alum.mit.edu>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 09:59:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REGCW-00021H-50
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 09:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab1JMH7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 03:59:04 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:34339 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab1JMH7D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 03:59:03 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1REG6L-0002Mo-UP; Thu, 13 Oct 2011 09:53:13 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183454>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 409314d..e4e4bcd 100644
--- a/refs.c
+++ b/refs.c
@@ -12,6 +12,7 @@ struct ref_entry {
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
 	unsigned char sha1[20];
 	unsigned char peeled[20];
+	/* The full name of the reference (e.g., "refs/heads/master"): */
 	char name[FLEX_ARRAY];
 };
 
-- 
1.7.7.rc2

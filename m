From: mhagger@alum.mit.edu
Subject: [PATCH v2 02/14] struct ref_entry: document name member
Date: Mon, 17 Oct 2011 09:39:11 +0200
Message-ID: <1318837163-27112-3-git-send-email-mhagger@alum.mit.edu>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:39:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhnV-0007hN-NU
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab1JQHjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:39:40 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33557 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab1JQHji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:39:38 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhT-0000eM-A9; Mon, 17 Oct 2011 09:33:31 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183772>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index d8a4fa3..68e10eb 100644
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

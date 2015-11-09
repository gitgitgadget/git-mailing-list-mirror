From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 01/11] refs: make is_branch public
Date: Mon,  9 Nov 2015 18:03:38 +0100
Message-ID: <39e0a2a708fb1a42b69e45bc5c0b17d565d3662e.1447085798.git.mhagger@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:04:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvprf-0007ey-Fm
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbbKIREM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:04:12 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50061 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460AbbKIREJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 12:04:09 -0500
X-AuditID: 12074411-f797e6d000007df3-86-5640d206facb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.74.32243.602D0465; Mon,  9 Nov 2015 12:04:06 -0500 (EST)
Received: from michael.fritz.box (p4FC97689.dip0.t-ipconnect.de [79.201.118.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA9H41Yo026059
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Nov 2015 12:04:05 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447085798.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1GW75BBmML9Xx2L+phOMFl1Xupks
	GnqvMFtMmnKTyeL2ivnMFj9aepgtevs+sVr8m1DjwOHx9/0HJo+ds+6yeyzYVOpx9mCmx7Pe
	PYweFy8peyx4fp/d4/MmuQCOKG6bpMSSsuDM9Dx9uwTujK4le9kLLrBVXLhm0cB4kLWLkYND
	QsBEom+6fBcjJ5ApJnHh3nq2LkYuDiGBy4wS3bc2s0A4J5gkjlyawghSxSagK7Gop5kJxBYR
	UJOY2HYIrIhZYCGTxMrNe8ASwgKmEv+mzGYC2cAioCqxa7YbiMkrECXx/0c6xDI5iSn328Gq
	OQUsJHac+Ac2XkjAXGLiqjVMExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzR
	S00p3cQICULBHYwzTsodYhTgYFTi4WWYbh8mxJpYVlyZe4hRkoNJSZQ3+oRDmBBfUn5KZUZi
	cUZ8UWlOavEhRgkOZiUR3oJdQDnelMTKqtSifJiUNAeLkjgv3xJ1PyGB9MSS1OzU1ILUIpis
	DAeHkgTvpgtAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgqIgvBsYFSIoHaO8O
	kHbe4oLEXKAoROspRl2OBT9ur2USYsnLz0uVEucVvwhUJABSlFGaB7cClnJeMYoDfSzMawBS
	xQNMV3CTXgEtYQJastQfbElJIkJKqoFx7oG8Q50zzV1mWaZV1Hgpb3vx4DvzF/GA05lqCxwm
	u/D7SF+96pzz5v3x6a7vSy9GVHmYfn9oeuPlj9lXRR6H7TOzVl7GciX2c7HwmdWy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281058>

From: David Turner <dturner@twopensource.com>

is_branch was already non-static, but this patch declares it in the
header.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.h b/refs.h
index 6d30c98..39b8edc 100644
--- a/refs.h
+++ b/refs.h
@@ -217,6 +217,8 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
  */
 int pack_refs(unsigned int flags);
 
+int is_branch(const char *refname);
+
 /*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
-- 
2.6.2

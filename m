From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/23] get_expanded_map(): add docstring
Date: Wed, 30 Oct 2013 06:32:56 +0100
Message-ID: <1383111192-23780-8-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:34:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOQF-0005r4-Oc
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab3J3FeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:34:15 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42505 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752433Ab3J3FeI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:34:08 -0400
X-AuditID: 12074414-b7fb46d000002a4d-ed-52709a4ff157
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.5E.10829.F4A90725; Wed, 30 Oct 2013 01:34:07 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbII014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:05 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqOs/qyDIoOO7nsX0rtUsFl1Xupks
	GnqvMFvMu7uLyWLVrWXMFitn3GC0uL1iPrPF085Ki3kvXrBZ/GjpYXbg8vj7/gOTx6V1L5k8
	Dv2Zwu7x7EQ7m8ell9/ZPJ717mH0uHhJ2WNGy2sWj8+b5DwOXH7MFsAVxW2TlFhSFpyZnqdv
	l8Cd8WjBJraCSWwVX5aoNjC+Y+li5OSQEDCR+LCknwnCFpO4cG89G4gtJHCZUaLpSGUXIxeQ
	fYVJovX4EmaQBJuArsSinmawBhEBNYmJbYdYQIqYBSYySxyfvgjI4eAQFrCWWDmFG6SGRUBV
	4tTMz2BDeQVcJOafmQ21WEHiRvNUVhCbU8BV4tOum+wQi10kmto/s09g5F3AyLCKUS4xpzRX
	NzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIyRkRXYwHjkpd4hRgINRiYe341F+kBBrYllx
	Ze4hRkkOJiVR3rQpBUFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHinHwcq501JrKxKLcqHSUlz
	sCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4FWeCTRUsCg1PbUiLTOnBCHNxMEJIrhANvAA
	beABKeQtLkjMLc5Mhyg6xagoJc47FyQhAJLIKM2DGwBLLq8YxYH+EYZo5wEmJrjuV0CDmYAG
	72HJAxlckoiQkmpglFlycNvLrbM+Jz2RNv5Y+md/f6LQxkPcGrdli6qOvt6xoeDJywmB9xRE
	92z94ZcrJ5JrGrFLJD3ih1XbDbaWNbxOuxaFGFxOvG6m9Uml8NddJuEDMkdUDqet 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236962>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/remote.c b/remote.c
index 9f1a8aa..0d082cd 100644
--- a/remote.c
+++ b/remote.c
@@ -1553,6 +1553,13 @@ static int ignore_symref_update(const char *refname)
 	return (flag & REF_ISSYMREF);
 }
 
+/*
+ * Create and return a list of (struct ref) consisting of copies of
+ * each remote_ref that matches refspec.  refspec must be a pattern.
+ * Fill in the copies' peer_ref to describe the local tracking refs to
+ * which they map.  Omit any references that would map to an existing
+ * local symbolic ref.
+ */
 static struct ref *get_expanded_map(const struct ref *remote_refs,
 				    const struct refspec *refspec)
 {
-- 
1.8.4.1

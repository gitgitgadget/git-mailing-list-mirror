From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 22/23] handle_duplicate(): mark error message for translation
Date: Wed, 30 Oct 2013 06:33:11 +0100
Message-ID: <1383111192-23780-23-git-send-email-mhagger@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Wed Oct 30 06:42:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXX-0007VK-IW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab3J3Fl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:56 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49294 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753197Ab3J3Flx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:53 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 01:41:53 EDT
X-AuditID: 12074411-b7f426d000005455-7e-52709a733bc4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 31.DA.21589.37A90725; Wed, 30 Oct 2013 01:34:43 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIX014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:41 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqFs8qyDI4MY/K4vpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7Y+a1Z0wFl1gqpk7+zdLA+Ii5i5GTQ0LAROJ0z2UmCFtM4sK99WxdjFwcQgKXGSUu3DjN
	DuFcYZL4OXExK0gVm4CuxKKeZrAOEQE1iYlth1hAipgFJjJLHJ++iAUkISwQIHHj2CKwBhYB
	VYlNpyaB2bwCrhJrZ/yFWqcgcaN5KlicEyj+addNdhBbSMBFoqn9M/sERt4FjAyrGOUSc0pz
	dXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MUICV3AH44yTcocYBTgYlXh4DR7kBwmxJpYV
	V+YeYpTkYFIS5U2bUhAkxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3+nGgct6UxMqq1KJ8mJQ0
	B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBK/yTKChgkWp6akVaZk5JQhpJg5OEMEFsoEH
	aAMPSCFvcUFibnFmOkTRKUZFKXFeBZCEAEgiozQPbgAsxbxiFAf6RxiinQeYnuC6XwENZgIa
	vIclD2RwSSJCSqqBsYy1VqIkkNNxQ87FL5ERDQtKN/5KvXL+j1hDQG7F3prvZzodbTat4nGa
	Ey4rdnPSpwVBS4Wcfy7vvLxN807m6d+Hb3/vDrm/5XFmkJoKSz2njC/vqvSSluzE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236975>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 2deb2db..06a0eda 100644
--- a/remote.c
+++ b/remote.c
@@ -748,7 +748,7 @@ int for_each_remote(each_remote_fn fn, void *priv)
 static void handle_duplicate(struct ref *ref1, struct ref *ref2)
 {
 	if (strcmp(ref1->name, ref2->name))
-		die("%s tracks both %s and %s",
+		die(_("%s tracks both %s and %s"),
 		    ref2->peer_ref->name, ref1->name, ref2->name);
 	free(ref2->peer_ref);
 	free(ref2);
-- 
1.8.4.1

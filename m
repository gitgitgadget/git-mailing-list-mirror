From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/13] entry_resolves_to_object(): rename function from ref_resolves_to_object()
Date: Fri,  3 Jun 2016 14:33:47 +0200
Message-ID: <1d91b1d9f970184ac2d117c9d92379725f468d8d.1464957077.git.mhagger@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:34:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oJ3-0005H2-DW
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbcFCMeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 08:34:17 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43782 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932393AbcFCMeO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:14 -0400
X-AuditID: 1207440d-bc7ff7000000090b-92-575179452c03
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 73.B1.02315.54971575; Fri,  3 Jun 2016 08:34:13 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtir005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:34:11 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqOtaGRhusPSEvMX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDNmrfzNXNDIXdEzbTVLA+Mnji5G
	Tg4JAROJ9w3nmbsYuTiEBLYySkyd8JIVwjnOJHH81xd2kCo2AV2JRT3NTCC2iECERMOrFkaQ
	ImaBOUwStx92MoMkhAWSJfb1fAJrYBFQlXhxcQMbiM0rECXRP2kmC8Q6OYnL0x+AxTkFLCT6
	7v0AqxcSMJd4OGc3+wRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJTSjcx
	QsKOdwfj/3UyhxgFOBiVeHgZFgeEC7EmlhVX5h5ilORgUhLlPX8WKMSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmE909BYLgQb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC
	17wCqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFAXxxcA4AEnxAO2tAGnnLS5I
	zAWKQrSeYlSUEucVBkkIgCQySvPgxsKSyStGcaAvhXl9QKp4gIkIrvsV0GAmoMEFj/xBBpck
	IqSkGhjj3bT71+T1cCjdZbcLyYpOPH9faBaHoKjz51s21l6ODryXvYTu8Pod+3vi0o0o+YiT
	4Xv3z3TcPaeKtX2R6Ju3j7zNYpT2lG/RaJh2/8O3F6L+Bap99gfVqm9c3vByWftP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296323>

Free up the old name for a more general purpose.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 142c977..1a46f32 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -517,7 +517,7 @@ static void sort_ref_dir(struct ref_dir *dir)
  * an object in the database.  Emit a warning if the referred-to
  * object does not exist.
  */
-static int ref_resolves_to_object(struct ref_entry *entry)
+static int entry_resolves_to_object(struct ref_entry *entry)
 {
 	if (entry->flag & REF_ISBROKEN)
 		return 0;
@@ -563,7 +563,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 		return 0;
 
 	if (!(data->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-	      !ref_resolves_to_object(entry))
+	      !entry_resolves_to_object(entry))
 		return 0;
 
 	/* Store the old value, in case this is a recursive call: */
@@ -2228,7 +2228,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 		return 0;
 
 	/* Do not pack symbolic or broken refs: */
-	if ((entry->flag & REF_ISSYMREF) || !ref_resolves_to_object(entry))
+	if ((entry->flag & REF_ISSYMREF) || !entry_resolves_to_object(entry))
 		return 0;
 
 	/* Add a packed ref cache entry equivalent to the loose entry. */
-- 
2.8.1

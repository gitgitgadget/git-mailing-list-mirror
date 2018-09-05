Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECDA1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 16:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeIEVS5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:18:57 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:43288 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbeIEVS4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Sep 2018 17:18:56 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85GghiG025766;
        Wed, 5 Sep 2018 09:47:55 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2m7qnmqc54-1;
        Wed, 05 Sep 2018 09:47:55 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 61DC922901E6;
        Wed,  5 Sep 2018 09:47:55 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 59E3B2CDE77;
        Wed,  5 Sep 2018 09:47:55 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-recursive: remove superfluous semicolon
Date:   Wed,  5 Sep 2018 09:47:53 -0700
Message-Id: <20180905164753.22711-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.1.g7fc77f67e1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050170
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Once I saw it, I couldn't unsee it, and it quickly started getting on my
nerves...  My bad for not noticing it when reviewing the original patch
that introduced it, I guess -- 9da2d0379ea0 ("merge-recursive: use
xstrdup() instead of fixed buffer", 2018-06-10)

 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e5243dbc54..1b5c255918 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2239,7 +2239,7 @@ static struct dir_rename_entry *check_dir_renamed(c=
onst char *path,
 {
 	char *temp =3D xstrdup(path);
 	char *end;
-	struct dir_rename_entry *entry =3D NULL;;
+	struct dir_rename_entry *entry =3D NULL;
=20
 	while ((end =3D strrchr(temp, '/'))) {
 		*end =3D '\0';
--=20
2.19.0.rc2.1.g7fc77f67e1


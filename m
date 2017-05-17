Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5991C201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbdEQMGH (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:07 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:57187 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752038AbdEQMGD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:03 -0400
X-AuditID: 12074414-059ff70000004f50-d0-591c3ca9ae1a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F2.CF.20304.9AC3C195; Wed, 17 May 2017 08:06:01 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pfs000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:05:59 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/23] ref_iterator_begin_fn(): fix docstring
Date:   Wed, 17 May 2017 14:05:26 +0200
Message-Id: <da4669a209fa1aafe6a8e3ae8082963a338b1da8.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqLvSRibSoOsUp8XaZ3eYLLqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpR1f7ETaP
        Z717GD0uXlL2+LxJLoA9issmJTUnsyy1SN8ugSujc8EspoKNXBUzV9xnb2C8yNHFyMkhIWAi
        MfvjMuYuRi4OIYEdTBL7t/9hhHBOMEm07uxgBqliE9CVWNTTzARiiwioSUxsO8QCUsQs8JhJ
        4u+ybhaQhLCArcTDg03sXYwcHCwCqhJ9D7VBwrwCURJ/385ngtgmL7Gr7SIriM0pYCFx//0j
        sHIhAXOJ7dcrJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokREmgi
        OxiPnJQ7xCjAwajEw2vBIR0pxJpYVlyZe4hRkoNJSZR3/wOgEF9SfkplRmJxRnxRaU5q8SFG
        CQ5mJRHem6YykUK8KYmVValF+TApaQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8U6yB
        GgWLUtNTK9Iyc0oQ0kwcnCDDeYCGc4HU8BYXJOYWZ6ZD5E8xKkqJ8x4ASQiAJDJK8+B6YYng
        FaM40CvCvGYgVTzAJALX/QpoMBPQ4GaQj3iLSxIRUlINjLVejslx05ILj/N8ndWle0rWNr79
        k2evjNZTq/TnDsciDonlbpcqzZ864fdU/ellb1c6Rsc4vz1/5vTRF0f3zlI/0Lun0EfjWIH5
        nl7eA/HzOZ2ypNNLniUFeL5SO71zpmEYT/NyfRkLidUrFNZ1pwT4Xkw+s98q48WC9nmLf0zT
        u5040WcfuxJLcUaioRZzUXEiAEZQYynfAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The iterator returned by this function only includes references whose
names start with the whole prefix, not all of those in
`find_containing_dir(prefix)` as the old docstring claimed. This
docstring was probably copy-pasted from old ref-cache code, which had
the old specification. But now, `cache_ref_iterator_begin()`
(from which the files reference iterator gets its values)
automatically wraps its output using `prefix_ref_iterator_begin()`
when necessary, so it has the stricter behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/refs-internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 12cf4e4718..e5f6bb2047 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -515,8 +515,8 @@ typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *logmsg);
 
 /*
- * Iterate over the references in the specified ref_store that are
- * within find_containing_dir(prefix). If prefix is NULL or the empty
+ * Iterate over the references in the specified ref_store whose names
+ * start with the specified prefix. If prefix is NULL or the empty
  * string, iterate over all references in the submodule.
  */
 typedef struct ref_iterator *ref_iterator_begin_fn(
-- 
2.11.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08161FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964814AbdAFQXB (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:01 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46905 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935924AbdAFQXA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:00 -0500
X-AuditID: 1207440c-e3bff700000009a1-e7-586fc45e7183
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E8.00.02465.E54CF685; Fri,  6 Jan 2017 11:22:54 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmWp023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:22:52 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 01/23] files_rename_ref(): tidy up whitespace
Date:   Fri,  6 Jan 2017 17:22:21 +0100
Message-Id: <129f09835a10512ad532ff9521a1b279994324ff.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqBt3JD/CYO1jNouuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKODVzLVNBG2vFxCs/mBsY+1i6GDk5JARMJF58+MQK
        YgsJXGaUuHYzuYuRC8g+wSRx7vFSNpAEm4CuxKKeZiYQW0RATWJi2yEWkCJmgQ+MEr86Z7GD
        JIQFHCTmdS0Cs1kEVCU+tG0H28ArECWx6vEEqG1yEpe2fWEGsTkFLCQad31jhNhsLvFp4mHm
        CYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEBBjPDsZv62QOMQpw
        MCrx8EZ45UUIsSaWFVfmHmKU5GBSEuUNc8yPEOJLyk+pzEgszogvKs1JLT7EKMHBrCTC274X
        KMebklhZlVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQkuC9fxCoUbAoNT21Ii0z
        pwQhzcTBCTKcB2j4KpAa3uKCxNzizHSI/ClGXY4D71c8ZRJiycvPS5US57UHKRIAKcoozYOb
        A0sMrxjFgd4S5n0MUsUDTCpwk14BLWECWiLoCbakJBEhJdXAuODvs8Tk0+zthXpNbis2FBju
        3Zvts/DPx/k+FnN3nvp4fe5Sm4YXLwoPKtW+dQgV/BB5NNhSbF/J/N32k++UPpl4IVZy2n9j
        Of288sYFFZtv2F9efK/88Xr32JcpuXET7rxV4Vz4kDvy5iQNofqdlRIqG/JW/9da11CR1Fly
        aubhln1Xj6zNUlNiKc5INNRiLipOBABEVK1a5wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f902393..be4ffdc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2631,7 +2631,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	if (!read_ref_full(newrefname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 			   sha1, NULL) &&
 	    delete_ref(newrefname, NULL, REF_NODEREF)) {
-		if (errno==EISDIR) {
+		if (errno == EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
 
-- 
2.9.3


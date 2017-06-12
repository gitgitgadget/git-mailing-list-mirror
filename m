Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6380A1FA7B
	for <e@80x24.org>; Mon, 12 Jun 2017 08:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbdFLIG0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 04:06:26 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49171 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750730AbdFLIGZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Jun 2017 04:06:25 -0400
X-AuditID: 12074413-d7bff7000000742e-a6-593e4b7f1b24
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id CB.F9.29742.F7B4E395; Mon, 12 Jun 2017 04:06:23 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCC5.dip0.t-ipconnect.de [87.188.204.197])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5C86Ic4002255
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 12 Jun 2017 04:06:20 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/1] Fix for mh/packed-ref-store-prep
Date:   Mon, 12 Jun 2017 10:06:12 +0200
Message-Id: <cover.1497253685.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqFvvbRdpcOCApcXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WTuXeZLW6vmM9sseTha2aL7ilvGS1+tPQwW2ze3M7iwOXx9/0HJo+ds+6y
        eyzYVOrx8FUXu0dX+xE2j2e9exg9Ll5S9vi8SS6AI4rLJiU1J7MstUjfLoEro2FnH2PBNZaK
        GS1nmRoYXzB3MXJySAiYSNx53cPSxcjFISSwg0ni5oTzbCAJIYFTTBLrlymD2GwCuhKLepqZ
        QGwRATWJiW2HwBqYBTYwS7yZvhosISxgKnF6420wm0VAVeL3nLtgNq+AucS+4ydZIbbJS+xq
        u8g6gZFrASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQwBLewbjrpNwh
        RgEORiUe3oS9tpFCrIllxZW5hxglOZiURHm3XLGJFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
        e8/DLlKINyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBq+IF1ChYlJqe
        WpGWmVOCkGbi4AQZzgM0fI8nyPDigsTc4sx0iPwpRl2Opg9bvjAJseTl56VKifOKgAwSACnK
        KM2DmwNLCK8YxYHeEua9AVLFA0wmcJNeAS1hAlpyHeQ73uKSRISUVAOjs8zJ2Y/vfJb22q4j
        GKj9r05BKrZJUftgyP6SlxMcQmT5pL5LsK+Pmi9xQDFU3PakbN3WNINejiLhiaqiyaYbXTv+
        z7p3+hhbOhd33Nxfe2RvhK5tf5gsezfzScYifuZpKsv3Kv7ePcmuVvb1v5TKXvdFPJ+P2m5R
        tWb+zMW/9E/Rf6HMo+xKLMUZiYZazEXFiQDE8qyN4wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When preparing a new patch series, I noticed a bug that crept into
mh/packed-ref-store-prep while I was shuffling patches around. It
introduces a race condition if another process rewrites the
`packed-refs` file just before we lock it. See the commit message for
more information.

This patch applies on top of mh/packed-ref-store-prep and merges to
master without problems.

Michael

Michael Haggerty (1):
  lock_packed_refs(): fix cache validity check

 refs/files-backend.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

-- 
2.11.0


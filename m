Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBEA21FDEA
	for <e@80x24.org>; Tue,  9 May 2017 12:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbdEIMyk (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 08:54:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:52413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753210AbdEIMyi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 08:54:38 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRXSK-1dahMm3jmi-00ShKK; Tue, 09
 May 2017 14:54:33 +0200
Date:   Tue, 9 May 2017 14:54:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 6/6] t4051: mark supporting files as requiring LF-only
 line endings
In-Reply-To: <cover.1494334366.git.johannes.schindelin@gmx.de>
Message-ID: <d69519e027904fd0e109b2a50c627b839aa9889a.1494334366.git.johannes.schindelin@gmx.de>
References: <cover.1493891336.git.johannes.schindelin@gmx.de> <cover.1494334366.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T4m/iK+erp+Q6g0nIKktyoB8F8EoT5uKDxUieGSWuiBArKJH6kU
 WGhwTP/6LsUlLgWCzYz55+8VkDBZWDrNcY85u13kGvQczZyjXdDXZd9gAj8I5UWN+/QFS8O
 0DbpA7kJ5TU5Z5BxygG4TLUw56oeG3OO0G4NZNIH9a+oCPZ3YQ6v27lCzDo9GTUjUv45lKU
 oBvFWuC+QlVlyjvtISikg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p+wPPqVIzk4=:ciHDO+pQ562hXgHYhX1lDL
 OTpXETvC8mKamQcg6zmi+HoqNB645mWl9PgSK/0JMOfkXkCKtivgRsco+ZwVlGnflSt7y6gon
 TxGnrpYPRkrTCBE4KPC8ZsIs+kc+qR/5dOByqsfSPvFCTtpxvhCI4AQJf7BksmgD2/pf/7Tl9
 xR7qMrqeFRRtrbiEdm1N1UcwBMtYPFTmZG9sMc2rVB8+kvQCOyzp7OgPf77NQkquk5+AzoeuA
 lEN3SLoepO5mu2GTnvXmpR5gwbV8DCczvVQ3OhBqgo8eRwE0+5S04OloiQ+cuv9Ji6Nnfb1wP
 pcphMHELmvqBQOORzizk3VCvEr3moKh7Fz25OywsQo1YrV0lfgM30s9YrdP5lbX4P4PWpHKZT
 RxA0BPRfiFx0+TnjhbFs6zI/4hG0qPz3fhKLLNCVhb02ziPbLfJc0ml6MSUOPn/SNpCV6R2Ew
 kwuFHxWdwxcPE10LJtZbjBx8uaWSB+A7SaibebdVt512+woGk0CB6yia2vT1/wqOrcjYl5urT
 lB2q1yM7yUgtu1QsS3KeUxsbEtCz8x+HgD9qPcWQ+zTKMd0QgVCkUNaETvOPtLzNtelKkZJRr
 50S9ft6jkUwiGmZW3liyvP7jrpZtP8kM9YUjxoh1a3GetGtQuCYLpmwdSPHG5V99nXdUqNdGR
 d5i97UVLEN6qHUHkcdWJk/2TO2noo1XATMB9Gr81uTy3fT/93MwQmTr96sLNsZiNbAvNgG4y7
 ZV8GjmQ41EOjL1fAFyLG+K2YJKhAOk4cOAYN7pT3eA6TTTrxxlGn06ICOm32DjS92/TBjqbbR
 Bh+wyeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test t4051-diff-function-context.sh passes on Linux when
core.autocrlf=true even without marking its support files as LF-only,
but they fail when core.autocrlf=true in Git for Windows' SDK.

The reason is that `grep ... >file.c.new` will keep CR/LF line endings
on Linux (obviously treating CRs as if they were regular characters),
but will be converted to LF-only line endings with MSYS2's grep that is
used in Git for Windows.

As we do not want to validate the way the available `grep` works, let's
just mark the input as LF-only and move on.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/.gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/.gitattributes b/t/.gitattributes
index 11e5fe37281..3bd959ae523 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -6,6 +6,7 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t4034/*/* eol=lf
 /t4013/* eol=lf
 /t4018/* eol=lf
+/t4051/* eol=lf
 /t4100/* eol=lf
 /t4101/* eol=lf
 /t4109/* eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06

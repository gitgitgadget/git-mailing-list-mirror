Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909E71F790
	for <e@80x24.org>; Tue,  2 May 2017 12:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdEBMbC (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:31:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:56300 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbdEBMbA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:31:00 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1FAK-1duBjc38W0-00tC15; Tue, 02
 May 2017 14:30:56 +0200
Date:   Tue, 2 May 2017 14:30:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] t4051: mark supporting files as requiring LF-only line
 endings
In-Reply-To: <cover.1493728172.git.johannes.schindelin@gmx.de>
Message-ID: <0776edd9602ec279699ea6750c4c9e54994ff06d.1493728172.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T9RgWaxbAbhhgDXvmFQ+HBhAQzQUFeJr5ydO8vJrabkW/k0lKZ9
 X32h8A1KskJMGSbZPOaOj9HQno9IAEVNSWJBOoSSJKSuS+4sAEO9+ksFkm2Y5UvbqAOBkAs
 6ejasbon/SwUIFbQBkWLriAOE/Mq6+RB9SXphHIgBaDWAzR850gDTj34snleHWmdyjMhKdF
 HW4eZds+f6HT6J743BBAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W27RAXBpLxY=:igqoN6I2d2SXCwds7ixr98
 x/7LpmwxBqmvnwnVoRr5SMCYmKZRe1zQZ/YdsA46GkQDI7JuctdcwaTcdv9erlLnOumjBUpW0
 O5HYte0UIYZxy2miI1IIr5WcqAS4XRlyQ8uVLkyBXTXhWy3MfoLVf3pNJxSyAmhuFuVDadWxF
 9HpaI6zQkKZSOzFjbcaMLvt9lC6qOhqNd96EjsOqx2FdmpbWtiwToFxK7xbFjuYBnNN4F3lff
 fDkpQ2WqM/9CwcaoztzhQvQ2zypZLI8Dmcux1kIH6ehVOy+6gApHciIVe11w35bYr3jONkmE3
 2tuTIT1D3tGLcHwzbCf+AZcCKMnJkf3Gh8xzsKRrBrRivvcYp5+aOvV8VjeeZPBcjKn4hO5HV
 iuaV1SBXKtHCPG/QVw21pBb/9zv33zst4+CSFxHiS6TBf1IkEVZU0Fo5jRUjbGXySk1W6Z8nL
 4ztj/j4BRYHHQc4tbgeBBo0T2ZhdGlN/DgKU6hMzB8yNCQ2l5AiJvENuMu4NibodQzwWC7+se
 irqLuLm38tZmVCLnYFO8YUvtAT+82C8+++7INcNyv2SLDyojdNqn98yP62TAO8enmrZ6NkNW8
 4y5V7dWzTULzT4n+HOqVc5RTv+GFcB7oxIpPu8q7k3HBWXI3v2rhxdJQUA3Wg8N/ZscHM60zX
 fidlQ9Ne8oTTs50lfNiEpWmRNaKa3afN0miZ5gktDgu5W2ZraqQdPZ3w/kcBul3feK7VICkOc
 ioTy9AjjUdnMXvG9CaAb8sufamF92FpwatLI23kGpKa3QhUaqSjFxDgbBJ311WHMxe2XT62WM
 1lpBBFo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test t4051-diff-function-context.sh seems to pass on Linux when
core.autocrlf=true even without marking its support files as LF-only,
but they fail when core.autocrlf=true in Git for Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/.gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/.gitattributes b/t/.gitattributes
index 4064eba354d..1bdc46a53f1 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -7,6 +7,7 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t4034/*/* eol=lf
 /t4013/* eol=lf
 /t4018/* eol=lf
+/t4051/* eol=lf
 /t4100/* eol=lf
 /t4101/* eol=lf
 /t4109/* eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06

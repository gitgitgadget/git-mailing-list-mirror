Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37EFE1FD99
	for <e@80x24.org>; Fri, 19 Aug 2016 09:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbcHSJi0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 05:38:26 -0400
Received: from mout.web.de ([212.227.15.14]:60164 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754152AbcHSJiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 05:38:25 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MYNkX-1bfIsk3CUL-00V94T; Fri, 19 Aug 2016 11:31:47
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 0/1] Rename NotNormalized (NNO) into CRLF in index
Date:   Fri, 19 Aug 2016 11:41:27 +0200
Message-Id: <20160819094127.21101-1-tboegi@web.de>
X-Mailer: git-send-email 2.9.3.599.g2376d31.dirty
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Dgs+xEMMHSZxAXlEyRsjLzI6JaW/gEjwEHD757GGNFXBiofpG3M
 zPQ/ccXXJ8Mrj02JVtVY4Cb58VZZZJxjct0mfpWbww6qTHyI/nQ0imMtiius9pdZb0NgyXr
 hIJ1n7R1RJrXNTBW5xw5eugVZDdnMhfHTVcVwLHlToqpH+eqIwOtve0AhYGzMSoH7HzNspu
 gIKo2RuU765yteNnbhedw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3zVXyO8rfFg=:T4mtndO/TclSk1RiiZS4ER
 dmWKrCGpcWudvsonOhFtdWjtW4VEEpPOY8/U06A/KYon7B5xCFm5WsEwUKwrjJT89C0aZdkp8
 bohHAyit7CFTjT8JsTqz1TKsAkw/k5gAh7pQbP6vLOWLLPPFJX0S+cc+5CyY2qTJwM9YaANRK
 WYkFHCNQU412ush6PLBWytsnz4CTyKVOSJGkdO+fYXnORk3zZha33+TWwGuovjP3HebLusJwt
 lNvXUZZ7reuHrwoGxeVYpm437AFs/Kdw5khj4qEKNKWQ13E+lwlJhOEj8klaNvPb4xgbJBcSx
 ZloR/eWtSaRayujPrJZSBdSd2fOBiM8FkDmUdlhnjIQg+pwTMKJB/AiGUgTlKW4bc1WeXIIwK
 GM+CnLVfEDQDuFcHk+CdBhUyuGsWDE1uwVB9PVGtAd0URG2tNZ/ELP4z+8ho8mAytyuLlER/P
 JB8qLg2pwYRaNO7WkOwWYb0TH2DOUCnPb2ZBRmzCAkBpaOfcGR0ng7yTr2ZkQToa720z95kH8
 NqlD97jeymQV82c2AaS2+DKZmKASkvOf30XUaEs4PMJfoA0HWAAOYMf2vUWbEX8iWpXuZmkR3
 ssVw6j6Gr/MnS9f4v3OpsbxiLVVRCro6IZTY2UM+OR0RgS4+wG8/Fa/masACRpd3cx6gqrh/k
 UZEtX1JA9gjm9JBFQpSP4tDWaKQlbOtTyN4lK5wWfvSfu9lQBQ7mbvk9zv60bOvzO6F4wJS+b
 GjKX6/INrTiwoZZPopTOG9JMMD1VQnKEXGtV8cl1ClG7sjzr6MC3OeFI6dA7wSZo9u9LFL7pi
 l0vRhHG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Here comes the promised cleanup of t0027:
- The wording NNO is removed and replaced by CRI
- No code changes
- Needs to go on top of next or pu or tb/t0027-raciness-fix
Torsten Bögershausen (1):
  t0027: Rename NotNormalized (NNO) into CRLF in index

 t/t0027-auto-crlf.sh | 122 +++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

-- 
2.9.3.599.g2376d31.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB9120193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758796AbcHDQHI (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:07:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:61002 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758699AbcHDQHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:07:07 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MS5jy-1bfgFT23A2-00TFEh; Thu, 04 Aug 2016 18:07:01
 +0200
Date:	Thu, 4 Aug 2016 18:07:00 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Patches to let Git build with GCC 6 and
 DEVELOPER=SureWhyNot
Message-ID: <cover.1470326812.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FU8yeWyBGx1oEV+311HF/gygCMmIkCf3mpd3TcDQYOanXWXlzVy
 MkLW28Ty0d1lDVIsYXPJOxzV5O6Q12U8IPjcKyXMQbhj3jECz9x4GlpAEel7yymaCLruWhp
 QBCZY6+mSjxP2VBnDr0CU2viI4dEeRRnUrbQf2lcKz+F89XrdEiLell5lqvMkIUnekFuEeb
 I7m88C/qWDCaSClJRXzCw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:CAJ7ThBeoR8=:VyIqU1nCrTyNdnTTbCSOc+
 kpouxtTj12aVFykMlfQ0h9ZtM9FC9pX1BXnAt/fAFZACA24jWbxNhRBW9BwCRu6Cz1foa7Ib0
 rg4uR0zFqPtjq1rqbJ/e/suiRqBXW2GE8amSW5flENWlxGibOdNicroWJqIMIlwU7bJ8ntK5f
 C2CEPpJyobOOsuDl+m2brTVwSuH9ZHkjlRUPyCJl5n/b6wELDvcNgdRzNMYY/wIZr6gauhoo5
 a/r8g7WunzH3A86sEPIJ8djHsepaheVQ6/lLa8R7qgOjyn9+O6ci/37Xl/cdgmNR4pQb+x7ZR
 +LDrEIZJd1p8jq+wOMR5TgcOK4YF+vBKjqOsUs8ESwductN1wV86Gr4qVKj5jm2pwsXkIXq/E
 6LI4H+Gt5hpuC2VMKNnN/D8qmD3nApQbm3wEdFyi93RaHtlMVgBb4QhRh8vj1z7m4AXDSiF7p
 nPxdv7DBEbV2D9/8md5G/AoiCCKT8+2vbiwzeoolH1qsHSv4keUxos9Yq11nTp7R5/JPLiONZ
 rZWGYLCKLHU5JU2kXM55k3cDZDtEe1fIAMVQoGB4puJKVsAAvUwNlNGLbhgPmLBENoKHSluSB
 8f5sgijcyUaK5RZypcaQ83nhLmsCyDMx4g1XDWJYkq3rdyGibq/778x+z68NeuzWGe2o9c2JL
 TbzU7eA3yIuHgpCGGk5dkrR3/Z4llgj7YhBz5eU365Y/QSZg6UdWOBKpTPZvP6/omkIJtp6za
 W2eClLXw1L8yAK/Yx+8WfhSB1OTIjInWdR/KZNOHBQEqyEQQWKciq0LxRMTQKybRf7/glbRFO
 n4uPWpw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While working on some local setup to allow my poor little laptop to
build and test the Windows-specific patches of Git for Windows on top of
the upstream branches, my development environment updated to use GCC 6,
and these patches were required.


Johannes Schindelin (2):
  nedmalloc: fix misleading indentation
  nedmalloc: work around overzealous GCC 6 warning

 compat/nedmalloc/nedmalloc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/gcc-6-v1
Fetch-It-Via: git fetch https://github.com/dscho/git gcc-6-v1
-- 
2.9.0.281.g286a8d9

base-commit: 80460f513ebd7851953f5402dd9744236128b240

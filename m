Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BFB21F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeC2PSv (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:18:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:40435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbeC2PSt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:18:49 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWBpJ-1f3ca02sRd-00XKis; Thu, 29
 Mar 2018 17:18:41 +0200
Date:   Thu, 29 Mar 2018 17:18:40 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 2/9] t1300: rename it to reflect that `repo-config` was
 deprecated
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Message-ID: <6023d70cff199424893d116339f860952c6a6b4b.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:B4wniEQ16tPlLq8+I6U73Psbd/3ikbrJpIQ31/eaCo8sBcT1kEw
 I7IgNp7xBFfJ2X/EkTfunTLDORCZ8DQ+/Fjt3VQfvKzDIHCLVyyPBNWdDkWfaRYpMVzgbfT
 1ylQArtGN9b3PgPdt78KllewpivH/lpzHe07F7j1HsGJ6YN3LJyxE9uIGZl4VHBqlNf3Rx8
 Fo/hDnmaBV2qJCGgyxcnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Gj0KbdIv2E=:Aw2wDs53VIKGUqe0bOb5mv
 eBZOJQAEYtoYDm39Ea1t1gHCBmgprEZpeMgBtwcGuAqZn2PMzYtJYD8BuJcpPW+Nfl4EZi1PV
 OxuPzJNHAF5xWpjgXljEW44UQ+e04vmvWwFAbs/AhDc6qDhSwAQ6yNIeT3r8NGIKNSjbLQgbr
 LqEMoeV0goHLIexQGKNJC++gXNZ8Wrd+sg+ji3ezvCPlvC54qWNq6onoMGSbAyoTsPWiYCxDy
 xsDF4CLS/uRBMzWgKu+4/0Gwbg0tA3DaYSmLt0rlxHNngDc9gshVDCyZPwKfGzNXfB/ZaHwGX
 4uCLKJJplfvG4xEUltaz0WAD+E7P9XLoTNOIHf8zgrcGDdBcGElHCPQzBZpCDQb+JGX3AlmXU
 bqcuwyJD9/rhzQaA8smN2yZgWnFtAgeAL+JWAcIg2D/vuLySyZOJ/1VauXVoiT4VRADyVnYPJ
 o7phU3mRAzpb9DbyvBpZHm5pvmzP82PCtHB3YDrr9N/x7DhOiwvFQ0Ow+dD2rD06/aFjDambW
 VgoTRnH5L/NpgjniHk3fSmbUsfB6+1Rbe9jfvUWL3gjKdSS3k/qEcmRKXtD5I4WApr3PhlQMk
 1Ghm+FUTsK5LG+teYzP4Hf3DvLhcU5ECAufjqnrV7LR+9ZC7aEGqO9K/Q+abPpnCF9bPWzVF0
 xeshf0jQAa1ebPdRCunAHIwmYdcOo6qfr5gMvQuCNxYj0La14EplF0AU2QVKI/UWMpRjXGVKC
 O6+jQStRWNyP76iPaltn1nKrh6eMOrI3t415gnwRIYePcQpKV1jN8FUFGNXBA/ypunjTnU9/L
 3XT86UEAeQf56v+tpo3Vlg8yeEL6AL1eNwY/vTerHcQqUfjUHJWanP5mCc2KXZWnQMkcWTr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/{t1300-repo-config.sh => t1300-config.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/{t1300-repo-config.sh => t1300-config.sh} (100%)

diff --git a/t/t1300-repo-config.sh b/t/t1300-config.sh
similarity index 100%
rename from t/t1300-repo-config.sh
rename to t/t1300-config.sh
-- 
2.16.2.windows.1.26.g2cc3565eb4b



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30A61F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeDCQ2i (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:60815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752431AbeDCQ2g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:36 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LoEPJ-1eaOZP2CQj-00gFgw; Tue, 03 Apr 2018 18:28:26 +0200
Date:   Tue, 3 Apr 2018 18:28:25 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 07/15] t1300: `--unset-all` can leave an empty section
 behind (bug)
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <331fbdb33d900c349b211dd763627a2d244eda4a.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oZ5JXLAjV68RRKkZtCysimR3jPxooObn4iI5VFy19eefu7mDlLv
 XVp3utAeTRHa7nCl667m6KRkxnv+BFVCg6xjH4KWyVoaRLv+kbq2QUD1W2jLauwtkoh48yw
 UNSd4JU1MCaFrSvXkanj45StZl5QVHuVvVOxS7KJAXaP9ZD9N9h6QJmnK/1b+QPDIBZ+gki
 pfoM45xHVQ+K+4QM/ueUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wkbUnrj8lMI=:wscDESkbsE78BbLXGvgy3l
 roWFk0lJtOh8pVSG97wtpRXJC1bx0CtDuRmJIQfG8FsYsCLA7tkYK08CCfED6RSqHwBkFW1C+
 aYlfTudmqJ5n9ea3rJnvsw05Z/JHrniNbZckQTgHC9W2m4R21kCl9VY154Fn+2NdH2yqZ0qK6
 z+cuMgeE2hj2ga19W8fm3fUz4vthgQDg/hcEpACCzEIhl92NvswRxxVrHX06qLWAy1MfBTL/t
 60Pk8+jAzxOe/jmKy3Ur2VMltMIGOhdsxtGLbrIbn3ec9cA5kW22XqvrZeeblKEK8Y071Gsm+
 0jw3//ssxs9NV32O30mwwJjIUDnkLvmWX7XlH3pOBa7YhPZLq85G20CFqupxGRvVgjx7UbRxq
 MSi06lG19acDJcSC5+2dxjyXOdrE2AbMoxKQXZhwLltjB+h+fIe45mMaqCGuqH3eeFYI3JtYs
 M7cbMLZUx4RNgcDpTz7bilN2hFvn03Q3QquV6BPB+Zou9lMzLLMoN8YEijGR+QRFr0YEju2iy
 KonWtUkLEgoHiNrrhs2NXyRWBjAlSh/qdakRa3TTx2wj939LhDI/ycqrjA0+XSgMe/Z1eZ66p
 NjmvRiA/zAUVfBwmC1Y+z1vqoGVLIiyX0WTgJXmk0Ymy8eA1jffT/thsaP7McLRiF1znY2FIs
 X/nTk+KLv+KAoQuPExW24/6eKw2EyzhqDb+bTNQe4Gkt1gOxTSqnqm10JvvrBsCIT3f1NkoKA
 avtGu3b3AHOLed9KbQMvUalZZSiD9ktiMPdTSOWPjnbVw4L9dZ89LhSJQgzdpH1TLgd9+cxur
 umF4ZRgFlA79305HOH6S6icyhO3jXahWjbDzKfY1+GaOLipUhEy/2BCI8/8hdLuYzDWwoMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have a test demonstrating that removing the last entry from a
config section fails to remove the section header of the now-empty
section.

The same can happen, of course, if we remove the last entries in one fell
swoop. This is *also* a bug, and should be fixed at the same time.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-config.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 187fc5b195f..10b9bf4b088 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1452,6 +1452,17 @@ test_expect_failure '--unset last key removes section (except if commented)' '
 	test_cmp expect .git/config
 '
 
+test_expect_failure '--unset-all removes section if empty & uncommented' '
+	cat >.git/config <<-\EOF &&
+	[section]
+	key = value1
+	key = value2
+	EOF
+
+	git config --unset-all section.key &&
+	test_line_count = 0 .git/config
+'
+
 test_expect_failure 'adding a key into an empty section reuses header' '
 	cat >.git/config <<-\EOF &&
 	[section]
-- 
2.16.2.windows.1.26.g2cc3565eb4b



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28A921F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeDCQ2e (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:33123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752431AbeDCQ2c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:32 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M8NBi-1eGOkG40OY-00vt5A; Tue, 03 Apr 2018 18:28:23 +0200
Date:   Tue, 3 Apr 2018 18:28:22 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 06/15] t1300: remove unreasonable expectation from TODO
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <5a4791e582116d83425918f9bb13201a44c91aa6.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GmLyohcNcQuqFYIFCYxm0KlCwBdBOrhwomXe4e3Ynqi9SzvDJ2q
 jN7myQOgaBBqAjNB9cf1AdCO1dlmQetziVl284tyh8ytWby0I35pD1275VwjUdQrD58b6aJ
 ufz8zpoPrtfgZuW1hCnGN7U2qzCEwdRROTkc8XRzQQmBF0dURP4D40oOSNNXnrJfqUVWWYc
 X8H0vauMro3TlvmkVI/BQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LlcY7I7zgN4=:G4Wz61+8JIeaq+RjuoCnKa
 cmWjefZjDplGnU6O09adpZocl60amU5BpNkTABU0wSbCvp2IlscyKupGfxPcqJ9af5wKRTLPc
 qCRF+6C1ngXTFw0P3ejQEHTaykgQqaVC6O1hcBICC9g0ydft398bqbK9QwhtT4kW6aKx94wor
 GobA1hrkKyNHTgjCGDpdmiXaPpHXjdv+eUmsGdr40ukYZzj/0i2O9VGE1TAp/+ITjxgYVHYwo
 4OwOv8MaV4G/3eijleB3FtLB/HrRhTZo8hg81DkGltXTU5/gEpy0d2EAXNP33tDnyULfvEvm5
 xp9phlRNdE9TZ6sGTCDxkGZqZlmSS8PMvYLpUNzzGkTDMxmpxgc8feXarBqaY/QAIQiFFKlpI
 gUVGJSIZO2T9Mde+w7tZXCaDL8bNHiPOAJuZkVE+Jk3j3BATYBDzJfjQuWij2Cfpk89shLl1h
 qQnpYruNZ15T/fX5VvAIfZ3SKLesa42cqfXQ32PwIob80/XczRAtiK2YImUwxl5ufIQqKMEPH
 OOg9zc5R9UQva+C5xI8+6PkjLaMtl9uMhkzoM4Yi7LODaQbZdD7OekqHJKxDioxTKu3mggVsb
 OW8IP8hjFc7R0TKriTxyJGx6tmEUGRmuJAYCwNHJXemaplzBJJZ/pltMrgPFpUfKd+hLcgxLU
 OpwFg4uDhIeOHg6n+7d8buES3CWvj+OKqv6uZffNQMa5ZuJqYCMX5oXqUJS4qt7BpBjyp8teb
 FNZoYMoHGnu69x6boH6DLG8TWedPByGp4TsryVZqRGGmIxiA0yslw1cTF+RvFaBWXEnz4Y0hA
 1l7TiQQT6Ml/NKfCgPIAnSYhpDxg8XZ4SZJbQjtTEgSxeLbsJtAqJqEDRlpepFjODO+SjjU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In https://public-inbox.org/git/7vvc8alzat.fsf@alter.siamese.dyndns.org/
a reasonable patch was made quite a bit less so by changing a test case
demonstrating a bug to a test case that demonstrates that we ask for too
much: the test case 'unsetting the last key in a section removes header'
now expects a future bug fix to be able to determine whether a free-form
comment above a section header refers to said section or not.

Rather than shooting for the stars (and not even getting off the
ground), let's start shooting for something obtainable and be reasonably
confident that we *can* get it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-config.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 7c0ee208dea..187fc5b195f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1413,7 +1413,7 @@ test_expect_success 'urlmatch with wildcard' '
 '
 
 # good section hygiene
-test_expect_failure 'unsetting the last key in a section removes header' '
+test_expect_failure '--unset last key removes section (except if commented)' '
 	cat >.git/config <<-\EOF &&
 	# some generic comment on the configuration file itself
 	# a comment specific to this "section" section.
@@ -1427,6 +1427,25 @@ test_expect_failure 'unsetting the last key in a section removes header' '
 
 	cat >expect <<-\EOF &&
 	# some generic comment on the configuration file itself
+	# a comment specific to this "section" section.
+	[section]
+	# some intervening lines
+	# that should also be dropped
+
+	# please be careful when you update the above variable
+	EOF
+
+	git config --unset section.key &&
+	test_cmp expect .git/config &&
+
+	cat >.git/config <<-\EOF &&
+	[section]
+	key = value
+	[next-section]
+	EOF
+
+	cat >expect <<-\EOF &&
+	[next-section]
 	EOF
 
 	git config --unset section.key &&
-- 
2.16.2.windows.1.26.g2cc3565eb4b



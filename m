Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2841F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeC2PTD (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:19:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:40817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751859AbeC2PTC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:19:02 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQ33z-1exSS80iQN-005HyX; Thu, 29
 Mar 2018 17:18:51 +0200
Date:   Thu, 29 Mar 2018 17:18:50 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 4/9] t1300: remove unreasonable expectation from TODO
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Message-ID: <5801f7529465b7dbdfbe3c105e2a8212c253ba0d.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8JkZGfPx1Z6RT5atOTWCgf1HZN9LIRToby+h9Nl7hLavepFIkzF
 FKZJSQGeEEAnkrgAQPhOFz+lX9pYdq1HmT4EOwygHFpcSjb5F/mIHF5WZhdyuDVHaecwB7S
 KRgwheAL/aS4fdXeGEt76ajf9uMiBUPvfQ/ByIiNiJGKm8gyBDukzjVDzv780pRwKKass7r
 VQdMwWak9+AGvXjcFxHwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g1JM/DuXQ3s=:DUx8Cgmczre8jjtHlu7dSN
 cU0HUEGpLx62tDczEBeoTY2Vc5VxpyTDgM7wP9yxhhbw0MhMsrtIDzwluV3aIL8GWLJ768UH+
 lBkLAv8QoHRXpE4F56+J/aJwo+3Br/2gNamh680QImn1IxlIm06fmnSCswefLFKQ2929J3Cv3
 tD5xlE3dUPB98T2SWOzMYVsnr89RFI45Abq8/QV9sZAFQYbg7+yigcxhiflpgGA4s+3eHzchX
 v85FapXiYA8tQ20/bdRjdfI4vp3u389YV785m9wAIwMek1TvuVh8ciZl6R+iTzlbN4mqSTVeR
 dtpW4JPrnJDyhWvFMmXdZOlU6CcIk+OhxNxwFRuiiu0PfO7qNxfg3OCJ4TG2QHTaBgxGONxO1
 fUrRAjbfe3zQsSHmm3o33PuWfrMWbpY1LvvRnM2cd4tnrb/eh/B4+Oc5yk0jScET/XrcsisBf
 mocBsSKjuwPzg/3ndMSDK6Fu/ee4AqWz8Whe+UYfCj1WOZaCZgaWW9fmuwXsVYVrKub8qYe0P
 zSYO0crO/ePjILZcC8DkZLGR5T99W6uxCCW4wjr+teYXzeueDMQrP5ttXD+jULuO/ofOWWCfM
 LGW8b4w7KVmmspRoLrqV9EumsN9yDfZFtOzx3i9Kg2Vn48xjPyjth85tPYcBRPKRRfD/p32lF
 5w7JTJIPqJYb5ptHoDXzuOVpmeeXbP/jnBuEOjlRtbtqdgLQQmz/vVK4tYI4iHpl62auJ3VbD
 TSxwAld1o3x+S7sIOoHbg/0ZEPc+U6IUe0OTFyHua8bkk2gXUYOK8BqUgkplm8/l9nGZaaXj/
 MJ9nXjtuE9znYiTeLGf0/wO6O7c3sBECbYdkOAuTxMiMjLWf/jM4OMIvxOj6PyFV6d5qhN2
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
index 1ece7bad05f..3ad3df0c83e 100755
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



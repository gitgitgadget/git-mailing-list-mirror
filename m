Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC651F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeDIIb4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:31:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:50057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeDIIbx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:31:53 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lkfii-1eXUN911hU-00aUTQ; Mon, 09
 Apr 2018 10:31:43 +0200
Date:   Mon, 9 Apr 2018 10:31:42 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 06/15] t1300: remove unreasonable expectation from TODO
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <5a4791e582116d83425918f9bb13201a44c91aa6.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Vj5W2yNMb3BuOjcs0wlr2t/p8Rsf7+t5iobeMI0G03ep8MlNfcM
 LinYLBMieOiquRN8CZAzCKJiJLtbjc/iV9YXnXkQfiU4LWR7QJ1AxibR5c0yDLZBN82ow8x
 oj+bcIIQXtInE13S2pxUJjO0lWBogT3O/Mx+SBdyRfpswv4XyrUF0KnxJZJiccmFQFqH7jX
 gGn74iXdPY0y/R4dVxkvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Js8/cAupc8g=:deq+aXvospjrlDmGKGb0I/
 fK7zy7XKfy4j/cpUzVzhfLtNTwf1dHq1tU9QqoBRcycdRidUZ22g2AOQAequw8hp+Bt/wHJGK
 HHfgduh881Gf0KGBXffnEVam3IXwaEFm54p4Tt8uMThctGsbKbHwgU7SYvAA1B255VdiWBiJb
 I7/lwRDV6QQcJHhKPDLOWeOoqvuZ5iAg36Ti4JECP3BCQ2Wn37o1S8vBS/aHWfv6AT+5IGn8W
 mqz0bUa9KYRqEp/wIS/2OsvSpyensSkFiZPOwUTosDh/1wp/8gBszltITgy6t5CTGgm5lGUDd
 JKY26xUMB0e/fq48knBoMf11HKmxaQ0Fnwt3xbBwXwN4qRRXJ5pW1HxzMJnoMfla6kxZ6paRN
 QyIc8vYgqvtggeU/+AlCirjqAtvo3FMVPOyhXJ5Fp3SKn0LBsu14y6uE40hyZw5lBZMxr/giq
 2Vhfxza4G8OLiFzW318QTwkIIYp3SsOGZScDGBi5VCfxbhLgTkLteh82tethSeBTQ5zYYywwk
 AamIk4rj7TiWVbk3lPHnqFfcNjrPbveot0FaOIebnChw8u/lY5f+ViDKApu8YX8+q1N14wHg1
 Nfrs8ukwSsVnWsHv3NshO7Mn55GG2+1bhsPwTsMlPCIEPrtpRf0zurvqTkua3jdBMwobWEIEi
 4OK1L5dfnIzdHu1oSMeYcKKa3N2jqOqCD6IbIrZoeAHEv+AF7mSe4ictTTcD3PMNTDEy2+91u
 LJv4XlFjvMFr0isA0mUmPqPfvj4UhiQMaElUF26H3JP9zwDw9XcwdTAMf9jpNQ/oMmhLx4+B9
 dLFv3xtmvs931lhcGgqatQGwZxnSIQNAHK+byRIe1rRa9Dvuwk=
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
2.17.0.windows.1.4.g7e4058d72e3



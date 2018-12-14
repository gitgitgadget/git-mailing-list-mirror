Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC725211B3
	for <e@80x24.org>; Fri, 14 Dec 2018 12:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbeLNM2T (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 07:28:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:48731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731581AbeLNM2S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 07:28:18 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQMBU-1h1WmF1czM-00TirY; Fri, 14
 Dec 2018 13:28:11 +0100
Date:   Fri, 14 Dec 2018 13:27:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
cc:     Josh Steadmon <steadmon@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, gitster@pobox.com
Subject: t5601 breakage at 3cd325f7be (Merge branch 'js/protocol-advertise-multi'
 into pu, 2018-12-14)
Message-ID: <nycvar.QRO.7.76.6.1812141318520.43@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1209027698-1544790491=:43"
X-Provags-ID: V03:K1:CYiCEy2xIdKptzZ/M5RmkpcwBfqBEK/9rwGlKd6a4w/oRfnDjIm
 5oS9Yr7KoeC7gdbf7GwO0u64vU37tE3E97Oc35NmNTHo7PAQ+iT7QzUOcXg/MevB5Kjrz9F
 cuCl4TfE+jkpqEDM9vEU+JCnUeAu1rkfNSCVWd1QFFUij9LVyEGHCBRhM84XAo7FsSE2FI0
 pc8zUjPApYY9+/iQUpK8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Op+AX7q0G2w=:9UVP5h70d0MZ8AxhTQnNey
 CpMWsQm6VoQ8dVqH7P0q1Lvte4FYFLhLicQEunnULvbqfe8/uD1clvzbGL701TUrsyx7zV8oO
 lvh1SPP+Kbtz4LafPnAhd3DAa14BPziBbQ1kHXaw1v8VhKNfaOll3iQ0riX16X+7cnI43o3G/
 ikRzkTrCtb+3k6N28PsZE7kHeo3g78ThEttgCzsPmBwVdo9XupSguz9zMrFQG6aU/2Uz9K4UD
 QtMi6e7qBUKBAE4j8Rjv9prkApXI+L9pg52P9mFv/9TQKWE4FebzbJCIq/qDcsnvoBWjh/NH/
 k+bdNHM1uinE2AMaAu3LaU7vAuiQGnG9SFgqBUz+lEnnSzA4or7z9XLx+4Gctu269Ess8N+9a
 MiHmcEWJNFiyo6T4nWVsq4Mr9ODuOBTwoW+PbJwZ2h8QpFOP02t0oX8fChhOsofpEkCuL06C1
 EWUv2k1/CZIcHaaHPfDRIlKZJK2oVzlgNVpGwc5zgHfydYOmSSQnFH9lN4Vr1DQAzAFPtb26D
 GUap1CMALrBHCfjzQdJf1/kvEi1aLcpX1Dc4WndqAEXReONQ6y++DWpJxPGvkQnvIWo+8hn7J
 2Hryi8prnbLtSLSOZt4iXmnvDw9IaJjnRVqkJF7hAEssfoZYVDGAwJxIMkKX2IyLSdUL8jb0a
 Tlu6/ogWOoY0SCJBWWzHefgp4WJTvgPqQzgZ96LTK6uqygHk+N2+4lxGbp6GhepCuKZlN9kHI
 4ObfOQ4UqvcCtwYTLdFiNYERwOyhoVOb5t6IzfEVe9q2XGTIKZZe/YdBFoNHkR9oZ+bpjVOAh
 GYof3YHTcx7dohakYLQbuJ6p2ES53Od2hT28omFGslJDqU1YZwbsY7Mz+dY3kkQEnAXHJAtvF
 ItM4hyKKat+c7cvF0NuQTbrlN0quBHYgxR7Gh6gxgEZrDE1aB3vwfK3ST0TRXPbAEqIz5gybd
 2dhEijJ9pvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1209027698-1544790491=:43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

this morning Travis sounded quite a few claxons:
https://travis-ci.org/git/git/builds/467839114

It seems that quite a few tests in t5601-clone.sh fail, the first of which
reading like this:

-- snip --
expecting success: 
	git clone myhost:src ssh-clone &&
	expect_ssh "-o SendEnv=GIT_PROTOCOL" myhost src

++ git clone myhost:src ssh-clone
Cloning into 'ssh-clone'...
++ expect_ssh '-o SendEnv=GIT_PROTOCOL' myhost src
++ test_when_finished '
		(cd "$TRASH_DIRECTORY" && rm -f ssh-expect ssh-output.munged && >ssh-output)
	'
++ test 0 = 0
++ test_cleanup='{ 
		(cd "$TRASH_DIRECTORY" && rm -f ssh-expect ssh-output.munged && >ssh-output)
	
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ case "$#" in
++ echo 'ssh: -o SendEnv=GIT_PROTOCOL myhost git-upload-pack '\''src'\'''
++ cd '/Users/vsts/agent/2.144.0/work/1/s/t/trash directory.t5601-clone'
++ sed 's/ssh: -o SendEnv=GIT_PROTOCOL /ssh: /'
++ mv ssh-output.munged ssh-output
++ test_cmp ssh-expect ssh-output
++ diff -u ssh-expect ssh-output
--- ssh-expect	2018-12-14 04:30:28.000000000 +0000
+++ ssh-output	2018-12-14 04:30:28.000000000 +0000
@@ -1 +1 @@
-ssh: -o SendEnv=GIT_PROTOCOL myhost git-upload-pack 'src'
+ssh: myhost git-upload-pack 'src'
error: last command exited with $?=1
not ok 37 - clone myhost:src uses ssh
#	
#		git clone myhost:src ssh-clone &&
#		expect_ssh "-o SendEnv=GIT_PROTOCOL" myhost src
#	
-- snap --

I've bisected this down to 3cd325f7be (Merge branch
'js/protocol-advertise-multi' into pu, 2018-12-14), a merge, meaning that
two topic branches do not play nice with one another.

Staring at the breakage and the changes involved, I suspected that
391985d7c7 (tests: mark & fix tests broken under
GIT_TEST_PROTOCOL_VERSION=1, 2018-12-13) does not play well with the
merged 24c10f7473 (protocol: advertise multiple supported versions,
2018-11-16), and indeed, reverting 391985d7c7 on top of 3cd325f7be lets
t5601 pass again.

It would appear to me, then, that these two patches step on each others'
toes. Josh, Ævar, what should be done about this?

Ciao,
Johannes
--8323328-1209027698-1544790491=:43--

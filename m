Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B42C2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A302071A
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 11:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="M8aygg/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbgAZLQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 06:16:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:41401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387394AbgAZLQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 06:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580037355;
        bh=jyNBOu5MQz/qPn8fU7LTq/o+6D2Do52lHSzRAhwN9os=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M8aygg/x5VtkBAQU8mZK4R4Q0pRSWEMFCWMN+2FCMrTsJSLHRHBhcgcZ2c+xBn/VW
         1OXmDh4jKpHfD53UsuFNqZ64Oy1WpaXJ0aeGq1+otwv/hl5Wb9LbHCC680QoGY93Il
         O2aieVapHMKAeajcpiKIidJh1xQhmIASV7XVmN48=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1jhXHY3QNK-015uyB; Sun, 26
 Jan 2020 12:15:54 +0100
Date:   Sun, 26 Jan 2020 12:15:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 03/22] t3305: annotate with SHA1 prerequisite
In-Reply-To: <20200125230035.136348-4-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2001261209590.46@tvgsbejvaqbjf.bet>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net> <20200125230035.136348-4-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LE6ROX/e2hha/7AAC3ow/ng4Ymu6nH/rnk4nrlrbLvgVgqZ+z0A
 Fo6uIVoqn/6WBnt9D9zzaanjQ1WRWYgUkjCgxDhhYXIqNjMu1oGvfz/Ykhw5tu7kYHA18CY
 jWO8BrlR1oVHaIUv3e1FV2HMMJC8dSJ81POx3Rfdlxvn6c3xMsIDiKb4jBlXXAow6qrsStm
 kEPvOa/4tHJN8sMz5ZDcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j1itUGgSF+w=:wFtK47X3kA9/IKY8RGuqSD
 zyta+0SztsKhM2yVCJVsX6OpRI+Ra26ivSSbZkCdKO1iyJ+ozqDgKB37dq8cgfjU725ufB7IQ
 EybdblV02Dz1RMvNhLBGZOcSGSUiwMRe/9R7TC7HGUYF6yy27hR5A5ZSOHZFMWvcv6GO47aX+
 gygmgBNZDb8dFE0Vf9xAVimmGmxr6eFTPEnaEyZ3XYg/5jrqYm0k+o/khZIoHGFTinbDpe4mq
 0+Ay9fiKp935Ntpkp2lYDY5K04lkJ1flOixFuAcSD9PpmbQCmXtSUXAHIjpXVJyQhIwuivTQt
 V/8Sy/fhArS8COapcpyKvCN5Aq5MLfQAElGKTAD6TLBwgtO4gaOfevWOevYLoft3ashIquhuJ
 b9kvkkwqFZahclwoTU7OZnaiVa7MtXKUwVh3yhUw0+aFT0+X9Xou3tuY+dMuWMvSC24JKW1Yj
 pZNXjQ94NRj/Tc3KqUHhF/ZN4rwhPFRzDVIFPvoOnc0kuZtJ7diUwIEc3y8LPa3/NikpidoIL
 O5PZ7kylX7ShSIfmhy+YxW/KU6TQuV98tr/cii3aE1H0ejdmjAV1USUU/oNshLCo1xS5p2Hvo
 85IAY0MskaONEy09VJ3V8fY0QlVRqGBrVPq5Q0N9KKMFa5Eqml9l+3yxLQsqkkqaFLru8gAGH
 qw3SxOW6EspYEKMrGwLDDiBL/RW31OBAswPsT3Ccfg3WssPnI24fzSs9CO4Ec9RZ9PWdndnDA
 bVhjfIH0OL0OUSr5oajxtrFDQqlvGQUZFHwKre+SmYVSB98IUTTU+koJMf4dCm/T8DrN6MPf0
 veeQSI6hQZlKF/VsxMvuKSQF2I4Tbo175UJHAUcsXUFAaVoxDrM38aJf0iRoQ9gVLa7UHAUYC
 S4tIX2ChRYjg3Vkda0ITuWscQP0c2svdMndNecyQ91y5fj0ItMA77EeotT3z36THOR9JCG2Z2
 kcTESBG9Scr9lGXHpErSEGFfDLulVnmKLuR/+RyyAym6NQfXdDD3YuayDz9BAAJV2VjYizbj2
 /GTxyRwKHY5P1JF1E13gOSx3AKuFwPhLAjRyXBUeCZo+XlOJ2cwL+CrJxZ12Hzroiam0Nu95/
 3p/qV1Y1hMd//0cnxl3iPjqfkYsTegGgUuK0MXDq1qWBSVfFIAsWDNiJoFP/W8KsdJrqju5lj
 0KhWF7mWCrz9N8nhlvgfOaAAbdlq04RgtSPVAnFjsopnBp/yBNCyZPpLeZqcZJ/yJ4rhpeXb7
 Wudn2TN4XeOcNO6Mq
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sat, 25 Jan 2020, brian m. carlson wrote:

> This test relies on a roughly equal distribution of hashes for notes in
> order to ensure that fanouts are compressed.  If there are subtrees with
> only one item left after removing notes, they'll end up still with one
> level of fanout, causing the test to fail.

That is _almost_ correct: The heuristic wants to see one bucket that has
a note in it. Or something like that.

See 73f77b909f8 (Notes API: for_each_note(): Traverse the entire notes
tree with a callback, 2010-02-13) for details. (Cc:ing Johan.)

> The test happens to pass with SHA-1, but doesn't necessarily with other
> hash algorithms, so annotate it with the SHA1 prerequisite.

I would rather see this tested, still, and reducing the number of notes
that are retained from 50 to 20 before testing that the fanout has been
reduced to 0 seems to do the trick. Therefore, I would love to submit this
for squashing:

=2D- snip --
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 3520402bb81..39b12c9902c 100755
=2D-- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -43,7 +43,7 @@ test_expect_success 'many notes created with git-notes t=
riggers fanout' '
 '

 test_expect_success 'deleting most notes with git-notes' '
-	num_notes=3D250 &&
+	num_notes=3D280 &&
 	i=3D0 &&
 	git rev-list HEAD |
 	while test $i -lt $num_notes && read sha1
@@ -56,8 +56,8 @@ test_expect_success 'deleting most notes with git-notes'=
 '
 '

 test_expect_success 'most notes deleted correctly with git-notes' '
-	git log HEAD~250 | grep "^    " > output &&
-	i=3D50 &&
+	git log HEAD~280 | grep "^    " > output &&
+	i=3D20 &&
 	while test $i -gt 0
 	do
 		echo "    commit #$i" &&
@@ -67,7 +67,7 @@ test_expect_success 'most notes deleted correctly with g=
it-notes' '
 	test_cmp expect output
 '

-test_expect_success SHA1 'deleting most notes triggers fanout consolidati=
on' '
+test_expect_success 'deleting most notes triggers fanout consolidation' '
 	# Expect entire notes tree to have a fanout =3D=3D 0
 	git ls-tree -r --name-only refs/notes/commits |
 	while read path
=2D- snap --

Thanks,
Dscho

>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t3305-notes-fanout.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
> index 831f83d211..3520402bb8 100755
> --- a/t/t3305-notes-fanout.sh
> +++ b/t/t3305-notes-fanout.sh
> @@ -67,7 +67,7 @@ test_expect_success 'most notes deleted correctly with=
 git-notes' '
>  	test_cmp expect output
>  '
>
> -test_expect_success 'deleting most notes triggers fanout consolidation'=
 '
> +test_expect_success SHA1 'deleting most notes triggers fanout consolida=
tion' '
>  	# Expect entire notes tree to have a fanout =3D=3D 0
>  	git ls-tree -r --name-only refs/notes/commits |
>  	while read path
>

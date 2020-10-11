Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA8C433E7
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 06:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2102083B
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 06:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="epxwUuBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgJKGOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 02:14:40 -0400
Received: from mout.web.de ([212.227.17.12]:48993 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgJKGOk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 02:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602396877;
        bh=rZkb43SmGyvomselihgptu0lmB59WESVL8X6uy7efpo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=epxwUuBnV0i6P1rmK9AcTxqxI92I1Cm12ETA8ust/7Cm0fakn331k6xJ9W8Edminb
         ETdNNiDtjtwAvIawrE7DEA0r29cvgJccVfU7b14JQSprHsnHTgN5LKxXlxQCVavVfG
         OSsrm169+PXlQi2ka1K3j/u/FxiDRsrzOZymY85E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.172]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j1c-1kXZAd27fW-007BtQ; Sun, 11
 Oct 2020 08:14:37 +0200
Subject: [PATCH 2/1] Makefile: remove the unused variable TAR_DIST_EXTRA_OPTS
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <40da2404-8504-e134-7176-f3429c081f12@web.de>
Message-ID: <a3cf2838-b67d-841e-f5be-887825b5e1e7@web.de>
Date:   Sun, 11 Oct 2020 08:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <40da2404-8504-e134-7176-f3429c081f12@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PvR4UxQ9VbW68LXa8AsW0zrXYN/uiCuY2Je1T7R2Iusu8MJzEyD
 j/yiRf13Ivewu7rUoE6MTLfO8onk4kgtfrlOW+yhem1UFzveMiX3GtMPIshxezhc0uegVcN
 oj1iNw6xn99ZEwfBtmTW0DEHbMI2HIAaQmCHs8WHaXeo/KGzFq5qSV0dJBZxFLzIbozK7es
 KKZr2t9JpFj7S9pz6N9ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sxszp7P+b9s=:KQIranPR6DXthTzmulQ02C
 LVHFtSbTqI0eqSGH4gFsmcs74S2pyHS1I+EBzwti0fzvL6vZSSchlc86U18wh9yllN78KWXfU
 iskJmVlUbonI1ntT+tsIqlGjwl92mKT/Llu6n6PqGNDW5e47YWq8pLbgSR1mXYBlra8gbNyNR
 DLuIuNyT6SvKMHzr5F6HWxEoZSi4+6OO3JVR07nTV4qYND//a8dvCsO7Y0r+exUjCOxmqHpa9
 V7koEueoaj5hc+96SnjwRCsoKHAu3hTw3++SnuLdPjD719FKQtWpIGKDO7mJnxPejTrO/42eh
 adwU3M+/ZHxzxLGKpKDe1aXjAtIsUJ2DopUBvNGL6J0N79I3kDLD2J+gU3DLS+5a9GogspLAO
 dg4ApDCPgLpWY+MWXNRIZI4T3lAFVJX9Ho8HNZItF8Y0g4JU/DcPmgak6pBBFs4qJg8Mu6Gt2
 YjbFJg7hSa/qa2UgMSyEEBusbHy/OTtDou2k2pGvd3kbqv1zuifn+xqVxrUPF4l5TSZhK5HPE
 CLS0Lujx1QA5Dm4b98/4FFESTs+zHw/yCBHN4XqcnLqIoHNn6SFwghfBu2XZ6E5cwwIiLijJh
 vjQuxYgr5rF8Q72jkg8DPD1vvm/nI+NKY1rFmeLHwH+lwwXkw7vae30yuvmAzrbhdvXKBxApG
 gZRysIUnJ319fFVR3TwlzTzB99lSORZg7UzdN+Ju9nxL9jQqGdLgvTHm4ITf5m9WTStqguStM
 Kiy6WfGR8DYFLG0kgs0RB+4G3uu1s/EhrEK8t8dce/SjtJ85GOv6WFK3dglDyE7ms42f7daOJ
 Hxv934fbhccwEF2NrX+1JwEuZ+TFYVhE+HZiSfkxhleg/YDal4EZGIU1RIxUvO25ILsOoL4lI
 6nXokY7x5wN9tadJmJL0m+udwFYHvKb+EHt3VPlcQNpmQvm8pbw9a9ex1in5Hf0RR3KA75E7B
 bdGSxn+eXP3ClkKPt8Gm6heKy3Gv6ev4Mg8lfYm8v8QLjOpv6aqWyUeFp0opZnT1oEsUOTjbs
 GiKS/a18J86+FhHQusTY7UcmuLhV/ueJALf4gz9ePJSyFRHyToxUZbu+JQBwQ/GJi8WQl+k44
 DNZLaf2dxn+rYg5+O6VATr0DLkRbyM1f+sremKhhaHvmzChtnC5WLz5qADW8hqvjPOkl4GK3u
 mbmpM1WaroFwsole5bizEf4c+mY+QjEghND0OAaMPmo+r+nqc+ceTS5CZ34yt6mzjvZpruvfz
 s7LVflwfvCXctP8W8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index b7f3708292..db8f07898d 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -3053,9 +3053,6 @@ quick-install-html:

 ### Maintainer's dist rules

-# Allow tweaking to hide local environment effects, like perm bits.
-# With GNU tar, "--mode=3Du+rwX,og+rX,og-w" would be a good idea, for exa=
mple.
-TAR_DIST_EXTRA_OPTS =3D
 GIT_TARNAME =3D git-$(GIT_VERSION)
 GIT_ARCHIVE_EXTRA_FILES =3D \
 	--prefix=3D$(GIT_TARNAME)/ \
=2D-
2.28.0

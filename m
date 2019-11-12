Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132CD1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 20:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKLUk6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 15:40:58 -0500
Received: from mout.web.de ([212.227.17.11]:54021 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfKLUk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 15:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573591255;
        bh=nfcCsQd/Ni6fEzRReD9NF5UesGjaPDq4oy+gf7RHCM8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=m8wWRTXLIT6r7Hrir3ZYGD1SkeHJHfCmaqFX15V5i3Tu+lQei5Sv4IJeH3gX5oAY/
         Ss4KSrYgjeF+zhxzCb7EXYOmWFlSMHTxdLm6EY+93EoNvpjfstPBlr9vREehPB6wr+
         2ydujr633mEc+p8tAIDR7mKK4hwEgpZmypWFxFr0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNjo-1i8mcJ1jKi-00mZDv; Tue, 12
 Nov 2019 21:40:55 +0100
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] coccinelle: delete an unused variable in two rules from
 the_repository.pending.cocci
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <22b15b44-2679-6e10-c2f1-458e09a707f3@web.de>
Date:   Tue, 12 Nov 2019 21:40:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FtNP+PSosu4jD0ZREgjiXZErk3/RMgWAktWr2ndMs93at79iauV
 kmCXkENoyJ36Rf7R6T6744L1vtEu+niW/0W7T9aqHZKtOFwKGmrSD5yP2jZr9fLgiwFM0h4
 4e+37HTrKv/0yRguNy6mLH9FbsQknvl4UGu7e1HqEjweSfP9PUYxg5wOebSuPswxeWPOG0b
 RlIQs2cUXNPJhgI4onzfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZnVGWoJWIS0=:NkwfHvTB+coNRi9i61vdE+
 mmsRy/c1n++UB/VPeGXOkEupx4+EBEKkQl41MI2gB6qUgS0fdqk+X+FV2eLhQAbMCTD8CsftN
 zU4ocuTOpnZkvDdRcMR28tPox3gExu6YfVDmQNYg2SFCKvQUU9XPcu7ma0IsHL+xZtl9FiliA
 7sRNd2Z88r8f/VbdSYO0NWl/zA7QXVou1pB2Xqn/2i26xTF0YgDsplI+1R43IpecQRmgSC9v4
 1euRKS+gbp+qbMHkn503Pol8fGkIspcHmu2Yjf18XZQScxgDxKHacahr7S/k4LHyks/aL6s8Z
 vxWEAzTdo1Zj5LPmeO3A+9QRvamNgPLbuJD0zW8wnQtu8BwSxiOaHyKKDMSWTX5siV54avrD7
 fcHxMdq2lqNJTzdcEClPpJktteenHqRHsTY0CjEOJMwb18UAY9zRjpLZH3fBrTP4mwXULxUn0
 oh1TTpcEPIVwslavWhZIEM9gMhgpd1ApOBDiZTvWzOSS+ENFG9OVFr5eb8swRVjk3eCVDdRAm
 1cebp9vmSht6zoyZ1F7EuNtamkaMSWJGSP2X5DbVXMoiofCtv4+85GKIuUdN/YkK/aUug6062
 kxQolzUk1n0KHSK0oc/j3pPnAo/uATXubunRUX/BHocEjgC0DbO7fuyHxQYKlwixQbT73n0CG
 QtD0LvJ0jyBpw1mo2fJu4AX44FzT7oOxk1ZfowwF6nH/9OVMl+3XBHaHy/Ftj+kPs8zw5gs/m
 CoZKjfzlLOn0oDvcAGgM4SChb3nwvDH1/DFQ44cw6zgwSbAysQh39Ceu0VTDuCutpnm0UVvpc
 wXmiwAxScI8xT33vx/t7zXrV2d1+lTQ92M9Q1sKX/Ts6xu3fl5kcMQIWSFRoKGdtisKkumvgA
 sSdJOooV3wbyju2Nx6qAQnMilBhoysruYVc9/K2qY/mf/EQ9KLwbxiX8pE376H+FyQPhe61Py
 qOFYXb/QAuPdQ23J00Aj9NTOSLBd2iE3Kk39FDxyiJ6tclRWYH0EvCw/5nHMkBkyKRAC4yU3d
 x/Oaf9TjWJ3ofvmXd1WB7YKeroRfk/9p+BAb2y1BBNoN0lUMi4cRs+KgbyAcvlHOY+j3MAbli
 0zTV6pqAQsNu3x5Vp85wxbUdb+cREMtzgRumdYyLtEdCg+0k8HgdBWRsrrg4sc1yeAohCa2hv
 plcBnsUCZ/vNyBi14kqArkti9HnKtdyZDwe/vyFH4WayhoR2O0UEkAp03p+G4o7HN850fP2tW
 XpuU207VD60Pqt4fgBP7IkmNiKz7AbBBuachJfq+B9V2sl6FmM4Z91CJeS8A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 12 Nov 2019 21:35:36 +0100

This script contained two transformation rules for the semantic patch lang=
uage
where a metavariable was declared but not used then.
Thus remove this superfluous variable =E2=80=9CF=E2=80=9D.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 contrib/coccinelle/the_repository.pending.cocci | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coc=
cinelle/the_repository.pending.cocci
index 2ee702ecf7..ff6a6a575a 100644
=2D-- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -20,7 +20,6 @@ expression E;

 @@
 expression E;
-expression F;
 @@
 - has_sha1_file_with_flags(
 + repo_has_sha1_file_with_flags(the_repository,
@@ -35,7 +34,6 @@ expression E;

 @@
 expression E;
-expression F;
 @@
 - has_object_file_with_flags(
 + repo_has_object_file_with_flags(the_repository,
=2D-
2.24.0


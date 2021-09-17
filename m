Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4F8C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418876112E
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhIQWHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:07:02 -0400
Received: from gourmet.spamgourmet.com ([216.75.62.102]:50039 "EHLO
        gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233843AbhIQWHB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Sep 2021 18:07:01 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.94.2)
        (envelope-from <test.bentolor@xoxy.net>)
        id 1mRLzG-0002Kj-Je
        for git@vger.kernel.org; Fri, 17 Sep 2021 22:05:38 +0000
Received: from mout.gmx.net ([212.227.17.21])
        by gourmet7.spamgourmet.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <test.bentolor@xoxy.net>)
        id 1mRLzF-0002KG-Rk; Fri, 17 Sep 2021 22:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631916336;
        bh=MNpYOh9UJe7PrWeLNI7OMUuPRfJkn90aZ93VbDCZ9Y4=;
        h=X-UI-Sender-Class:Reply-To:To:Cc:From:Subject:Date;
        b=Bf9R+HCKUVH3IF8gPp6XcbpT5ZVfoHDNcFgOXQZqB260po4MTDXbaQLsBqigO97pi
         JSuFAXb/HVXw8ondR6U9lFW0dSuGkHjpIjkwFEYRDwqhU3Uo+wHdN4/V9wHjUqFQd5
         PMuXmYrVyYQMd68So/Pl1gpe6UlA+cxgWMKM3xuI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.8.8] ([92.117.161.117]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1n4Fhn0UTP-00fkLa; Sat, 18
 Sep 2021 00:05:36 +0200
Reply-To:  test.bentolor@xoxy.net
To:     git@vger.kernel.org
Cc:     vger.git@vger.kernel.org, vger.git@vger.kernel.org
From:   test.bentolor@xoxy.net
Subject: CC Spamgourmet test
Message-ID: <3f2da7d4-c4a7-578f-f3b5-217803afd47e@gmx.net>
Date:   Sat, 18 Sep 2021 00:05:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UZb56a4cUsT5/OuQGXTWmXFrsc8UJI+vxPa0BMPDX9YSyjVD89D
 9HtE6gu3FBxh86i8ZbW8f2e5wP3+vDnFXD1yv74noNShsnJltV1i46Q7I2pW7Sxz2DjytqK
 +M8A7wzTE27h+vkJMH699xE2XVgxOLKSp8DHlr7UhNPotU9OZjTn3fivAACdh0oEizoF+BA
 rZekGVAFhb5sK+NokIN9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kt0QlcHPPt0=:GBkMuAkJCVGixTOxs0Qh7c
 AYWWUKSUXYc5ekqRBduhc4r9qilzfAY33wYsOM0UL8GO5aeWaj/Iw8vuVfE6FuE2ZTMrAJqdi
 7lfo340Ah4n5mNGGbEMYrN137T35DYZ/ANhurUWKpazNndo+eMjGZQ4MXmpE3JQN31CAK6Int
 V8xSgKrUbiKADfoHp78lGYkyhMZYxmn/DDwTRLw4ws+tlSaQrfcGmm7q9XODVi/Qf1k0etXXM
 6Obn+w6N1hFDJDq6/e5dZS9S/aXJUqT/1mrbybdCdvSFJ5JCvfS5+G0mq9cRTZFPAlAkCrz2c
 7ZVtmOOgRtw7+1wSEtgz53t9//gHVCjB0Ks1PPymUDbBPXs4vCfaYvrWPsoauJsxEr9rZ4sjq
 I3wHgygx2eS83rRyK3Ek8KjiwIiLJvPXuLIaCMjkorAXrk/MtPWOhZSPzRz7eP9JILLuCyxZE
 +06O4JpJfpQKPEjM95YW/8fFGd8qDttcDyjbnD8wEnsdvkV4Rbu8m42lpK5lZ/htFmEn3FTMi
 ESvuJtKlNI/UVxIpXfO7qgsIA7T6IIxl5msFK9mlOkzjcVq4M0xe35HNQhNXRjgbznwUy34qm
 ZXBJdUFeAmsEDwiV/lkE/FOQAiiPO0Gcd2FOT5W9GAk2S5X6lQ3JyZ5SJA7ZCctGeRXBmJ5OF
 xHsSMZ0Twv6a84iNl9YzWXdGqynFt1K+5YBytD3VpRujKTTLyN6WWmwhxf1tdqZVN8w/RKDK5
 uoDXuD3Mh9oYBiOlLxj2kcdG7p3pRkO14fUw3Omi6GDYx9jYSS+fPV8qvxhwEq9EzeaOasye/
 0SSFTf1XOcLGqsGC5oL5iuW1vlUfGeEkV4r+xsGw0PnPMholI0FMrp0a/pXkZfrEiEioEoXNr
 Jixz8OGB48ELBPSo1zc1D2GLLts+OumHMNSs6FRlhzWE2cDc2UT4Al+hX0mqGdpW9LQwaj0Rx
 zukGybmSKcKizavceNUYBP3xpQx0i5YBx6rs0IXDdtgoGO8GGa9ryOBDJ4IkKM2bAuuHDspOV
 S0ChIxgRpFisiHO3mIrRB1l3pT8nmA+/7orFA67Ihiz1NweO/iLhB5OXtReFyae9IC7XDgZR0
 Jv/+Zg5nKZdW1s=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

trest multiple wrapped emails


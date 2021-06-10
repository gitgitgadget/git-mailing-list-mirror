Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D316C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C6C613F5
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhFJIlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 04:41:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:49899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhFJIlL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 04:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623314343;
        bh=hRHyGvZLWKFdjHFIYOX0OyL7XB7/0qV/Xu/8pQLBqR0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T/mOOxihV7cidyhiIWSag3PvJE16oE0zLv6YRh01VRPNhIJRHJO9VK8U4xKkHQA9Z
         8ibGCP1BHGF7QtPRSFOHDcU4HSDvoNWhihwZ5uE9o0aLXvBKm7usUcjey6klf19Zc2
         +xtk/PXzy4buqcMBmDBeFKJFCEI+Ww+Ga6OW3BR8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNtP-1lTll40G1l-00loPx; Thu, 10
 Jun 2021 10:39:03 +0200
Date:   Thu, 10 Jun 2021 10:39:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
In-Reply-To: <xmqq4ke9v6za.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2106101037270.57@tvgsbejvaqbjf.bet>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>        <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com> <xmqq4ke9v6za.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+RVEYLJuhpJeM1h/WDpXIrYqpdxzYu5tIS5uULwYq3gojp+w/fo
 BZmiRLEDadcL6d6Ya3+U1qfP7OyAyBFYIKaR3F2/cg8JEW2eCfFmZF5Sb8ltOiqc+OyiRo3
 9euUbecd+7SFK83sSu9LIGa5938PFrMKVUtSacV3kTkxSTbZwi9cwohrEjjL9AYfjN6d+Wj
 zs0LMVGyynZeHP/qIUj3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5qj+njV2IJk=:hiy0kq1cFcXUViwIOyxlOJ
 PvePwKTroHTtnuG+J+KM6SrtzcZy9zdHCrs+eO76uv2V2q4Ip2NdHteDoxYQuYxfNlFFpUBYz
 S2pXeBO/kBTmVA29QBkD+Ch0LWpwX0eFKyFEVu1rlrrpTrPU8IWaxOk04Ksqv6C3oDv1lqrOf
 Nx5ZahsgdkY9NWnNjxqQqgL6aq+2YTRPWvoFmGPhxaz2jEXSXeC8r5qUD4EzIXRIVuDEnBpwT
 qrI7YXx6MmTtG6J3x7LW0pyy8SfBV5k2MHIiSPAHsoxFGNARpBeUMuiTo4ahmPN7RMc2xWejq
 r8B0nGkEGI0fu5M2BQevyv3SJxqj2W0Q+srvJAAr4aTnHt80z8Svf3MisAglpBZA7NA5+wPvE
 LxTTsJiSJRHs61jNRZbpVQiyj86X6ju/LbPGKowH1Wa0SecAnFCOcOzXSM9KuolZoJ6G5C0yf
 H5OuXbNcmRORFq/VbK8NLZIBG3Bcn6LGWwF8mRpZLJY3F+Hr9ZWp5UTlAX7o01vhzXKgSyFx8
 re930uhsnHREmWjqZtmYBE9V15T2mnAoLk7jrv14j/l0ZsEBx7Ky+GGHF1rkCuXjctJP1Cd38
 fggISzHrrgU4Hzw8XhjxT+GZAGFUk44+CYFPJX7i9Q8gQOFu4MQPMIjvfWGJUz9PMcf7FFTkQ
 hFzKjjBzS119zxjh8RZ57cbcr3Ph1yl01Zy9dLxYhbSNvazC+jpFCl2bT9TOQz0EDi6IJTp9a
 beSnR5WQ04GzYbujUzej4DXDZsczwLgPXFlf9AWjWB/jGLq4w4dMSb67aBsYpLhfxg5RztT3Q
 97XQD6uJlBC27FweZtqNc4ue2NkLLxBpLdcDcwzOdcLECoLBKsItxjPtl0QEhKa2VztDvCTEa
 upjjjapRJQn69am8C77EhLBz5u6smGsd++jlnVI/6da7Jea1PBPRXI6v0jNdhRg4mVgLywAMB
 WrnbjGDl9gT1EeHsAIGeVlJxEEg9i60v9BuUdxOlqhQ7HhHb50n8ZWREekuHBVkJMq/WxlKID
 xsA5wOKGfkOqcu3Mwqadhj7BJLuIJRnwk640XZlHn/JvlhGqIkhHs2iLJkqYxqqzlmEsBJ2dG
 KYCld9GNat7jFjFFcXVsY/+NoRTJ8e1Iu3OmQyjKpAOy6uG/hlfsyEnMQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 Jun 2021, Junio C Hamano wrote:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > To futher justify singular "they" as an acceptable grammatical concept=
,
> > I include the careful research of brian m. carlson who collected their
> > thoughts on this matter [2] (lightly edited):
>
> The use of "their" here I found going overboard, given that (1) it
> is outside the topic of this change, where you are not referring to
> a non-specific person, and (2) as Brian's siglines indicate, the
> preferred pronouns for the particular person you are referring to is
> "he/him or they/them".

For your record, while I sometimes mention that I use "he/him" to refer to
myself, I promise I will never be offended if you refer to me via
"they/them".

;-)

Ciao,
Dscho

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF161F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 08:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeKOSrh (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 13:47:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:51839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbeKOSrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 13:47:37 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwgc-1fkFlN1Gxm-00n5M1; Thu, 15
 Nov 2018 09:40:39 +0100
Date:   Thu, 15 Nov 2018 09:40:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Tanushree Tumane <tanushreetumane@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v4] commit: add a commit.allowEmpty config variable
In-Reply-To: <xmqqzhucpa37.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811150938070.41@tvgsbejvaqbjf.bet>
References: <87d0rm7zeo.fsf@evledraar.gmail.com>        <20181113155656.22975-1-tanushreetumane@gmail.com>        <nycvar.QRO.7.76.6.1811132021390.39@tvgsbejvaqbjf.bet>        <87zhuc1xcx.fsf@evledraar.gmail.com>
 <xmqqzhucpa37.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-516080992-1542271239=:41"
X-Provags-ID: V03:K1:4LOjBiInFhzPCDClidOGBXgWZYeOKe35jP/v8DWooR5AISxGfbv
 /snqo71uaIcUCH/52iB4BKfm9hu/aqEOCgOuPfea6GcOXMDCcpXR7QOOzz2TIUoyeWxwXiS
 MPDbZyP5Dy4zTcpX4ingahoN29ewyYdXJFoEHKG35WE0mLGKai38mWvY+/awVcv0JCGaKwg
 2UMW38gDtoIyS8lLku5Kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tvn4aWJxwN0=:HBTFAe60DVPWJXGNVIy6d1
 taiRHZjCZCcYN4fwN/OuYwXCUROt+dBZVWA2x0sLPvUr6Z/R2rSAUzJFqwyM5sC/Lf9f5G/4j
 J59376ekjHgQU7VtUoXMq4dST+i4cP4TdDtuBvVVj4+gQTSLdjHFA+o9I7Kf8qZTz+GJ5ra63
 fgvSOpK2v7a+dCmeg8fC6HsIZGDyAZ4NL/LiINlW3dIq2Q+W65qIuAn9SgpZc9A88J4LIkY2y
 2R3N3P0yNC52yECon7eoFlnJeutl6rtSRP77bNPBTy9mKC1fAvEzXxYszfeQks/4+s8ua50Sr
 O1s4KwIFjs2lzQspfOYkcpmWNaE5UBk1iK6y3A/XLAPN/NGWiGDcRGTd42R14YazvslxmWIhL
 CkH7SCTNU7G4CQWKHdvGL51ohqfp5x6Ud5M1U92FWO+wgAQ8BeXSkVVSr8i2XJZPjtD6opAcV
 g3ZAozXdfHc4TvevQDm8CJx0WsiTXbZUiWzJdQ4fVIJel/75ieLYSWrp5BdbuTAj/YVaMrYBj
 WODPVxPI7IFpKjrHU2SQHNZQdNtNSobdUvJPRQzcxQ4TKBE+wGyZwT+Bd6vOrh4rV4vt68Qqh
 MgVTEazmDaTHVYdinxRg3W5Q3jd1V3lB9rL203Z5lwSpgqjokU+0TYcJQM7/O33nLAFTGwBGk
 TKkAm0C4idbY0St3wICQNFVmgvDPfvHGdCkQo1WqsOnGyc4lYhKlHS/fBJA2yFq5UzD7dpj85
 BK1u0Tm3xZAYnpLWXHA6SMm37Rqr6XK4xgOzn5MM1bkSbDQeGb5esORwuigmTsQmRX6adCCK2
 zhGL8Z+Ap0WNeoNv2mbvHsbK6VA55fNWiSi1N2Ic3wyz2T8uDCsa4+wTOYZJyT8cJtleo2fYY
 QrVD14LjbRKeR8vvWRxYEvAdOgE8FsVyzrnXdJfUDznpAjJoMqhMKZxIVdYBWUwN1wbbvs0SL
 u0tiZbJ/ZCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-516080992-1542271239=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 14 Nov 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > Agreed. I'm happy to see the test for-loop gone as I noted in
> > https://public-inbox.org/git/87d0rm7zeo.fsf@evledraar.gmail.com/ but as
> > noted in that v3 feedback the whole "why would anyone want this?"
> > explanation is still missing, and this still smells like a workaround
> > for a bug we should be fixing elsewhere in the sequencing code.
> 
> Thanks.  I share the same impression that this is sweeping a bug
> under a wrong rug.

I asked for clarification at
https://github.com/git-for-windows/git/issues/1854 and in my best
imitation of Lt Tawney Madison, I report back:

From @chucklu:

> my user case is like this :
>
> When I want to cherr-pick commits from A to G (ABCDEFG), image C and E
> are merge commits.  Then I will get lots of popup like:
>
>    The previous cherry-pick is now empty, possibly due to conflict
>    resolution.
>    If you wish to commit it anyway, use:
>
>        git commit --allow-empty
>
>    If you wish to skip this commit, use:
>
>        git reset
>
>    Then "git cherry-pick --continue" will resume cherry-picking
>    the remaining commits.

My quick interpretation of this is that the user actually needs a way to
skip silently commits which are now empty.

Ciao,
Dscho
--8323328-516080992-1542271239=:41--

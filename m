Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07231F51C
	for <e@80x24.org>; Mon, 21 May 2018 12:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbeEUMRv (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 08:17:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:53327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751188AbeEUMRu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 08:17:50 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoVja-1fzp4d46dm-00gY2G; Mon, 21
 May 2018 14:17:46 +0200
Date:   Mon, 21 May 2018 14:17:49 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Clemens Buchacher <drizzd@gmx.net>,
        Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 0/2] Test improvements for 'sg/complete-paths'
In-Reply-To: <nycvar.QRO.7.76.6.1805211334220.77@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1805211414200.77@tvgsbejvaqbjf.bet>
References: <xmqq1sf24syg.fsf@gitster-ct.c.googlers.com> <20180518141751.16350-1-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1805211334220.77@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1367789117-1526905070=:77"
X-Provags-ID: V03:K1:U/GES8bY+pQpC33Gzf69unNwdb1ZGvRKTBmnVgS2TUNE/f5URNr
 jruMpgV8U4Zgeb6Y0+n28xSzIQnjNxUA6Z4MCbVfn+qpEJtniH5GTRWwgI+3O6R1KUqcGDG
 9j2TbX5nemYlPbBoqlEAQPlzEfEE5iMnC0Q11GW4Fmu0aGdfl2marSFe41V12Fd7cGMy9Lo
 9+MsRL+FeAI9G2sgF4cZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n04STbPFqRI=:DpDnE2swwP+6ad+oFWNVXM
 J2a3dD4dgnPqcfco43xCXYoBPXQ8rJVD3TfJ6LMM55uGq4zVn5PtRGaOO12WETy8/Go/pcpH4
 M579V8doWLplzTuWlaCr3bSlIYGxGJ9lTqjDKtY4kJ+7EW+ba4e1YnyO+J0KTWXJKlmbBNRiO
 pV5ah0pX3XIUDU0afUanX+mX6Xou592yUihrsEVwF2+X3KsTIjLzmTCFj831E5u8sDa2RxEOg
 1yFaFX08Z5qGuHFv8tbmZLaYI6DZ/KE9y3eZluJvymcK9WT+KFkoHdNJWkfP9garduTuIKJDO
 tZJDj9PDGG/JnQrnazVQGxXruCsZVzoqqMQwtpSEnc1xcXcyBMB4+8+Na0zeiD93RbUUjeX78
 8dn2EvljqYyuNM2XaLoQ+jfxUKM8k2bZ0HJQvmjQWgeL+hRa8JIGFXg6Ar1DR/c1w3vrmcnGZ
 atFugOEnXbKBTfjEh3RxdNtIqS+KNYukRhCC2CTBldg7fzIIBX8WPDIf+g/lkq0FvDuLowMSl
 GaQKfd3gS+FXZECMfutrGafONJF0BWiyhk3jvWrgKzmPRpsnGfBBJCgCjFuKUlYJPzskkZQyL
 TGx+zbTl4NM2ls/Ur74XAgeLV7LxizBsx/BYSZSq+Z7WfPNAl5Z04ExekySRql6LB309IuUqT
 V0TJpOWeY7+fLaSfBBoF31PoWII3SevpN7vkKnW8lGkGDl6+OUkVrm60J70NCTqvmnJ25QWZC
 y6uK1+2Brs1lEQidoOtWUrWZilERMdF+JZkjL8UAPz1jhjEkWY1XEPZb/2hvKW6YTgKOUPZkb
 DcyeQ5j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1367789117-1526905070=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 21 May 2018, Johannes Schindelin wrote:

> On Fri, 18 May 2018, SZEDER G=C3=A1bor wrote:
>=20
> > > > So, I think for v2 I will rewrite these tests to call
> > > > __git_complete_index_file() directly instead of using
> > > > 'test_completion', and will include a test with spaces in path
> > > > names.
> > >=20
> > > Quite well thought-out reasoning.  Thanks.
> >=20
> > Unfortunately I couldn't get around to it soon enough, and now the topi=
c
> > 'sg/complete-paths' is already in next, so here are those test
> > improvements on top.
>=20
> I can verify that the weeks-long breakage of `pu` on Windows has been
> addressed, probably by this patch series.

Please note that as the branch that is fixed by these two patches was
already merged down to `next`, the Continuous Testing on Windows reports
that `next` is broken.

(I saw that breakage for over a week, but was too busy elsewhere to act on
it.)

It would be really lovely to see it fixed soon, so that other bugs cannot
be hidden by that breakage.

And I would also love to see sg/complete-paths to be merged down to
`master` *only* in conjunction with these two patches, not on its own
(because that would break the Continuous Testing on Windows of `master`,
which is something I really want us to avoid).

Thanks,
Dscho
--8323328-1367789117-1526905070=:77--

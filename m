Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D101F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 11:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394826AbeKVWNQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 17:13:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:44831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390848AbeKVWNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 17:13:16 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MdaCy-1g4x0W3jqe-00PNaJ; Thu, 22
 Nov 2018 12:34:09 +0100
Date:   Thu, 22 Nov 2018 12:33:52 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] ref-filter: add objectsize:disk option
In-Reply-To: <xmqqa7m39swq.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811221232370.41@tvgsbejvaqbjf.bet>
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com> <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com> <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811121300520.39@tvgsbejvaqbjf.bet>
 <20181112131247.GL3956@sigill.intra.peff.net> <xmqqwophyc9s.fsf@gitster-ct.c.googlers.com> <CAL21BmmK_ZS=wuGXRLj=s0=dqMvUWFiLLBZWx5ymnFjyasX=sA@mail.gmail.com> <xmqqa7m39swq.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-429967199-1542886448=:41"
X-Provags-ID: V03:K1:oo6qWaYPdsoBl8YdS62rQsbqTlsEgOCxB4su2/Vo/wHxHs61VvH
 PZUJ1PnGDOBF6LLK4i4qa7g0p7TrVjX2n6c5BaT+/q0HzOfjTebeRsJDQK//QZ6huNDQt3U
 7i1Q+CJ5VPMo96L3z+iQkDxE89J+CGYmK5N1EBF+TEjir4FiMhWH5I1+87Zln/XG4az59py
 ngwih3fq/EwN1zlRUVcPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qw71VfjR45s=:qmxIuq7UU9OjWZuzhg/ZFM
 VO9l/Vi+8n5ozEHiISK21NqY37hu0D3lxmfMvvamdVEslnJ115ZXonj9NriNvwHsh8b49Mgrf
 bor6fb4jJY1pO04RsMT9SMpPMd4W35+hVHIFvBMzGntErLDLz3apPCnJzNfg39Z7C5Ym2KMTV
 UJVukk9PhVRy7aFy0vd8UZ8jHuTE5xW/5VkIyrtt01YJwVhePi4nprx6v4rkrR856D35CEU82
 a/BTo6o1kjV4WQl0yq2PawFVAErmzLdFlhDzHVpAx/3xuHD7HFH8lgJmgnoRnyx0fkO4WeAjg
 LjKAA3D+5aH6CMw+Mb2OpNOJ6tDXjT8KBrYtzeSv7tg15t51I0XGHIEkLPaTwJAl8n5eEqU5M
 DUWn5vsfOPyxMv2uOdUbLYH6W2sBs6vhKOSzEHW5AVJ/4sCC2LdH/VnkG+vfhWDMWHg8LgcCt
 BBveEJEkDT6LnTTjD7U1olAsyMLvc/U97cLUaCymIfj0F49kv/CzD90ev0aKU2SiXb2MNvJok
 uaFmEuQHJWXzt9PNK/UX8b+wCxzTEPLfI1s+0Z1OCAQl+M31z49RYAz7qh9YMXoe4byvHqYgS
 XrV7/mIB4B2lrSlyyLyXRsTSlVGQcVfCBWw/myzpmq+++h37lSzy5VjF/Qtbry/UMM5441El0
 6CdZ1bpP2LjUrbcz39Fu4vRO3p7YJA1taYl3XC9Aq4PLcyQcE29AVHE1ZKU1rSVJbBqXIdSTG
 alPToq2+rs50n7fjMuYHL6UWdLLkE0f0+dfi828KjL+aDfFoGPLjfS+J//LWfAMN+QDUWT/BE
 P42eWlMNju62tprZh3dL8s1NYMJCuEY4CY2+RqrMYE5OL6/Chl3FUHVfGGSkj/TxgsT0ZkCMB
 c5EezR4s4+KqSlHUmUpBfDqY5J6Qer9KFq5pb7DJFR3H9NY4zootQZQtHEGvxf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-429967199-1542886448=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Junio,

On Wed, 21 Nov 2018, Junio C Hamano wrote:

> Оля Тележная  <olyatelezhnaya@gmail.com> writes:
> 
> >> I am OK if we avoid PRIdMAX and use PRIuMAX instead with a cast to
> >> the corresponding size in this codepath, as long as we properly
> >> handle negative oi.disk_size field, which may be telling some
> >> "unusual" condition to us.
> >
> > Maybe we want to change the type (from off_t to unsigned) directly in
> > struct object_info? That will help us not to make additional
> > checkings. Or, at least, I suggest to add check to
> > oid_object_info_extended() so that this function will give a guarantee
> > that the size is non-negative.
> 
> I am fine with the approach.  The potential gain of allowing
> oi.disk_size is it would allow the code to say "I'll give these
> pieces of info about the object, but the on-disk size is unknown"
> without failing the whole object_info_extended() request.  And I
> personally do not think such an ability is not all that important
> or useful.

I see that this topic advanced to `next`, which means that the Windows
build of `next` is now broken.

To fix this, I prepared a GitGitGadget PR
(https://github.com/gitgitgadget/git/pull/87) and will submit it as soon
as I am satisfied that the build works.

Ciao,
Dscho
--8323328-429967199-1542886448=:41--

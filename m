Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29E461F403
	for <e@80x24.org>; Sat,  9 Jun 2018 20:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbeFIUG2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 16:06:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:52831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753463AbeFIUG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 16:06:27 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBJF3-1fZgbL43DJ-00ABbe; Sat, 09
 Jun 2018 22:06:07 +0200
Date:   Sat, 9 Jun 2018 22:05:49 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
In-Reply-To: <20180609065635.GE30224@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1806092200490.77@tvgsbejvaqbjf.bet>
References: <20180607145313.25015-1-git@jeffhostetler.com> <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org> <20180608090758.GA15112@sigill.intra.peff.net> <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de> <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com> <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com> <87bmck4gip.fsf@evledraar.gmail.com> <20180609065635.GE30224@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-510741496-1528574767=:77"
X-Provags-ID: V03:K1:He2qjYq8JuH3NyOLyk9y+lWMLA5IpBcf8rm6pos6wQ9nWLEVr8g
 68ElJN+7y9TkN+kwzo71AnJpOnY8ICL9UxVjquwOJTKZqlskCMRzA+BrZPSlp1DYX9Gt5MP
 LAvcDl3eNzdF5zqDVO9QK4REvPxqdkI0TWbb+pqKtl9JSI3WI7Y1dqJuu0+494lCy5CGH4W
 oqtISpyXCGEgswCUWatBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cUck4HhKiyQ=:p+SPLmZpMu+2CCL/xE2WID
 fxGW0DZakDYVeE2qASy4k6il0VpFX0vydObS++7zroRhcyz6jDVpTqhujJfjJJWXDBiy8FN47
 byhkwunjokNl3OMBVwd33rBgaY+Nm2Vfe7LMUoLTlYn2InLo39VWg4OuX6bfaJoRcwmiwXyjc
 UeyS1L9uSvpRjmXddsrsntFVMbqnR8RPi+pKvE6gJ0APOzvJ7oCDfgefRuxvlAqTtMxCEnHSF
 XpdiBguXIich+RhszmTANurRfUDwVVOcSHAsd3oGD6AcCf/kHDh3cLZwnphhUUva3DsbLHGDQ
 LqUmxj/uH+ZUjkY1AYO+ZFQi1emNbzY0S1cyMRwXBxoApUxfpyJYWL2eOICrbvxzSTVzU2bju
 3iQrJlo9zwy899Z8gD4jkXtyL69uZgirRL8PrDnqpX8bxmhaGOLodAw0smKGjH0BtTDm2WNrD
 Rb8MtJd7oNF0OX2n7DIJpJsieA4YXfAFQM9WtQUfw9a01/ZBVoBtGaHV5Q/mmMIsIn2psIfWf
 E/IHbJHiObexlQmUxkLuAUcgPh8yz4YHX4gGFLV3SV7NXcDzuTxKJFjGdwL38gNH10VOBuAIJ
 ZZelkMYgOtz+LLfclL2gtQlbnLAs/eFZ1UFiBqOovpK5pweLwR1RELaD6n/FVIEiScwVEnX9Z
 iMIA1XinSzcmeIrHCi3G4GF58s16SSQGGPpOHYAnuFBLSxza9zM1NvZGA9Hwo2IvMO4PpzCBE
 zJSAzDjQMNiyYaVvk/7/0qqAWbudQyn1SPKz9mmXAZWhrU68ALigRnqTb3A4ABADQfDUKtNlh
 Y8qoptl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-510741496-1528574767=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Peff,


On Sat, 9 Jun 2018, Jeff King wrote:

> On Sat, Jun 09, 2018 at 08:31:58AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>=20
> > 1) I really don't see the basis for this argument that they'd need to
> >    patch it out, they're not patching out e.g. GIT_TRACE now, which has
> >    all the same sort of concerns, it's just a format that's more of a
> >    hassle to parse than this proposed format.
> >
> > 2) I think you and Johannes are just seeing the "telemetry" part of
> >    this, but if you look past that all this *really* is is "GIT_TRACE
> >    facility that doesn't suck to parse".
>=20
> So that actually takes me to another question, which is: instead of
> introducing a new "telemetry" feature, could we make GIT_TRACE suck less
> to parse?

That's a different question, and even a different concern.

Please understand that this feature is needed for our own in-house use, to
be able to help our users pro-actively. We really want to be able to
contact a user when they struggle with the performance of any given Git
command, before they have to think of reaching out for assistance.

We discussed this plan at the contributor summit at GitMerge, and IIRC at
least Autodesk and DropBox were interested (but of course, the changes of
both Lars' and Alex' roles might make them less interested now), hence
JeffHost wanted to contribute this, for the benefit of the larger Git
community.

> E.g., could we have a flag or environment variable to have the existing
> traces output JSON? I guess right now they're inherently free-form via
> trace_printf, so it would involve adding some structured interface
> calls. Which is more or less what I guess JeffH's proposed feature to
> look like.

I think that is a much larger project than what JeffHost proposed, and
would unfortunately put too much of a brake on his project.

Ciao,
Dscho
--8323328-510741496-1528574767=:77--

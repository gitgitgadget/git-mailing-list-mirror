Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601BF20437
	for <e@80x24.org>; Tue, 31 Oct 2017 17:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbdJaRQm (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:16:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:61201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752335AbdJaRQk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:16:40 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M97Nh-1dzuQw0V2r-00COBZ; Tue, 31
 Oct 2017 18:16:19 +0100
Date:   Tue, 31 Oct 2017 18:16:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Bere=C5=BCa=C5=84ski?= <kuba@berezanscy.pl>,
        Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] t0302: check helper can handle empty credentials
In-Reply-To: <20171030182718.oyzhjffd6jd4wslu@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1710311814260.6482@virtualbox>
References: <cover.1509383993.git.johannes.schindelin@gmx.de> <e055913ec27fc3feb3f017747560f454f6817a0b.1509383993.git.johannes.schindelin@gmx.de> <20171030182718.oyzhjffd6jd4wslu@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tSLDTLgKPe2Avs4dCSj7nH0HLEC4CXAtkrJz9qVP0Y3hetJ3YK/
 hSde7zdbtATkgtP33WqxisRaDRhFucq2u/UEAzNsC465+FfjDA0D4EtmK/V4Zq8EMtCGc8c
 JKOvgpIsjUisVYrXojNlL+nmkhGhmM46BH/pceTnQrP+rj4wCgZFTGeitRirXCmDQlmgzPe
 xRglNle/Rsk+Qiz48hxuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UnfcA53ZGxk=:GwxUvDeQxIls7Nwk8CJjcm
 AXDDkrrVARbh1k89g849aR6VMNwktv84nlMnNWVvOHUBw4rDjYCdveg8Pup6nRMr5UWCY6HvB
 0y3NR8kFBVKzZfg2s2iQjenITDo/fKIW0TI1DNMsTBOth0jxKjMYkbFr7P7nuCEfr+/ur6aAp
 SNY+FPhgA4MQ7bjYp3LZEd5EzBOs7Mv178Hg6FuqiakhTdELXFJKgOqsFibkP3E0OF6mfj5hb
 hL2X+7GqHrjRp4RFHx9tU4XddE/0J5utkSLHbvBCryACO/mBzXQ3n7S2ESDHRXKjA92PGEI4z
 HQ1IUy/1iWiLEdO9mWsLQ7YXWrf7hJCbRjuGmsGHmCXaperR27ziJln1KQupflsOLE0SmhMsG
 HqsYp/zY5jit8EDGftu8h0bnIKm+IwBNI5+Pyjrv98FCKz1UdaYDDThSTo+ZzcDk8w0riBSoz
 jnJR/CCuk7his96hqY1nc1UAVUbDHXtQN19BtYLD0pw8xmciw3w0YwGkDB9d73bGB+obCzMu3
 95qhn+lHYiYkAwJ7iW7hA0HiZuF3BVOLZD+MzO/unOVanyn8g8jt83zrLfTl14T+hH13oNIpF
 NTaA1iEmB1xPYR9WG6B4Tz6Bhuqha0wdpStJ3S+CAvmjSmBijfdw4cKnf17fTSj8IIeyQaCRg
 oHpnp2MHXPrfUeZzFtvBXFH2WBjni5vFPzPUwgk8EmDC4sTy0/UAHujUPeKnK2Ihkfsz6Y+VO
 Wa4isijTVtx7KK9wGweSpueMs6c0nN928Uph1g6aTdJvKTA44F+COAfE1AssMCkbQrYkGO69Z
 n682ST6yjJyq7rVJj7+4dUkiVefniMGsp89b5Fzzum9+8cdwZGxGaA1YHQkYMUJuMC2B7O3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 30 Oct 2017, Jeff King wrote:

> On Mon, Oct 30, 2017 at 06:20:12PM +0100, Johannes Schindelin wrote:
> 
> > Subject: Re: [PATCH 1/2] t0302: check helper can handle empty credentials
> 
> I guess we really care about t0303 here (which tests external helpers).
> This patch adds the test to lib-credential, so it hits the "cache" and
> "store" helpers, too. Which seems to pass, so I guess that's OK (I have
> to admit that as the author of those tools, I wasn't sure how they'd
> react).
> 
> > Make sure the helper does not crash when blank username and password is
> > provided. If the helper can save such credentials, it should be able to
> > read them back.
> 
> I worry that some third-party helpers might not be able to represent
> this case and would fail the test. This has been around for years no
> Windows, but probably hasn't ever been run with osxkeychain or
> libsecret. I'd be OK with taking this as-is, though, and waiting to see
> if anybody complains. At that point we'll know if the right solution is
> enhancing that helper, or providing a way to optionally skip this test.

Okay. If you change your mind, please let me know, I would try to set
aside some time to adjust the patch in that event.

> (Though I have no idea if anybody actually runs t0303 against
> custom-built helpers in the first place. The process is pretty manual
> for now, though the Makefiles in contrib/credential could probably at
> least provide a "make test").

Right... I am not aware of any attempts to run those tests against Git
Credential Manager for Windows, for example...

Ciao,
Dscho

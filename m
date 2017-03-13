Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BDCF1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 17:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbdCMRU0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:20:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:60990 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753501AbdCMRUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:20:25 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MW9TR-1clVhO1T4L-00XNtY; Mon, 13
 Mar 2017 18:19:59 +0100
Date:   Mon, 13 Mar 2017 18:19:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 09/11] Test read_early_config()
In-Reply-To: <xmqqa88tymys.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703131819160.3767@virtualbox>
References: <cover.1488897111.git.johannes.schindelin@gmx.de>        <cover.1489098170.git.johannes.schindelin@gmx.de>        <72b36d27cefc0060f170b33f19cf504bb0338c1c.1489098170.git.johannes.schindelin@gmx.de>
 <xmqqa88tymys.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:px739x0db+Db5+5NS98uRQ4XhGa4TSekD0QeL+TqZaMDpNMEP05
 /Tdl57l10O9N4labps60WyLTU1ztV4KHBpvCDGD6qMMkOhe944V0poPL/abQ3bSKjrArP+C
 jF+SPswGwQmMozdmIFplTNREScpqFkOUuIZkovqrZgTGctF9AvCMyZys0iGCRrQN/qGA+Xv
 ulWFKj6IXymKpB+hFZ4yA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:odwdXRx3lZ8=:CEsd55WBd4PTZfIJY15z4y
 o8Sz21VtgaPOZQmuZ+BFJrQqtiCBFJayLlO4NQOLnmndTnR1/ykVh1Ec0GasHpt6rai3uEFiZ
 ec7GJnEI//g4A3UMW453XgPTex7O17076xOZHxnDndxJd+6hVJ/CCMn09yehzODu5NXLxoqvL
 cBIA0u/kUI9+xNuN5RjSLw90ewoNyh78dkXG4DQNUoAWk3GBYOe7fwaL5u2zdBLerUsPDaAu5
 75odL7ODDmwkDoFJRT4wHfJABH2EoMmGW7rhpvHR1EDneaG7ZSboIMsy4B9h8rYnyZx4BTqgQ
 VPEB2DQeZVeJynPQruyI9Bq9eZbvM0lufux1tOPspc+Y1T2uuJ6z/tr2MtoqpA69H5kxhCT23
 OavsIkRgeEeK7uOgz+7cQRd1FczFvugDHzDpSkTdLUFZK/Q07pSvEGFn91i0maLBo68JzgkdV
 aQlkfg7uc1KcJq5G7s9R2/7fkYQltjG9uGWRC/Xd2fYgCqgcQ1irqq2QKqJLnEs6Di7u9cE4s
 Xb+CP5XOHV7pKA5e3ZvZDuU5BrkA3+VJ6rJMdSunVtk/kFAIDjHI0+w7/QTfOJu3jbo8U3giw
 VGLyaAydFJPlUsdNYW5Gt5SLyXdvidA/nZzbe/tUILsaRILbgpWa1Idm8D/mJ6ElFVpSB5Wbh
 /RrRFY9PbNgSyjUXQUSaxSvVIrYNmN4mub32NH/pRbXH/cH2RVNxzGMcXpArCBOB3HXTfPE6s
 maeOgHT4MLEjkMScJba9OYvqPAZttZCWEPxoE4w5AEg56VebEvLGo8dSGyzGd/3nJzoT2By0O
 qU70Wvk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 10 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Subject: Re: [PATCH v5 09/11] Test read_early_config()
> 
> Let's retitle it to
> 
> 	t1309: test read_early_config()

I specifically avoided that, as it would sound as if I modified t1309. But
I *added* that file.

Ciao,
Dscho

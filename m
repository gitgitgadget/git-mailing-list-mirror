Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73B62018E
	for <e@80x24.org>; Wed, 10 Aug 2016 18:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938588AbcHJSlq (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:41:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:53131 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938417AbcHJSld (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:41:33 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lkwpt-1azEAJ3rBV-00aliI; Wed, 10 Aug 2016 14:13:31
 +0200
Date:	Wed, 10 Aug 2016 14:13:29 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Elijah Newren <newren@gmail.com>
cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2016, #03; Mon, 8)
In-Reply-To: <CABPp-BEqRFid1_2_B+Q_FyVN3KeApV3pknG7FrfaMUoyY6WJGg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608101412430.4924@virtualbox>
References: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com> <CABPp-BEqRFid1_2_B+Q_FyVN3KeApV3pknG7FrfaMUoyY6WJGg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yurM9QnMp2Tnao3aH4yRIVJeGliPtJJEh9+EhvPOmZ7LEb2Y7dQ
 yin2pwy2zArdQOWMAGvW6B9YPlp+NmyH+uBshb6MdABss1U9c0At46bZo9wLZWlcnD2XCKQ
 9l2+oMw4Y9uOfCnJtSzT4Bxa3ZOpJg7f4z7pcRl/UxqaZq/8UKX4nTc5ikIz/Z+zgtJ7Iug
 lGyiwIphrSv/pGGWSyoTw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:FKRX69okOL8=:TxLIyOIKvYVhwm0c45Jsxr
 fEI4SQOU0a2JSE+rMsniUHBnrBvNN3wnaFBdoYOiPTJDwJdW5J96b4aZoVXgALcsKZYk9Lf9Z
 T+PPb8juEVq8kvZkN1+ynhWOrNoqk69Y0lHsMNTCKnTTTM/JrHh3xn+w5hKtb9yOo+5d2rgi4
 E1UUlaEIbOmpgC67dy8l8KtwWuV50gFaOMNy1BklWUUGM7ioTlKS0sWy3yPMdc/AcaRQIQy8A
 YdaR4GgfbkO7dWceJg1k3FkxDyUOkJr+weumwVFttOHjzab2UGAWQ4kUcs8aOeK9cRhr4VLGx
 QLQ2oAhUlDM6ph8/RVOaZVVjem3XNJoe9nRNCt677gNZbfDKDWmCuUVFFosscFXKwkK3bFrv9
 QjIPR7fX+bknBvAK3kh+2FHEGhZYw7RhrU0LhXTbpm4ugyBhBZ5U57e6oZKDHdn5ZkXLbQMTO
 nlCIZpUmRWN2K/iOmFTW/NVuhgs5nBMJteKHu5Wxsa67mTJfJCxeXVb2lSU6UEt9vgGtXxRoX
 wU8jjHdu+CfdwPlXuQgN+NHv7y7juHti6Q9FZiO+1kISWxjOzSbSZP6N0VE8E1QHtADCzcSDM
 PFfghPU+Au+IoCJPsyfGMn1pR46E/BdlBf67GA9qEEmpYpy1SAwszY9mKTh37d714nP6FDCDc
 C9nWTwQi6CKgRM10DNK4jOAFeCZ6KRo+Kl4Ne4FBFF4wIfFOnSIivBPEQm+oxpk+sC1x7DliD
 +IPsqh6XNubZxK9m7YhFEsw2kFNa89ekvdbSvidMtPTmUkrM9WGwBEJLzDqXgQKELFYh0ij+f
 Wi48vs/
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Elijah,

On Tue, 9 Aug 2016, Elijah Newren wrote:

> [... detailed review ...]
>
> So, I think the series looks good.

Thank you very much for this quite thorough review!

> Sorry that I didn't spot any errors.

That's quite alright with me ;-)

Thanks again!
Dscho

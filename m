Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3B872070C
	for <e@80x24.org>; Wed,  6 Jul 2016 15:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbcGFPfG (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 11:35:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:50462 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755287AbcGFPfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 11:35:04 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MO7Ca-1bFKg12LJs-005XPm; Wed, 06 Jul 2016 17:34:57
 +0200
Date:	Wed, 6 Jul 2016 17:34:54 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3404: add a test for the --gpg-sign option
In-Reply-To: <xmqqeg76vmzb.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607061733200.6426@virtualbox>
References: <cover.1467210629.git.johannes.schindelin@gmx.de> <0df34c45db5b1500e55262c8948c9140e7ad6cb8.1467210629.git.johannes.schindelin@gmx.de> <xmqq8txn4zm5.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606301019040.12947@virtualbox>
 <xmqqpoqxz6kp.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607020933080.12947@virtualbox> <xmqqeg76vmzb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Co04SwNdB4zScITzGar7gaNaRCYQcAsxIsEg2afCo1myoj5x2SJ
 LPhMjO1ESmzghcQwIgjp37xX0Q8bGZKVJ+K2KixPvTZUHQk0NxPYrjlGmW1qbTsIV4pGqbB
 TBtQjBrx58p/X3dxvLuM0pPlkgWkDGNJHGrGFditBz9GihUhvAycshoCF+gTEAC/HGvASXS
 BykDVc9w41ZFYS5szDsnA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7gvKp8gYOSI=:TUSo6d4DEkWPBiFqrfmcXD
 BhVX9YxVis7ZNMHjI7jtC1CduvZ582qWB1W/0clP/XpmrYl1HO5axLMRNSezEDjm38DmSkMzO
 XHLARE6L21INL70UrC+til3cnGJl+KuhjTyqKBtBzJ+uG73C7858sOHQJBxAiej6QYCPPfdS6
 seWS4nIIAUd/UzZldOBnRy3oCwqrOv5/+k9L/4MnTonzmVSbYEuGRsEqlAPTdA9OaaZjvx/um
 yxBbbIRT8Tqa793aWblmMksTC0Yzqh+4FYQDSh+P5r+zNSddi/N/OkTSyym4hUQR1zNCATUmP
 NyNX8YA6SHYlKUutfzwhHl9/t/XzdI3zHPzf+PSLuBhDcfWUqqaflm8J1MDULBUZyeZ33Xw8N
 bwOdbIAHNh7m2D9s5Q86WE40qFiQv3LAdye0Vbo1WV7afP4MgiKvbmgAcXjFlYxoulBJw+aD+
 465+6bTCDZMBc3sNFIGBPdhM/Ht5IymY1NKb3Qa1S7ycvIBvP9rfFaipNfRBLYATeLc/bQawl
 vN9bzVY5ZsEDvMzpGpyXZtK5Oa/B9DuBVe2lZqJudt1hFIGrfh7eNROLrNfQRunC6XWcNV0nK
 0uxZnOmAyCjzzHigR2BWP4yYyTszCcyyz5EI1BznCluP6CXAwGgMCYFRBFwgrbeQk0yfjvTT1
 gPCb3CzrFxSAtoW2AEUNHqEccx2rnB7pDfSSjFK1IK4rqqceQy/Qr9D9Vg9m8aAXOwVlJyykf
 BidSO55P2XgTrdZNW/C2eMCa+dzmyyIgQKthmR42vcNEnC9zzeYL90WptzddTGDaQjx0+4Cp/
 7jaHDVB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 6 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Of course I agree that it would be very nice to have a test at a later
> > stage that does exercise GPG if it is available. But would it really
> > be so terrible to have a (simpler, not as complete) test that is
> > exercised *also* when GPG is *not* available?
> 
> What I would expect is "In the ideal world, we may want both, and in an
> imperfect world in which we can have only one, we'd rather have the
> 'even though we can run it only when GPG is available, we make sure that
> we drive GPG correctly' one, dropping the other.", simply because the
> end result matters more, not how the instruction to the end user is
> phrased.
> 
> Sure, in even less perfect world, having a superficial test might be
> better than nothing, but reminding ourselves to aim high (and make sure
> we document the decision when we punt) is an important part of the
> purpose of the review process, so...

Okay, so here is the deal: on the development machine where this was
developed, I do not have gpg installed. So please take this test case just
to make sure that things work as intended for the moment.

Before sending the last rebase--helper patch series, I will make sure to
add a real test that requires gpg, and submit that, too.

Deal?

Ciao,
Dscho

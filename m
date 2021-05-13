Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A62C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBB961421
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhEMNJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 09:09:47 -0400
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:30113 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233880AbhEMNJk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 09:09:40 -0400
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 114803624DD
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:08:28 +0000 (UTC)
Received: from mailgw-02.dd24.net (100-96-18-74.trex.outbound.svc.cluster.local [100.96.18.74])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 73C0D3627F0
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:08:21 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from mailgw-02.dd24.net (mailgw-02.dd24.net [193.46.215.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.18.74 (trex/6.2.1);
        Thu, 13 May 2021 13:08:27 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authsender|calestyo@scientia.net
X-MailChannels-Auth-Id: instrampxe0y3a
X-Versed-Zesty: 5ee0a4e547a1409c_1620911302286_1116510204
X-MC-Loop-Signature: 1620911302286:3095768409
X-MC-Ingress-Time: 1620911302286
Received: from heisenberg.fritz.box (ppp-46-244-246-192.dynamic.mnet-online.de [46.244.246.192])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: calestyo@scientia.net)
        by smtp.dd24.net (Postfix) with ESMTPSA id 7E86B5FC25
        for <git@vger.kernel.org>; Thu, 13 May 2021 13:08:17 +0000 (UTC)
Message-ID: <123ef9e4f5dfe64e62dbdb207633df06cd94e818.camel@scientia.net>
Subject: Re: git-sh-prompt: bash: GIT_PS1_COMPRESSSPARSESTATE: unbound
 variable
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     git@vger.kernel.org
Date:   Thu, 13 May 2021 15:08:16 +0200
In-Reply-To: <xmqq4kf7cmaj.fsf@gitster.g>
References: <f1fc174b10ca5bc8b54ede513bc79e3864d8e014.camel@scientia.net>
         <xmqq4kf7cmaj.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2021-05-13 at 13:03 +0900, Junio C Hamano wrote:
> Would
>     $ set +u
> fix it, I have to wonder?

Damn, I'm so blind ^^ Had recently set -u to try out whether unset
variables are used anywhere.
Yes it fixes it.

Thanks anyway for going to fix it :-)


Cheers,
Chris.


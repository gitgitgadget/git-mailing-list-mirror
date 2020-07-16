Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A23C433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 16:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0626D20739
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 16:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgGPQxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:53:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:59384 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPQxm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 12:53:42 -0400
Received: (qmail 25336 invoked by uid 109); 16 Jul 2020 16:53:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2020 16:53:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27199 invoked by uid 111); 16 Jul 2020 16:53:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2020 12:53:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jul 2020 12:53:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with
 extensions
Message-ID: <20200716165341.GA1072075@coredump.intra.peff.net>
References: <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
 <20200716062818.GC3242764@google.com>
 <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
 <20200716110007.GD376357@coredump.intra.peff.net>
 <20200716122513.GA1050962@coredump.intra.peff.net>
 <xmqq5zanifoc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zanifoc.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 09:32:35AM -0700, Junio C Hamano wrote:

> We need to declare that any names under "extensions.*" is off limits
> by end users regardless and write it in big flasing red letters if
> we haven't already done so.

I thought this was already well-understood, and it was definitely part
of the plan since 2015. Are other tools really sticking stuff in
extensions.* that we don't know about?

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A71A2042F
	for <e@80x24.org>; Thu, 17 Nov 2016 01:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940978AbcKQBp0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 20:45:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:44229 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932947AbcKQBp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 20:45:26 -0500
Received: (qmail 11181 invoked by uid 109); 17 Nov 2016 01:45:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Nov 2016 01:45:26 +0000
Received: (qmail 23679 invoked by uid 111); 17 Nov 2016 01:45:56 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Nov 2016 20:45:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Nov 2016 17:45:22 -0800
Date:   Wed, 16 Nov 2016 17:45:22 -0800
From:   Jeff King <peff@peff.net>
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Rebasing cascading topic trees
Message-ID: <20161117014522.lzk43sfmpl4ted3d@sigill.intra.peff.net>
References: <CAM+g_Nsiu_qqapB+FvwJCBfwEYLTPdHg4DueQWHq4XDNXMCgpQ@mail.gmail.com>
 <xmqq7f83ouqs.fsf@gitster.mtv.corp.google.com>
 <CAM+g_Ns-9Sj5r0V2XXZfGQz+0XiO1O-hT03japEGibkNgh8a4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM+g_Ns-9Sj5r0V2XXZfGQz+0XiO1O-hT03japEGibkNgh8a4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 04:12:20PM -0800, Norbert Kiesel wrote:

> Yes, `git rebase --onto topic1 topic1@{1} topic2` is the answer!

See also the `--fork-point` option, which (I think) should do this for
you (and is the default if "topic1" is the configured upstream for
topic2 and you just run "git rebase").

-Peff

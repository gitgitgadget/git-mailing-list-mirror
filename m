Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1011F428
	for <e@80x24.org>; Sat,  6 Jan 2018 04:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeAFEnp (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 23:43:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:36170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751775AbeAFEno (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 23:43:44 -0500
Received: (qmail 25196 invoked by uid 109); 6 Jan 2018 04:42:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 06 Jan 2018 04:42:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13654 invoked by uid 111); 6 Jan 2018 04:44:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Jan 2018 23:44:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jan 2018 23:43:42 -0500
Date:   Fri, 5 Jan 2018 23:43:42 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Isaac Shabtay <isaac@shabtay.com>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
Message-ID: <20180106044342.GA9948@sigill.intra.peff.net>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
 <20180103222821.GA32287@sigill.intra.peff.net>
 <CAK2k7nQcY+QQBfda6CHM8tFo3i4XX2tXxHKv73t6SJ4rRvWo1w@mail.gmail.com>
 <20180104040124.GA11626@sigill.intra.peff.net>
 <xmqqfu7kcca9.fsf@gitster.mtv.corp.google.com>
 <20180105195705.GA5217@sigill.intra.peff.net>
 <xmqqmv1savcg.fsf@gitster.mtv.corp.google.com>
 <20180105205227.GA6958@sigill.intra.peff.net>
 <xmqq4lo0aq56.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lo0aq56.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 05, 2018 at 02:37:25PM -0800, Junio C Hamano wrote:

> Well, MaintNotes on the 'todo' branch needs a bit of updating, as it
> says something somewhat misleading.
> 
> -- >8 --
> Subject: MaintNotes: clarify the purpose of maint->master upmerge

Yup, this makes sense. Thanks for clarifying.

-Peff

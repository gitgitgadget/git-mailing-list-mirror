Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126B21F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 13:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfHLNkD convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 12 Aug 2019 09:40:03 -0400
Received: from elephants.elehost.com ([216.66.27.132]:44954 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfHLNkD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 09:40:03 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7CDdugt045757
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 09:39:56 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Phil Hord'" <phil.hord@gmail.com>,
        "'Christian Couder'" <christian.couder@gmail.com>,
        "'Git'" <git@vger.kernel.org>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>        <20190809001315.GA87896@syl.lan>        <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>        <001e01d54ebb$9a1ab4b0$ce501e10$@nexbridge.com>        <20190809162900.GA9094@sigill.intra.peff.net>        <xmqq36iadygk.fsf@gitster-ct.c.googlers.com>        <CABURp0pb4QY+Qbvn6YAtQ=bevSQW+vQXFMChyd_phtUK4P5M7w@mail.gmail.com>        <20190810061006.GB25876@sigill.intra.peff.net> <xmqqwofjb4k4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwofjb4k4.fsf@gitster-ct.c.googlers.com>
Subject: RE: What's cooking in git.git (Jul 2019, #06; Thu, 25)
Date:   Mon, 12 Aug 2019 09:39:50 -0400
Message-ID: <003201d55113$6d4c8ee0$47e5aca0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI4e27fuor1V6G+VVNTu5eJdxwFnwIJ14M8AThYM+cBjxQPvwDbr1bYAlF6Lm8BoBf+awI5MNKEAS6+gR6lyPwSEA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 11, 2019 8:39 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > IMHO scripting around "action" commands like checkout is less bad than
> > around "output" commands like log. The general action of "switch to
> > this branch" is unlikely to be changed much over the years (or via
> > config), but the output of log, etc, is.
> >
> > There are no guarantees, of course, but I imagine that the tradeoff in
> > simplicity of using git-switch versus manually reimplementing it is
> > probably a good one for many scripts.
> 
> Another reason why scripting around "action" may be OK is that most of the
> time scriptors would want to (blindly) adopt improvements made to the
> underly ing command anyway.  If you scripted around "git checkout" before
> we introduced multiple worktree feature where a branch that is already
> active in another worktree is protected from getting checked out elsewhere,
> your script will automatically get that protection (and more importantly, the
> error message given as an explanation to the end users) for free.  Of course
> your script must be prepared to react correctly to a failure from "git
> checkout", but that goes without saying for any command you invoke in your
> script.

That would describe my subcommunity pretty accurately 😉

Thanks,
Randall


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96B01F461
	for <e@80x24.org>; Tue, 27 Aug 2019 14:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfH0Odg (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 10:33:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:54356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbfH0Odg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 10:33:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4AEB4AEBB;
        Tue, 27 Aug 2019 14:33:35 +0000 (UTC)
Date:   Tue, 27 Aug 2019 16:33:34 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     "Giuseppe Crino'" <giuscri@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190827163334.12d684b9@kitsune.suse.cz>
In-Reply-To: <20190827135149.GA1715@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
        <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
        <20190822170817.GB35435@google.com>
        <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
        <20190823082900.GG20404@szeder.dev>
        <20190826191455.GA25695@sigill.intra.peff.net>
        <20190827135149.GA1715@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Aug 2019 13:51:49 +0000
"Giuseppe Crino'" <giuscri@gmail.com> wrote:

> On Mon, Aug 26, 2019 at 03:14:55PM -0400, Jeff King wrote:
> > So it might make sense to push these rules into "git mailinfo" instead
> > of applying them everywhere. But we'd still need something at least for
> > GECOS, where "Your Name,,,," is common.  
> 
> What's the GECOS you mean?

https://en.wikipedia.org/wiki/Gecos_field

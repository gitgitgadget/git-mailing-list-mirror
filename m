Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8831F453
	for <e@80x24.org>; Fri,  5 Oct 2018 13:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeJEUD6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 16:03:58 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:51821 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727701AbeJEUD6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Oct 2018 16:03:58 -0400
Received: from tri.shiar.net ([83.161.198.138])
        by smtp-cloud7.xs4all.net with ESMTP
        id 8PnAg7tNyw2L88PnBgdNHU; Fri, 05 Oct 2018 15:05:18 +0200
Received: by tri.shiar.net (Postfix, from userid 1000)
        id D2DCD214397; Fri,  5 Oct 2018 15:05:16 +0200 (CEST)
Date:   Fri, 5 Oct 2018 15:05:16 +0200
From:   Mischa POSLAWSKY <git@shiar.nl>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, myon@debian.org
Subject: Re: [PATCH] grep: provide a noop --recursive option
Message-ID: <20181005130516.3qnhtjg7js53iomf@shiar.net>
References: <20180929140132.GA31238@msg.df7cb.de>
 <20180929145527.23444-1-avarab@gmail.com>
 <CAGZ79kbw96x2Dow7d-sUfOHXiVN8j9KgqEObo+TrVd5zWKbaEA@mail.gmail.com>
 <xmqqftxkztzb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftxkztzb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt 20170113 + Vim 8.0 (Debian 9.4 GNU/Linux 4.9.0-6-amd64)
X-URL:  http://shiar.nl/
X-Accept-Language: nl, eo, en
X-CMAE-Envelope: MS4wfPvLX1qTwtF6A0Gfrf9/73U89TMVDSiJu4HvSQmTUAjOBDpWTx2siZndaJ2acjkRpjTr0YRY/isAnWxZX7hvtZDW0ZD/wxKE9em/JnwnOPET7zLf41gD
 K2IsgbwcwVU6UTTe3qWaHgiwzT35qaaM1ID8ojwTfg7gDW21S2V8NRvtGEOq7Iyw0tcRCLqopbr0GhHF/UMY3qJQzTdUVhHbkgYtOmJ0YG4pAmDHCE/YsuMy
 C0qFKiawylUVpcKUpCxYFRZtqceqtsUA5VYA3DB4Rfw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote 2018-10-05 1:19 (-0700):
> Stefan Beller <sbeller@google.com> writes:
> 
> > git-grep is always file/tree recursive, but there is --recurse-submodules
> > which is off by default. Instead of providing a short alias to a noop,
> > we could use -r for submodules. (And if you happen to have no
> > submodules, this is a noop for you)
> 
> I am not sure if it is an overall win for those who do have and use
> submodules to easily be able to go recursive with a short-and-sweet
> 'r', or even they want to work inside one project at a time most of
> the time.  If the latter, then using 'r' for recurse-submodules is
> going to be a mistake (besides, other commands that have 'recursive'
> typically use 'r' for its shorthand,and 'r' does not stand for
> 'recurse-submodules' for them).

Personally I would welcome a shorthand for --recurse-submodules,
especially if --r^I no longer completes to this.

It is also closer to the behaviour provided by grep -r as that recurses
into submodules as well.

Regards,
-- 
Mischa

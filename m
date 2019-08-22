Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA591F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbfHVQ1f (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:27:35 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:52719 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729213AbfHVQ1e (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Aug 2019 12:27:34 -0400
Received: from tri.shiar.net ([IPv6:2001:982:11b7:1:dacb:8aff:fee3:29ec])
        by smtp-cloud7.xs4all.net with ESMTP
        id 0pvvieBWgThuu0pvwilM8m; Thu, 22 Aug 2019 18:27:32 +0200
Received: by tri.shiar.net (Postfix, from userid 1000)
        id A00EC2973E0; Thu, 22 Aug 2019 18:27:31 +0200 (CEST)
Date:   Thu, 22 Aug 2019 18:27:31 +0200
From:   Mischa POSLAWSKY <git@shiar.nl>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH 2/1] t6300: format missing tagger
Message-ID: <20190822162731.gxubrdro4imv55qs@shiar.net>
References: <20190817215107.13733-1-git@shiar.nl>
 <xmqqimqtxcou.fsf@gitster-ct.c.googlers.com>
 <xmqq1rxerxkk.fsf@gitster-ct.c.googlers.com>
 <20190822135528.GB28725@shiar.net>
 <xmqq36htqipw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36htqipw.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt 20180716 + Vim 8.1 (Debian 10.0 GNU/Linux 4.9.0-6-amd64)
X-URL:  http://shiar.nl/
X-Accept-Language: nl, eo, en
X-CMAE-Envelope: MS4wfGc1+18n90Bwg9kogKsPnU3+4QCynhEp/rXI6wwnukJp7Q+MPebZaSZmON3R/MvM6hxH4Q6Zx1z/w9wyQ6VU6CW02co+c3NO7WgzygM9FnbM0lS0HWFs
 npgaGhU7bxkpyWukVtZ/l5DBcbjoH8QetoWm6llY3JLfsXNdRg8un8tmp7SPouIuJSRQ4ZC6mU4rI7Cc8lj3HUqPTp952Uv8OR8+RH43fFC3klLbgaRce5xx
 2EfhaGoyrrSqL9YS54cbKk6g4VZO93rTYgs2+D8DHcuRWWFGI2Z3vFKtJ7wm4mU9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio wrote:
> 
> Mischa POSLAWSKY <git@shiar.nl> writes:
> > Strip an annotated tag of its tagger header and verify it's ignored
> > correctly in all cases, as fixed in commit e2a81276e8 (ref-filter:
> > initialize empty name or email fields, 2019-08-19).
> 
> I am inclined to squash this test part of the update into the said
> commit; you'd lose one commit count, but hopefully you do not mind?
> 
> My motivation for doing so is that it would allow us to lose the "as
> fixed in commit X" comment in a log message, which in turn would
> mean that the code-fix patch can later be rebased safely without
> having to remember that this one needs to be adjusted ("git rebase"
> does not do such a rewrite for us, and I personally do not think
> "git rebase" should do such a rewrite silently, as I cannot quantify
> the risk of false positives).

Of course.  Might get one commit back if you pick it into maint :)

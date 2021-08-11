Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE72BC432BE
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC01B6104F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhHKUwW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Aug 2021 16:52:22 -0400
Received: from mailproxy02.manitu.net ([217.11.48.66]:52360 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKUwV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 16:52:21 -0400
Received: from localhost (200116b86008d40055e599cb51dd17e8.dip.versatel-1u1.de [IPv6:2001:16b8:6008:d400:55e5:99cb:51dd:17e8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy02.manitu.net (Postfix) with ESMTPSA id 25E38C00A5;
        Wed, 11 Aug 2021 22:51:55 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <YRQ11bYH5lV9D24D@coredump.intra.peff.net>
References: <20210811045727.2381-1-felipe.contreras@gmail.com> <20210811045727.2381-7-felipe.contreras@gmail.com> <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com> <xmqqzgto9dkd.fsf@gitster.g> <YRQfx+Njj1WxOnyG@coredump.intra.peff.net> <162871314612.7067.6886805754107701040.git@grubix.eu> <YRQ11bYH5lV9D24D@coredump.intra.peff.net>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
From:   Michael J Gruber <git@grubix.eu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
To:     Jeff King <peff@peff.net>
Message-ID: <162871511371.7067.11584829113417456747.git@grubix.eu>
Date:   Wed, 11 Aug 2021 22:51:53 +0200
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King venit, vidit, dixit 2021-08-11 22:40:53:
> I don't really disagree with anything in your post, but I do think a
> pure-verb world would be tricky in some ways. Or at least verbose. We
> have "git branch --delete". But "git delete" seems a little too
> open-ended. The concept of that verb is meaningful only in the context
> or a particular noun. We could call it "git delete-branch", but that
> doesn't really seem to make the world a better place. :)

In fact I think it does, because it keeps the verb-object order and
avoids "verbs as options":

git rm-branch
git rm-tag
git rm-remote
git ls-branch
git ls-tag
git ls-remote (yeah, I know... maybe use ls-pluralform instead for all)
...

Maybe:
git branches aliased to "git ls-branch" etc. as convenience.

For sake of convenience, if we have "ls-pluralform" (aliased to "pluralform")
we could even alias "create-singularform" to "singularform". I mean, I
want use this git thing myself ;)

Michael

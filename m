Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D34C020281
	for <e@80x24.org>; Tue, 31 Oct 2017 02:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbdJaCK1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 22:10:27 -0400
Received: from marcos.anarc.at ([206.248.172.91]:54438 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751871AbdJaCK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 22:10:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id DC1371A00AA
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Cc:     git@vger.kernel.org
Subject: Re: future of the mediawiki extension?
In-Reply-To: <xmqqh8ug3xnq.fsf@gitster.mtv.corp.google.com>
Organization: Debian
References: <87vaix731f.fsf@curie.anarc.at> <q7h9o9opyllo.fsf@orange.lip.ens-lyon.fr> <xmqqh8ug3xnq.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 30 Oct 2017 22:10:22 -0400
Message-ID: <874lqg83u9.fsf@curie.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-31 10:37:29, Junio C Hamano wrote:
>> There's also a hybrid solution used by git-multimail: have a copy of the
>> code in git.git, but do the development separately. I'm not sure it'd be
>> a good idea for Git-Mediawiki, but I'm mentionning it for completeness.
>
> I think the plan was to make code drop from time to time at major
> release points of git-multimail, but I do not think we've seen many
> updates recently.

I'd be okay with a hybrid as well. It would require minimal work on
Git's side at this stage: things can just stay as is until there's a new
"release" of the mediawiki extension and at that point you can decide if
you merge it all in or if you drop it in favor of the contrib.

I think it's also fine to punt it completely out to the community.

Either way, I may have time to do some of that work in the coming month,
so let me know what you prefer, I guess you two have the last word
here. The community, on Mediawiki's side, seem to mostly favor GitHub.

A.

-- 
Never attribute to malice that which can be adequately explained by
stupidity, but don't rule out malice.
                         - Albert Einstein

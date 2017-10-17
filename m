Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA50C202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 06:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757200AbdJQGxf (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 02:53:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53997 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757194AbdJQGxe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 02:53:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 554D3B3960;
        Tue, 17 Oct 2017 02:53:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/tTapdOnQSC38rg9e+3WWaaPmqA=; b=qDmxpN
        pnjvn2shsfHSAqqwZytWweB/Ep+T+CQKb1JLdWi1PrXYOZdYSgrmxlN4jH0KKYku
        BM6zYldKswmrsNJpbE3M6fEGS64oNBmEwBgAnd1SKqfnU0rLcsPWwIx8NExfgUF4
        VsYsBUgTTGuYG4BQyA1zJW1xnn/X+sdH6aeS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZmDPZ2vqky4KYkHHm2m5+KWsejpOGciO
        o345phHlVIII/jnU8r07R455HUK3EQk6BYbTf+0wStF6o8HNWy0RReBajljLZuks
        BRolBqaEu4AiP5u96hXob31BWx2mK64Mqw1PONguuiwlWGNw6tNgSalKkWhqXboX
        +j7PkukSGr0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CF14B395E;
        Tue, 17 Oct 2017 02:53:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82D94B395D;
        Tue, 17 Oct 2017 02:53:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOi?= =?utf-8?B?bg==?= 
        <vnwildman@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff of translation for Git 2.15.0 round 2
References: <CANYiYbEojz6P5BmN4bmQ-VuwsVf7RX1sDqiwnEsXN+M4-PXZtg@mail.gmail.com>
Date:   Tue, 17 Oct 2017 15:53:32 +0900
In-Reply-To: <CANYiYbEojz6P5BmN4bmQ-VuwsVf7RX1sDqiwnEsXN+M4-PXZtg@mail.gmail.com>
        (Jiang Xin's message of "Tue, 17 Oct 2017 10:09:15 +0800")
Message-ID: <xmqqr2u2nu37.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E466EBD4-B307-11E7-ACD2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Git v2.15.0-rc1 released with a typo fix from commit dfab1eac23
> ("i18n: add a missing space in message", Sun Oct 8 14:18:39 2017 +0200).
> This time there are 2 updated messages need to be translated since last
> update.  Let's start new round of translation for Git 2.15.0.

Today's pushout included 3247edbb ("sequencer.c: fix and unify error
messages in rearrange_squash()", 2017-10-15), which unfortunately
added this to the mix:

    error_errno(_("could not write '%s'"), todo_file);

There is another one "could not truncate '%s'" added by the same
commit, but the codebase already had another instance of the same
string, so it won't cause trouble.

Regarding the "could not write" thing, there are quite a few
instances of "coulld not write to '%s'" with %s set to the filename,
and I strongly suspect that this new one should be further updated
to match them (Ralf promoted from Cc: to To: for this).  That would
have a nice side effect of making today's last-minute merges a
non-event from translators' point of view ;-)




Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96EF01F404
	for <e@80x24.org>; Wed, 14 Feb 2018 05:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754154AbeBNFln (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 00:41:43 -0500
Received: from mail.javad.com ([54.86.164.124]:42711 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753275AbeBNFle (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 00:41:34 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id BF3723E8C4;
        Wed, 14 Feb 2018 05:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518586894;
        bh=iNdyQVaopyVP+qHXILd2Tfu+DqrkRM2Jgqx4hgZgpjs=; l=1612;
        h=Received:From:To:Subject;
        b=MWeWNg6GnQgZpdIhtNEMqSNQx4NqOAylkjigWrlHD5XZeLhc8U4M8+EszKtFtpuWh
         OYjLxalOdgEgZ7irVI3NG15mdUFV+6D6bY6QGNYpLPO7iK+sIhLtklzfKXtsn/7rel
         pkI0bgJ2m71fiXBdRoLwLM5EsOasvYlUxyClwiHs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518586894;
        bh=iNdyQVaopyVP+qHXILd2Tfu+DqrkRM2Jgqx4hgZgpjs=; l=1612;
        h=Received:From:To:Subject;
        b=MWeWNg6GnQgZpdIhtNEMqSNQx4NqOAylkjigWrlHD5XZeLhc8U4M8+EszKtFtpuWh
         OYjLxalOdgEgZ7irVI3NG15mdUFV+6D6bY6QGNYpLPO7iK+sIhLtklzfKXtsn/7rel
         pkI0bgJ2m71fiXBdRoLwLM5EsOasvYlUxyClwiHs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518586894;
        bh=iNdyQVaopyVP+qHXILd2Tfu+DqrkRM2Jgqx4hgZgpjs=; l=1612;
        h=Received:From:To:Subject;
        b=MWeWNg6GnQgZpdIhtNEMqSNQx4NqOAylkjigWrlHD5XZeLhc8U4M8+EszKtFtpuWh
         OYjLxalOdgEgZ7irVI3NG15mdUFV+6D6bY6QGNYpLPO7iK+sIhLtklzfKXtsn/7rel
         pkI0bgJ2m71fiXBdRoLwLM5EsOasvYlUxyClwiHs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518586894;
        bh=iNdyQVaopyVP+qHXILd2Tfu+DqrkRM2Jgqx4hgZgpjs=; l=1612;
        h=Received:From:To:Subject;
        b=MWeWNg6GnQgZpdIhtNEMqSNQx4NqOAylkjigWrlHD5XZeLhc8U4M8+EszKtFtpuWh
         OYjLxalOdgEgZ7irVI3NG15mdUFV+6D6bY6QGNYpLPO7iK+sIhLtklzfKXtsn/7rel
         pkI0bgJ2m71fiXBdRoLwLM5EsOasvYlUxyClwiHs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518586894;
        bh=iNdyQVaopyVP+qHXILd2Tfu+DqrkRM2Jgqx4hgZgpjs=; l=1612;
        h=Received:From:To:Subject;
        b=MWeWNg6GnQgZpdIhtNEMqSNQx4NqOAylkjigWrlHD5XZeLhc8U4M8+EszKtFtpuWh
         OYjLxalOdgEgZ7irVI3NG15mdUFV+6D6bY6QGNYpLPO7iK+sIhLtklzfKXtsn/7rel
         pkI0bgJ2m71fiXBdRoLwLM5EsOasvYlUxyClwiHs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518586894;
        bh=iNdyQVaopyVP+qHXILd2Tfu+DqrkRM2Jgqx4hgZgpjs=; l=1612;
        h=Received:From:To:Subject;
        b=MWeWNg6GnQgZpdIhtNEMqSNQx4NqOAylkjigWrlHD5XZeLhc8U4M8+EszKtFtpuWh
         OYjLxalOdgEgZ7irVI3NG15mdUFV+6D6bY6QGNYpLPO7iK+sIhLtklzfKXtsn/7rel
         pkI0bgJ2m71fiXBdRoLwLM5EsOasvYlUxyClwiHs=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1elpox-0003W9-N5; Wed, 14 Feb 2018 08:41:31 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?=C3=98yvind_R=C3=B8nnin?= =?utf-8?Q?gstad?= 
        <ronningstad@gmail.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <87k1vpqq85.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <1518044326.7000.4.camel@gmail.com>
        <xmqqpo5g5qd3.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1802081317320.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 14 Feb 2018 08:41:31 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802081317320.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Thu, 8 Feb 2018 13:34:18 +0100
        (STD)")
Message-ID: <87vaf03z78.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
[...]
> Just to give you one concrete example: when I recently rebased some
> patches (no reording or dropping involved here!) and one of the picks
> failed with merge conflicts, I realized that that particular commit
> introduced incorrect formatting and fixed that right away (verifying that
> no other commits introduced incorrect formatting, of course).
>
> With your new cute idea to magically cherry-pick -m1, this change would
> have been magically dropped from the subsequent merge commits!

You put it as if the problem you describe is unsolvable short of getting
back to your favorite blind re-merge. Do you really believe it?

I thought it's obvious that I originally meant "cherry-pick -m1" to be
an explanation facility, a proof of concept, not the final answer to all
the problems of history editing. It's a nice base for actually
approaching these problems though, unlike blind re-merge currently being
used, the latter having no potential.

The fact that bare naked "cherry-pick -m1" doesn't do what is often[1]
required in such cases neither voids the general idea of reproducing
merge-the-result, nor does it make current re-merge approach less
broken.

[1] Please take into consideration that it's _not always_ the case that
one needs a change made to a side-branch to actually propagate to the
main-line over the merge (think "merge -x ours", or something similar
but not that simple), and then it's rather the cute idea to blindly
re-merge that will wreak havoc, as in a lot of other cases.

-- Sergey

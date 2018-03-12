Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39DA71F404
	for <e@80x24.org>; Mon, 12 Mar 2018 12:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeCLMm6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 08:42:58 -0400
Received: from mail.javad.com ([54.86.164.124]:42554 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeCLMm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 08:42:56 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A0E4D3E969;
        Mon, 12 Mar 2018 12:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520858575;
        bh=MyRTz/BLNYX33vyy41vOHu6wjvHVhCuHWiKPBQL8f4A=; l=1477;
        h=Received:From:To:Subject;
        b=AvfcyH2zRBvSPMOkmsDy2pyFFQ7fynQyKzAiqVGP63JQ4Vwn8f0SmUPjjQo6YPiNs
         NBwZ2ZRm0Bj5tlYN+stgzFGEbiGYfU6hVGWTWLzMLRiOw8v3/DBkX85ITud4UW9AoB
         mevep1es4BP4ektvVr5gRddiagEKpCBw8bI8JxBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520858575;
        bh=MyRTz/BLNYX33vyy41vOHu6wjvHVhCuHWiKPBQL8f4A=; l=1477;
        h=Received:From:To:Subject;
        b=AvfcyH2zRBvSPMOkmsDy2pyFFQ7fynQyKzAiqVGP63JQ4Vwn8f0SmUPjjQo6YPiNs
         NBwZ2ZRm0Bj5tlYN+stgzFGEbiGYfU6hVGWTWLzMLRiOw8v3/DBkX85ITud4UW9AoB
         mevep1es4BP4ektvVr5gRddiagEKpCBw8bI8JxBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520858575;
        bh=MyRTz/BLNYX33vyy41vOHu6wjvHVhCuHWiKPBQL8f4A=; l=1477;
        h=Received:From:To:Subject;
        b=AvfcyH2zRBvSPMOkmsDy2pyFFQ7fynQyKzAiqVGP63JQ4Vwn8f0SmUPjjQo6YPiNs
         NBwZ2ZRm0Bj5tlYN+stgzFGEbiGYfU6hVGWTWLzMLRiOw8v3/DBkX85ITud4UW9AoB
         mevep1es4BP4ektvVr5gRddiagEKpCBw8bI8JxBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520858575;
        bh=MyRTz/BLNYX33vyy41vOHu6wjvHVhCuHWiKPBQL8f4A=; l=1477;
        h=Received:From:To:Subject;
        b=AvfcyH2zRBvSPMOkmsDy2pyFFQ7fynQyKzAiqVGP63JQ4Vwn8f0SmUPjjQo6YPiNs
         NBwZ2ZRm0Bj5tlYN+stgzFGEbiGYfU6hVGWTWLzMLRiOw8v3/DBkX85ITud4UW9AoB
         mevep1es4BP4ektvVr5gRddiagEKpCBw8bI8JxBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520858575;
        bh=MyRTz/BLNYX33vyy41vOHu6wjvHVhCuHWiKPBQL8f4A=; l=1477;
        h=Received:From:To:Subject;
        b=AvfcyH2zRBvSPMOkmsDy2pyFFQ7fynQyKzAiqVGP63JQ4Vwn8f0SmUPjjQo6YPiNs
         NBwZ2ZRm0Bj5tlYN+stgzFGEbiGYfU6hVGWTWLzMLRiOw8v3/DBkX85ITud4UW9AoB
         mevep1es4BP4ektvVr5gRddiagEKpCBw8bI8JxBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520858575;
        bh=MyRTz/BLNYX33vyy41vOHu6wjvHVhCuHWiKPBQL8f4A=; l=1477;
        h=Received:From:To:Subject;
        b=AvfcyH2zRBvSPMOkmsDy2pyFFQ7fynQyKzAiqVGP63JQ4Vwn8f0SmUPjjQo6YPiNs
         NBwZ2ZRm0Bj5tlYN+stgzFGEbiGYfU6hVGWTWLzMLRiOw8v3/DBkX85ITud4UW9AoB
         mevep1es4BP4ektvVr5gRddiagEKpCBw8bI8JxBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520858575;
        bh=MyRTz/BLNYX33vyy41vOHu6wjvHVhCuHWiKPBQL8f4A=; l=1477;
        h=Received:From:To:Subject;
        b=AvfcyH2zRBvSPMOkmsDy2pyFFQ7fynQyKzAiqVGP63JQ4Vwn8f0SmUPjjQo6YPiNs
         NBwZ2ZRm0Bj5tlYN+stgzFGEbiGYfU6hVGWTWLzMLRiOw8v3/DBkX85ITud4UW9AoB
         mevep1es4BP4ektvVr5gRddiagEKpCBw8bI8JxBE=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1evMmy-0001Jn-TQ; Mon, 12 Mar 2018 15:42:52 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87vae8yq15.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87vae7ykys.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803080746460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Mon, 12 Mar 2018 15:42:52 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803080746460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Thu, 8 Mar 2018 08:01:08 +0100
        (STD)")
Message-ID: <87r2oph3cj.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi Sergey,

[...]

> That is misrepresenting what happened.

No, it's you who are spreading misinformation, probably unintentional,
but still.

> First, you came up with a strategy. I pointed out shortcomings that
> implied that we cannot use it unchanged. Then, Buga fixed your strategy by
> using additional steps (making the process more complicated than before,
> still without a simple-enough explanation for my liking, fixing the
> shortcomings). Then, Phillip presented a super-simple strategy and Buga
> confirmed that it also fixes the shortcomings I pointed out.

Except that you've missed very essential thing: even before Phillip
presented his method, the original has been fixed and simultaneously
became even simpler. It's now entirely described in [RFC v2] that you
apparently still refuse to read.

> I am very excited that we finally found something that works *and* is easy
> to reason about.

You have chances to be even more exited as we in fact have 2 of them
that both work and are both easy to reason about.

> Let's focus on that strategy rather than going back to the strategy which
> has known flaws and only an unsatisfyingly complex explanation.

Not that fast, as it now has no known flaws and still has surprisingly
simple explanation. It also has its own niceties that are currently
being discussed elsewhere in the thread.

-- Sergey

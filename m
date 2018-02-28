Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5F31F404
	for <e@80x24.org>; Wed, 28 Feb 2018 05:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbeB1F1U (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 00:27:20 -0500
Received: from mail.javad.com ([54.86.164.124]:43091 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbeB1F1T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 00:27:19 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 8B616407C5;
        Wed, 28 Feb 2018 05:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795638;
        bh=Sk8LVv25gEPjCcrTS0h3Frd+tSwk7agMvDnX5sexLFw=; l=2220;
        h=Received:From:To:Subject;
        b=HOVmRe9pDmrBrCaCNDEl/MLAp9a2hxU+LXAO8JS+4GXgXmWGmTbGchRjo7eNWhcBZ
         gNaH6nOPbnbGwyufVSi47JcP40iG6jgALWfNn1YncE0sJM+0wJAPw9nq+6KXe4HKgl
         w5IbOLwQbbQgSxgcBbHtDAqJdkdyVyPcwTXFg2XI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795638;
        bh=Sk8LVv25gEPjCcrTS0h3Frd+tSwk7agMvDnX5sexLFw=; l=2220;
        h=Received:From:To:Subject;
        b=HOVmRe9pDmrBrCaCNDEl/MLAp9a2hxU+LXAO8JS+4GXgXmWGmTbGchRjo7eNWhcBZ
         gNaH6nOPbnbGwyufVSi47JcP40iG6jgALWfNn1YncE0sJM+0wJAPw9nq+6KXe4HKgl
         w5IbOLwQbbQgSxgcBbHtDAqJdkdyVyPcwTXFg2XI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795638;
        bh=Sk8LVv25gEPjCcrTS0h3Frd+tSwk7agMvDnX5sexLFw=; l=2220;
        h=Received:From:To:Subject;
        b=HOVmRe9pDmrBrCaCNDEl/MLAp9a2hxU+LXAO8JS+4GXgXmWGmTbGchRjo7eNWhcBZ
         gNaH6nOPbnbGwyufVSi47JcP40iG6jgALWfNn1YncE0sJM+0wJAPw9nq+6KXe4HKgl
         w5IbOLwQbbQgSxgcBbHtDAqJdkdyVyPcwTXFg2XI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795638;
        bh=Sk8LVv25gEPjCcrTS0h3Frd+tSwk7agMvDnX5sexLFw=; l=2220;
        h=Received:From:To:Subject;
        b=HOVmRe9pDmrBrCaCNDEl/MLAp9a2hxU+LXAO8JS+4GXgXmWGmTbGchRjo7eNWhcBZ
         gNaH6nOPbnbGwyufVSi47JcP40iG6jgALWfNn1YncE0sJM+0wJAPw9nq+6KXe4HKgl
         w5IbOLwQbbQgSxgcBbHtDAqJdkdyVyPcwTXFg2XI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795638;
        bh=Sk8LVv25gEPjCcrTS0h3Frd+tSwk7agMvDnX5sexLFw=; l=2220;
        h=Received:From:To:Subject;
        b=HOVmRe9pDmrBrCaCNDEl/MLAp9a2hxU+LXAO8JS+4GXgXmWGmTbGchRjo7eNWhcBZ
         gNaH6nOPbnbGwyufVSi47JcP40iG6jgALWfNn1YncE0sJM+0wJAPw9nq+6KXe4HKgl
         w5IbOLwQbbQgSxgcBbHtDAqJdkdyVyPcwTXFg2XI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795638;
        bh=Sk8LVv25gEPjCcrTS0h3Frd+tSwk7agMvDnX5sexLFw=; l=2220;
        h=Received:From:To:Subject;
        b=HOVmRe9pDmrBrCaCNDEl/MLAp9a2hxU+LXAO8JS+4GXgXmWGmTbGchRjo7eNWhcBZ
         gNaH6nOPbnbGwyufVSi47JcP40iG6jgALWfNn1YncE0sJM+0wJAPw9nq+6KXe4HKgl
         w5IbOLwQbbQgSxgcBbHtDAqJdkdyVyPcwTXFg2XI=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1equGq-0001P5-UP; Wed, 28 Feb 2018 08:27:16 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <xmqqwoyym0ry.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 28 Feb 2018 08:27:16 +0300
In-Reply-To: <xmqqwoyym0ry.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 27 Feb 2018 16:10:57 -0800")
Message-ID: <87zi3tn0p7.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>
>> On 27/02/2018 20:59, Igor Djordjevic wrote:
>>> 
>>> (3) ---X1---o---o---o---o---o---X2
>>>        |\                       |\
>>>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>>>        |             \          |
>>>        |              M         |
>>>        |             /          |
>>>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
>>> 
>>
>> Meh, I hope I`m rushing it now, but for example, if we had decided to 
>> drop commit A2 during an interactive rebase (so losing A2' from 
>> diagram above), wouldn`t U2' still introduce those changes back, once 
>> U1' and U2' are merged, being incorrect/unwanted behavior...? :/
>>
>> p.s. Looks like Johannes already elaborated on this in the meantime, 
>> let`s see... (goes reading that other e-mail[1])
>
> As long as we are talking about rebase that allows us users to
> adjust and make changes ("rebase -i" being the prime and most
> flexible example), it is easy to imagine that A1'--A3' and B1'--B3'
> have almost no relation to their original counterparts.  After all,
> mechanical merge won't be able to guess the intention of the change
> humans make, so depending on what happend during X1 and X2 that
> happend outside of these two topics, what's required to bring series
> A and B to series A' and B' can be unlimited.

You discuss some different method here. In my original proposal U1' and
U2' are to be merged. Nothing should be replayed on top of them. I.e.,
U1' is _already_ the result of replaying difference between M and A3 on
top of A3'.

> So from that alone, it should be clear that replaying difference
> between M and A3 (and M and B3) on top of U1' and U2' is hopeless as a
> general solution.

Getting U1' from U1 is the same complexity as getting A3' from A3, with
the same caveats. So, as general solution, it's as good as rebase of
non-merge commit.

> It is acceptable as long as a solution fails loudly when it does the
> wrong thing, but I do not think the apporach can produce incorrect
> result silently, as your example shows above.

I still believe the method handles simple cases automatically and
correctly and allows to immediately stop for amendment should something
suspect appear.

-- Sergey

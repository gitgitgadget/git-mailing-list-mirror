Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38C21FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbdBNVIT (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:08:19 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:32854 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbdBNVIR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:08:17 -0500
Received: by mail-ot0-f193.google.com with SMTP id t47so3750749ota.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 13:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jgfnnjZzMo3v75uh6CduTmZi1LNN1IMiDOAOYyN9eMw=;
        b=bXwvBN9r1pN9hs6polfopvZybkd3Ww9NbMh9ddMNq4c5/V+XvuIUzzYR4pH+ovJirr
         J4NXn439VgGNIbUIqv6kzXuG7jsMhZyLt/PQ3AkNSwieDRZBN8W6ttleaaGPNS4vsveI
         3OPnzdnmHy+Iidl8MKnaB3xUtEzRxzB35fM68tE4KAWJbI+GN2dBXuzxx+US6VAzsfx0
         Se6u3xl1niFJyxeA/TAzRvuZdSDYxkAs4z7DgHzKOm5abPizvjZwNhl7QZhG9/PvHMhO
         3Y2wLd7Pogh5V1lsn5eb9Ks/hy1ABg3T1WoFwZwM/ANsM3/aS8qx8JUA4aKNAjk9P6g4
         PvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jgfnnjZzMo3v75uh6CduTmZi1LNN1IMiDOAOYyN9eMw=;
        b=W2DSrPUjgFnqTX0Qa7JEvHc63pfbgqNsF66RwmiWVvnotGTPJrtP+/a636KYD678Al
         D+lzXLF13h3z6gGI9Sa2jbUrWK52N6sDLVZSaUiNv7Tlbelcrb11hKY6BWYhNNnV2Ibf
         J4kIHQsLLLOu21pULTqVULbbr2IyCR0cDbsFhM9VK30CazVfmo2znI3zfgR70yOM6Ouq
         txk9IOC5Hd3LardKE2hljDds9+Keux4VXVTwp7MtEadsyfcyi1p4ay5qMTn3/ea9Pmgj
         cyaPp/DhhAPEWDGdHRynXuQxLPoF0ZeJpjpt6AKo7QW/aGEE62WA/pDL0b9342jrn+0U
         A+Yw==
X-Gm-Message-State: AMke39mtiWo3zSQq9ZCozuNbukMYIylRGaVSJy28QzBWIzJ7ngHa3os/XJpzzLn0jV5wWA==
X-Received: by 10.98.74.202 with SMTP id c71mr33659794pfj.28.1487106496586;
        Tue, 14 Feb 2017 13:08:16 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id s64sm3002527pfe.27.2017.02.14.13.08.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 13:08:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox>
        <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702142150220.3496@virtualbox>
Date:   Tue, 14 Feb 2017 13:08:15 -0800
In-Reply-To: <alpine.DEB.2.20.1702142150220.3496@virtualbox> (Johannes
        Schindelin's message of "Tue, 14 Feb 2017 21:55:28 +0100 (CET)")
Message-ID: <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 13 Feb 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > That is why I taught the Git for Windows CI job that tests the four
>> > upstream Git integration branches to *also* bisect test breakages and
>> > then upload comments to the identified commit on GitHub
>> 
>> Good.  I do not think it is useful to try 'pu' as an aggregate and
>> expect it to always build and work [*1*], but your "bisect and
>> pinpoint" approach makes it useful to identify individual topic that
>> brings in a breakage.
>
> Sadly the many different merge bases[*1*] between `next` and `pu` (which
> are the obvious good/bad points for bisecting automatically) bring my
> build agents to its knees. I may have to disable the bisecting feature as
> a consequence.

Probably a less resource intensive approach is to find the tips of
the topics not in 'next' but in 'pu' and test them.  That would give
you which topic(s) are problematic, which is a better starting point
than "Oh, 'pu' does not build".  After identifying which branch is
problematic, bisection of individual topic would be of more manageable
size.

  $ git log --first-parent --oneline 'pu^{/^### match next}..pu'

will you the merges of topics left outside 'next'.  I often reorder
to make the ones that look more OK than others closer to the bottom,
and if the breakages caused by them are caught earlier than they hit
'next', that would be ideal.

This is one of these times I wish "git bisect --first-parent" were
available.  The above "log" gives me 27 merges right now, which
should be bisectable within 5 rounds to identify a single broken
topic (if there is only one breakage, that is).




Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B278D2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdKVB24 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:28:56 -0500
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:61793 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdKVB2z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:28:55 -0500
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 094AF143A8;
        Tue, 21 Nov 2017 20:28:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MxdYSpsEROrfaXF3n+Wrc+5kFLM=; b=O+T8sr
        k3PpDBqX5iX9eN+wKsckyZrc/8l6t3WzCQEig6246+5sbsc8PtMwpfYzRB+dZRNR
        Opaf/kAOBN1a8GEm9Z0Wyg/shnX2vH84naj1JPhL5TW2wn1qhL8BY/zrXPCz8Yur
        mXegn/m6UlvPjBNaiZYMNlkSnz5I6HwZrXMWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qmxrMdD6sZDIjOyhOncs4hAkoUpRX6mn
        quHhIfkCKSDjo/IKmabJLWN+7+u3LC55jeBT4O+VtxuVDT/K4LLevwAEpJ69sKdQ
        Rg6B66YGry2iiPz/7SDKDGTRXAuB+N/IguldA2JMSstStM12GoRk6CIUkJfEljI3
        ELp0o7xh18Q=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id DA7EB143A7;
        Tue, 21 Nov 2017 20:28:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BCD8B9D5E;
        Tue, 21 Nov 2017 20:28:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Yubin Ruan <ablacktshirt@gmail.com>, git <git@vger.kernel.org>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Ross Kabus <rkabus@aerotech.com>,
        Henry Kleynhans <hkleynhans@bloomberg.net>,
        Charles Bailey <charles@hashpling.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Draft of Git Rev News edition 33
References: <CAP8UFD0ggpUGGoOEjAt3sB9=ek+Av+6GemiyqZ4kTCHLC9dWoA@mail.gmail.com>
        <CAJYFCiOj1DwgMMrFRxV315CB7xuvXMFRbRAkbx6s14oPm3ui1Q@mail.gmail.com>
        <20171121011017.e2aac53zfo2n2whc@aiede.mtv.corp.google.com>
        <CAP8UFD0dN2V5GVokvMD-XLDEhPVJrE=m3h8oM5VC_Lq6x3=9=A@mail.gmail.com>
        <xmqqvai3zsge.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3QdwnN3Mrc5Xx3C0ROxhm6eS9OFuiVxFTUSrXYknTOWA@mail.gmail.com>
Date:   Wed, 22 Nov 2017 10:28:52 +0900
In-Reply-To: <CAP8UFD3QdwnN3Mrc5Xx3C0ROxhm6eS9OFuiVxFTUSrXYknTOWA@mail.gmail.com>
        (Christian Couder's message of "Tue, 21 Nov 2017 14:41:18 +0100")
Message-ID: <xmqqd14byucr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80ABB83E-CF24-11E7-A184-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Nov 21, 2017 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I just re-read the sub-thread Jonathan pointed at, and to me it does
>> look like the original request was adequately addressed and talk has
>> concluded at around that article.
>>
>> I somehow was hoping that Jonathan's citing the above URL is a
>> suggestion enough for the editors, especially given that the
>> announcement for the draft invites a reply to this thread.
>
> DId you also read https://github.com/git/git.github.io/issues/262?

No, but I just did.  I didn't know the purpose of the Rev News
changed over time from helping those who do not have time to follow
the list by highlighting useful discussions and giving them concise
summary to just quoting pieces from messages in interesting
discussions and have the readers draw their own conclusions (or lack
thereof).


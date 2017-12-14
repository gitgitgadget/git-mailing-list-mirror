Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E951F407
	for <e@80x24.org>; Thu, 14 Dec 2017 18:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbdLNSuG (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 13:50:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56275 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753743AbdLNSuF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 13:50:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10262C7B9E;
        Thu, 14 Dec 2017 13:50:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8ZoS+2pCz0LO2BX9WssNbLg2vJQ=; b=ixm9za
        BfuCUCgesgzInEUWaF6x/pQV2zvlEJWPsr5DGeN9/8EladG2MRu7nv3o6A78kGox
        2M++t8ZhF1Baf+yu6PsLHk0rEMq98V0FUjG2H3SRgpctlBVpLSc0Y7D2wJTN2IW8
        20yMLuLe2Ervu1Ryn9JCGAc86b04BjGSiQ2Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YPblZwmZiHkPRhpKZ4U9tjEbO6qK5mrZ
        cTS8mqhQH6aS1eKo/ywggIFRwnBWY9o97VUPfGeYuqY3TjWqk4cd98bWWlu9QMEM
        wR3Kbjpjvomzqm8rlThR9n2ACtDyjU/spVtZfAdnAIa7xekxblFlleKNJkV5xae+
        dE58RHvggAI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0340BC7B9D;
        Thu, 14 Dec 2017 13:50:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A559C7B99;
        Thu, 14 Dec 2017 13:50:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "David A. Wheeler" <dwheeler@dwheeler.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox>
        <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com>
        <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com>
        <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com>
        <xmqq6099uqq9.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZeMVLesunBzW5hhN-snL8fBXdjPgy=Tt8JCDmhDePDZA@mail.gmail.com>
Date:   Thu, 14 Dec 2017 10:50:00 -0800
In-Reply-To: <CAGZ79kZeMVLesunBzW5hhN-snL8fBXdjPgy=Tt8JCDmhDePDZA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 14 Dec 2017 10:24:00 -0800")
Message-ID: <xmqqk1xpta93.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 986A065A-E0FF-11E7-8FFD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Anyway I think spending list band width on good documentation is
> not bandwidth wasted.

I agree with that.  I do not consider the proposed change "good".


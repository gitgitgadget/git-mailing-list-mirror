Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6990020135
	for <e@80x24.org>; Wed,  8 Mar 2017 23:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbdCHXjb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 18:39:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53510 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753913AbdCHXjE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 18:39:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D0886F9F1;
        Wed,  8 Mar 2017 18:24:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9MIpUir31iTKjeJXjZrHHrlFDw4=; b=Vtu7OQ
        38nZO8V3lTz9Kug40HaY8985+NePGUihxpOvR2z+hhzVjXBBhGFaR6i7Jubl5jMy
        GIEGmXXLaeZ8iR2VHDhUlQrrkbVwlloJFuq9+Qf+hJIrGGSarT/AWG/nQjwPI/zN
        bLIFKAOzhOciDWWDuOH5/LwVJeG54G6Rh1wzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UZwxyV9pQS81yXENJArhYSQ/wtN1SKZY
        rLPgFpR0B8d0XnnFjl0ULdXCBMSvUZ0ZRhx5t/vBviAG81SynSTYsUxzo9zbTzM/
        zvyM1AdNXHtAXI5RdWm3uN66p+1d6rjDygliUb0E8CDyNaULiwDABVwtC+UImkuB
        MHzhr2Q5jyc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85ED76F9F0;
        Wed,  8 Mar 2017 18:24:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E42696F9EF;
        Wed,  8 Mar 2017 18:24:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Valery Tolstov <me@vtolstov.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] submodule--helper.c: remove duplicate code
References: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
        <20170308230512.30572-1-me@vtolstov.org>
        <CAGZ79ka7PNKq5JWLPujvVHJWf6eEUadaJXd5AmKEvKT_y1ghOA@mail.gmail.com>
Date:   Wed, 08 Mar 2017 15:24:22 -0800
In-Reply-To: <CAGZ79ka7PNKq5JWLPujvVHJWf6eEUadaJXd5AmKEvKT_y1ghOA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 8 Mar 2017 15:15:40 -0800")
Message-ID: <xmqq60jj1heh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D70FA26-0456-11E7-A129-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Also,
>> should I start new thread for new patch series?
>
> As you like.
> As far as I understand, it is very easy for Junio to take a whole
> (sub-)thread of patches and apply that and make a branch with
> multiple commits out of it as he has tooling for that.

Note that the world does not revolve around _me_.  I was once asked
for my preference and I responded and that is what you are recalling
here.  

Others on the list do review and keeping it easy for them to is also
important.  What's _your_ preference?



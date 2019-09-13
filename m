Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0687C1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 23:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404258AbfIMXNb (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 19:13:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58861 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404247AbfIMXNb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 19:13:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DCAA86625;
        Fri, 13 Sep 2019 19:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y0CCCO+CUrTFcUw+rONR5XLCL5g=; b=elNlgM
        nGLhfyMia6uhsRFl/sskOrJlB69ep6JWdIz5F2MXr5rRmKb0AtCnua+GmU/0884b
        VfT8o5VyE7OCMubWuEVA3C74zNaOk6Y8gIO3vTn8epiE6defVhpeerbAnZ+HdtAN
        PC11APLi3Z6fXvD3O4tx//NOVecoqEKtTxAqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u2CoSJVcaD8NuujSOe8QDmOmaDwkv/p5
        KmNQazavCKJoNB7ctKZdqELXdu73Cr6cFGzr5T4BVcftNJjZlBvf72rYKDKA1QgA
        IAt9eKXhZtcGWyUjUACIEWjA7+kVAPKeq1WH1hnyN8nY5fapOxjyR1CsqN3mO3m2
        5hgjbJirxvA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4637486624;
        Fri, 13 Sep 2019 19:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 050FC86621;
        Fri, 13 Sep 2019 19:13:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-submodule.txt: fix AsciiDoc formatting error
References: <796a25ee1e9a9c0421d42ab6644e81d23a9bd99b.1568142486.git.liu.denton@gmail.com>
        <xmqqk1acdqf8.fsf@gitster-ct.c.googlers.com>
        <20190913220902.GA93452@dentonliu-ltm.internal.salesforce.com>
Date:   Fri, 13 Sep 2019 16:13:23 -0700
In-Reply-To: <20190913220902.GA93452@dentonliu-ltm.internal.salesforce.com>
        (Denton Liu's message of "Fri, 13 Sep 2019 15:09:02 -0700")
Message-ID: <xmqq36gzdc30.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16EB8684-D67C-11E9-BC98-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> > -set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
>> 
>> I say "almost", as it gives a wrong impression that you can give
>> "-b" without "<branch>" X-<.
>> 
>> Now what does the updated text say to us?
>> 
>> > +set-branch (-d|--default)|(-b|--branch <branch>) [--] <path>::
>> 
>> I think the attempt to cram the short-form is unnecessarily
>> cluttering and making the result incorrect.
>>  ...
>> 
> Hmm, I don't really like this since with every other subcommand, the
> short-forms are in the command summary so it's obvious to the reader
> in a quick glance which options are available.

I actually do not think it adds that much value.  Once a user learns
what --branch does and is told -b is its short form, it is much less
important that -b and --branch are both available than --default and
--branch are possibilities, and you cannot use both at the same time.

If anything, perhaps other subcommands' description may benefit if
we unclutter by reducing the prominence we give to their short form.

> In the context line above, we see `[(-n|--summary-limit) <n>]` as a
> possible way of notating a short and long option with argument. What do
> you think about the following potential output?
>
> 	set-branch (-d|--default)|((-b|--branch) <branch>) [--] <path>::
>
> Of course, we reintroduce the double paren problem but I can dig into
> asciidoc syntax and figure out how to escape it properly.

That's much less important than the fact that you are losing "-b and
-d cannot be used together", which is what the usage string gives us
(and which is what I tried to express with my rewrite).

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF6720985
	for <e@80x24.org>; Mon, 12 Sep 2016 01:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756451AbcILBy7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 21:54:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53094 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756080AbcILByz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 21:54:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 431413D0D2;
        Sun, 11 Sep 2016 21:54:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2oWmQgq8l97/YY/aJs9I0Qv4O5U=; b=KTkfS3
        Ty96DU8fnzVOoUYrIRFYB5SS8mG3c9JlbjjQVBIWKzm4nFFVzucqC6+JXheGnngN
        CUj5zrGUPmrzVsuD4MiatKVhUqnp/Q9KDnrgZzVjbDPJlDcrjKG6UZXZcY5hZC7r
        +x9zhy6PoTpeSA/cXqtXeKqio6vG7DpFI0EZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=giB73+7Rhdiwiyqc2I0NbbvWgv/Gt59c
        P1joR9FlIfSqx37Njdz28Ur6BsNTXwU+Ff+d27/n4a8LCTxX73wrwKyytxVypPoX
        WGLSLy6FezJHr+9rXb+bCLziS4r/f+bOmaLjPpLOCJbHBXMTLiOCp6fL88QpvDMF
        ijhYUNb++/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B7DC3D0D1;
        Sun, 11 Sep 2016 21:54:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB8003D0D0;
        Sun, 11 Sep 2016 21:54:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Glasser <glasser@davidglasser.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: mention `git -c` in git-config(1)
References: <CAN7QDo+S21T=1zjBEM7rq3epzvVx7GhmTZ5+sgV0BPvNYhvvUg@mail.gmail.com>
        <xmqqd1kzwegi.fsf@gitster.mtv.corp.google.com>
        <CAN7QDoJOzVvCzM80v=jP7RTB0od4exFLMZGkvPx9Uz6Lkm16Tg@mail.gmail.com>
Date:   Sun, 11 Sep 2016 18:54:40 -0700
In-Reply-To: <CAN7QDoJOzVvCzM80v=jP7RTB0od4exFLMZGkvPx9Uz6Lkm16Tg@mail.gmail.com>
        (David Glasser's message of "Sun, 11 Sep 2016 17:33:48 -0700")
Message-ID: <xmqqeg4p6fxb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF8E3D86-788B-11E6-8E83-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Glasser <glasser@davidglasser.net> writes:

> On Tue, Aug 23, 2016 at 11:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> David Glasser <glasser@davidglasser.net> writes:
>>
>> That might be something we want to fix up further in later patches;
>> the change we see in this patch is good regardless.
>
>
> Perhaps I am looking at the wrong branch, but I'm not sure that this
> got merged? Is there something I should do to move this along?

Are you asking about "might be something we want to fix up further",
which I do not think anybody did (and you certainly didn't)?

The patch that was commented on in that exchange should be part of
v2.10.0 already.

$ git blame -s -L264,269 v2.10.0 Documentation/git-config.txt
7da9800f 264) values of a key from all files will be used.
7da9800f 265) 
ae1f7094 266) You may override individual configuration parameters when running any git
ae1f7094 267) command by using the `-c` option. See linkgit:git[1] for details.
ae1f7094 268) 
17014090 269) All writing options will per default write to the repository specific

$ git show ae1f7094
commit ae1f7094f7a68fcff3d07358d83f5f483f0c300c
Author: David Glasser <glasser@davidglasser.net>
Date:   Tue Aug 23 10:33:21 2016 -0700

    doc: mention `git -c` in git-config(1)
    
    Signed-off-by: David Glasser <glasser@davidglasser.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 6843114..636b3eb 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -263,6 +263,9 @@ The files are read in the order given above, with last value found taking
 precedence over values read earlier.  When multiple values are taken then all
 values of a key from all files will be used.
 
+You may override individual configuration parameters when running any git
+command by using the `-c` option. See linkgit:git[1] for details.
+
 All writing options will per default write to the repository specific
 configuration file. Note that this also affects options like '--replace-all'
 and '--unset'. *'git config' will only ever change one file at a time*.

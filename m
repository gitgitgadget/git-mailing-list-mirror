Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5A41F667
	for <e@80x24.org>; Sat, 19 Aug 2017 16:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbdHSQhE (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 12:37:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50123 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751438AbdHSQhD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 12:37:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D06AEA7684;
        Sat, 19 Aug 2017 12:36:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CKijG9QJIGzpMg26OyT7CK5OidE=; b=hox5Uy
        v9SAy/TmPy7DEMoXpJFUJtQzqERsvkH04JLRsLM00/WRu8N+3Fr5tSEkAMyv7zQu
        YrvTTa+ivsBIDbjRZb7l+BrXqI0722bcsGmgQGvm+unTyFgmjqfR65lcbtM1PyPV
        9fl6j+M+PyxStGSLDLzvlS3uvp1+HbR/IsL1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BVWVCPL/ovaH75zgdYPI07jQun0kzHCR
        K5CjKVo++1r/gznXDKSjCCzM6efNai5Lo4BVqnOUq6DLFvMQBmcalRfzZoJRy/qM
        uX+Lr18Te6wJSqEIL2Y+m/0XTaMqLh+io+R9J2cvPqWRFqE3cy/8tZD32Nel140/
        RW2Ql7an4L8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C919DA7683;
        Sat, 19 Aug 2017 12:36:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A641A7680;
        Sat, 19 Aug 2017 12:36:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Please fix the useless email prompts
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
Date:   Sat, 19 Aug 2017 09:36:49 -0700
In-Reply-To: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
        (Jeffrey Walton's message of "Sat, 19 Aug 2017 11:10:23 -0400")
Message-ID: <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A3F052A-84FC-11E7-BF54-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> Is it possible to fix the issue shown below?
>
> I'm on a test machine. All I do is update to the latest code, build
> the library and run the self tests.
>
> The test user account does not have a name and does not have an email
> address. There's nothing to provide.
>
> There's no reason to break my workflows for useless Git policies like
> "please tell me your email address". Its not my policy, and there's
> nothing critical about it.
>
> Jeff
>
> **********
>
> $ git pull
>
> *** Please tell me who you are.
>
> Run
>
>   git config --global user.email "you@example.com"
>   git config --global user.name "Your Name"
>
> to set your account's default identity.
> Omit --global to set the identity only in this repository.
>
> fatal: unable to auto-detect email address (got 'test@via.(none)')

Hasn't this been asked and answered already?

    https://public-inbox.org/git/CACBZZX4vEOD-4a-eK-uBxmFrb1GLSvJKxHW51whCSbCZdh7amQ@mail.gmail.com/


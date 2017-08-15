Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A79520899
	for <e@80x24.org>; Tue, 15 Aug 2017 03:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbdHODD3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 23:03:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53325 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753208AbdHODD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 23:03:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3857CA6429;
        Mon, 14 Aug 2017 23:03:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZxFB8LI6UCl+4uHzP7ZWxURKDS4=; b=x7F6Zw
        sfhhLTWYUNeLUrvSkWhlLWd9p2aqotf0rAwokZp7tjUUrG/3no8uGLLHrKZgp59a
        bZ/gY+Rph9o8z5eqFBxRy21u62R8iDgiaRE3DKFia2eU1hMj7/0Ozv0467SrfjSb
        TWIhTqDlMouUJLv97k2WPm5I24ZjBEhnzaWZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VRsj2TZ8zapXpO3seKdzLxaNda/LLI+j
        zZpM2NDYYWj4wkKF5Aq1zOqybde6Be2tGH/Vo43gCVr4EP3spzXRP+gN5AGasEmW
        O+pZVghqrTc0//XM10W/ogYB7ua66GhB788E4ERH5NBmjAepdhv0Pu2C+42U3oYZ
        3pMBqsHQPdU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F38CA6428;
        Mon, 14 Aug 2017 23:03:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B7ECA6425;
        Mon, 14 Aug 2017 23:03:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/2] clang-format
References: <20170808012554.186051-1-bmwill@google.com>
        <20170814213046.107576-1-bmwill@google.com>
        <20170814230657.bmn7exoqmqw3tlyh@sigill.intra.peff.net>
        <CAGZ79kZgRTzWiufZUE02YYOJpH66x_hShBfcv=4RWDn-qR2LUg@mail.gmail.com>
        <20170815014704.thmpoz5xteuhqh3d@sigill.intra.peff.net>
Date:   Mon, 14 Aug 2017 20:03:19 -0700
In-Reply-To: <20170815014704.thmpoz5xteuhqh3d@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 14 Aug 2017 21:47:05 -0400")
Message-ID: <xmqqmv71sfbc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B2C17AA-8166-11E7-99DC-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 14, 2017 at 04:15:40PM -0700, Stefan Beller wrote:
>
>> + llvm-dev@lists.llvm.org
>> 
>> The Git community is currently discussing adopting a coding style
>> defined by clang-format, here is a bug report:
>
> Since we've added a cc, let me try to give a little more context.

Thanks for relaying; I've dropped them from CC: for this message, as
the remainder is not of interest to them.

> I'm tempted to say that "config --list" should normalize this case into:
>
>   mysection.mykey=true
>
> Normally we avoid coercing values without knowing the context in which
> they'll be used. But the syntax in the original file means the user is
> telling us it's a boolean and they expect it to be treated that way.
>
> The only downside is if the user is wrong, it might be coerced into
> the string "true" instead of throwing an error. That seems like a minor
> drawback for eliminating a potentially confusing corner case from the
> plumbing output.

Because we cannot sensibly always normalize a variable set to 'yes',
'on', etc. to all "true", the degree it can help the reading scripts
is quite limited, as they need to be prepared to see other
representation of the truth values anyway.  Even though I too found
the approach somewhat tempting, because there is no ambiguity in
"[section] var" that it means a boolean "true", I doubt it would
help very much.

The way they pass "non_string_options" dict to the loader is quite
sensible for that purpose, as it allows the reader to say "I care
about this and that variables, and I know I want them interpreted as
int (e.g. 1M) and bool (e.g. 'on') and returned in a normalized
form".

I do not mind adding "git config --list --autotype" option, though,
with which the reading script tells us that it accepts the chance of
false conversion, so that

	[my]
		intVal = 2k
		boolVal
                someVal = on
		otherVal = 1
		moreVal = 2
		anotherVal = 0
		no = no

might be listed as

	my.intval=2048
	my.boolval=true
	my.someval=true
	my.otherval=1
	my.moreval=2
	my.anotherval=0
	my.no=false

Disambiguation rules are up to debate; the above illustrates an
extreme position that coerses anything that could be taken as an int
and a string that can be taken as a bool as such, but it may not
help very much if the reader wants to see boolean values.

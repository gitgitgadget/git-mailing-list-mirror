Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE812021E
	for <e@80x24.org>; Wed,  9 Nov 2016 22:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754419AbcKIW56 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 17:57:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58479 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753423AbcKIW55 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 17:57:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36FF24D69A;
        Wed,  9 Nov 2016 17:57:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v9UiFkPIM8dh1UQLbZ+aWPOE4BA=; b=Gja6/a
        tePi7ZKI1+uPtiSfRD26ooV020bw9I15CnsUjBMogbTlBxcoeInVcmAsid6ODOtP
        s6G05VmIeAZsJcETkGsI7MclZFkY7DbwmXtxzgiSQjSR+FM8GzqhQLqCgeR72ZoI
        R+xMVLJBZBiDeG4QnI5MH2Ro4YGfT8lwavoQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IwY7mjG24egsfrNIm64L9E7LEqOaZIvK
        G/M7VYshSSppElMoVmMkkTBvsg+bOZ0fmdbt9XkgSA4DO4eN5YORjPXw+rsw8Rau
        tXVMVO1aoUSfSZOjeilWRL/Q3mX+IOyrsUQolEdAzbZov9Njn0EIZNJaAvnwkGyQ
        A1r70BXr6YQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E4504D699;
        Wed,  9 Nov 2016 17:57:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4FD94D698;
        Wed,  9 Nov 2016 17:57:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>
Subject: Re: Regarding "git log" on "git series" metadata
References: <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
        <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
        <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com>
        <20161105151836.wztypzrdywyltvrc@x>
        <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
        <20161105202553.migx75gfuujakqyk@x>
        <CA+P7+xoG3ag8dj7s_NRoqz-EwjVENSJSzE_qj6gnW-SmWt0bgA@mail.gmail.com>
        <20161106163410.ilysej5r6qd3744e@x>
        <xmqqshr4cyy7.fsf@gitster.mtv.corp.google.com>
        <20161106173311.lqoxxgcklx4jlrg7@x>
Date:   Wed, 09 Nov 2016 14:57:54 -0800
In-Reply-To: <20161106173311.lqoxxgcklx4jlrg7@x> (Josh Triplett's message of
        "Sun, 6 Nov 2016 09:33:11 -0800")
Message-ID: <xmqqtwbg8dn1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3A5BEC6-A6CF-11E6-95CA-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

>> This would definitely need protocol extension when transferring
>> objects across repositories.
>
> It'd also need a repository format extension locally.  Otherwise, if you
> ever touched that repository with an older git (or a tool built on an
> older libgit2 or JGit or other library), you could lose data.

True.  Thanks for sanity-checking me.

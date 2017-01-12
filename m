Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7771FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 19:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbdALTbO (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 14:31:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60650 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750750AbdALTbN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 14:31:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 117945DF26;
        Thu, 12 Jan 2017 14:30:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cc9dIoabCr1W4TvR5VeB/KquA+M=; b=sowG5r
        vfBQZNQiWJjgy4OXNOVhgWzGLmnhqnFSRuEwqR8gQ8nL/ZdQmllEFdw94GJq/qgJ
        uTGhJNA5p7XGPkeLdWgG+vv0qlYcZqVGq94ZQMiYJHqritslzDuTwFkzu6DeNpTq
        +7p7sSq7meZMKk1RKm8HEMpJKSwvpK8+/s92g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CJo+J6Go8rUxWMEeE0R5s5ry/QnWeqEB
        /xBrpO5QvmGO8PrHq14iUMp9HNaQUimfQVy0DItChVDEOcBd9kxeJe+wof6DWWll
        BTiOPwn3xoWjcSmc0Xf13++tkV9p9YxlbEi0NNTlmmRP3SEZpataPR8gdYEz4lgz
        DH9Fg9fNkZ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F22405DF25;
        Thu, 12 Jan 2017 14:30:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B0D35DF23;
        Thu, 12 Jan 2017 14:30:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?66eI64iE?= =?utf-8?B?7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by `asciidoctor`
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
        <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
        <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
        <xmqqbmvi34ul.fsf@gitster.mtv.corp.google.com>
        <20170108032709.k43zmej5lxmcoj4o@sigill.intra.peff.net>
        <xmqqinpmpld0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701121130190.3469@virtualbox>
Date:   Thu, 12 Jan 2017 11:30:48 -0800
In-Reply-To: <alpine.DEB.2.20.1701121130190.3469@virtualbox> (Johannes
        Schindelin's message of "Thu, 12 Jan 2017 12:15:08 +0100 (CET)")
Message-ID: <xmqq37gokrdj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F64C428-D8FD-11E6-8172-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> And I tend to agree that the silliness you observed (like a t-o-c
>> for a one-section "chapter") is not quite welcome.
>> 
>> For now I queued only 2/2 which looked good.  I won't object if
>> somebody else rerolls 1/2 to appease AsciiDoctor, but let's take an
>> obviously good bit first.
>
> For fun, I just reverted the article->book patch and I was greeted with
> this:
> ...
> It still builds, funnily enough, but the result is definitely worse on the
> eyes. The page is *really* long, and structuring it into individual parts
> does help the readability.
> ...
> P.S.: I also tried to use [glossary] and [appendix] as appropriate, but it
> seems that AsciiDoc *insists* on level-2 sections in an appendix, while
> AsciiDoctor *insists* on level-3 sections.

So in short, what you are saying is that the support for articles in
AsciiDoctor is borked and totally unusable on an article that needs
to be taken correctly by AsciiDoc, and your conclusion is that the
only way to move forward (other than giving up using AsciiDoctor) is
to avoid writing documents as articles, and existing articles need
to be adjusted to read as books.

If that is the case, then I agree with the conclusion.  As I already
said, I won't object to a reroll of 1/2 to make the document format
well with AsciiDoctor without breaking rendering by AsciiDoc too
badly, and your "for fun" experiment illustrated that such a reroll
still needs to avoid using article style.  Perhaps 1/2 posted as-is
is the best we could do within that constraint.

Let's queue it on 'pu' and see if somebody else comes up with an
update that is more visually pleasing with both backends.

Thanks.




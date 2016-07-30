Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E3C1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 16:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbcG3QlJ (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 12:41:09 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35396 "EHLO
	mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcG3QlG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 12:41:06 -0400
Received: by mail-ua0-f178.google.com with SMTP id l32so81307447ual.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 09:41:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hMDsJ1ouh0wdeC+cPu/vQneMYrTWMaElB9JtgZDuWEk=;
        b=d0PGYTHRUBr2B/u1DJXcOzTZVLmSp5SFr/IrlUX0aLI/G2O6y2g/tHDsxW+Y8shxe0
         zWb78pTH5QnNwwHliMwtgE9hyQIXYs4SUA67TZ8uBWdK35tq4oOiHA2WmzZXWMiyEjCV
         enG+oW/WcU+DBgZkZcv4tu6seGYjDKL6U1Ef2jOP6FtseS+kc2oSc8iZI/Gp5sAZ1jzs
         1dyBaw1Fn4ozRYxPib46d3E8uTYxtmE2/lnV9aNO6uXARNSxnL0xxLX8jnl8H588PG8A
         tU5wJAC9qXoWPB+nHcPPc5R8Z/euRYwsrgZsRAy2LPQC8YP+Zc39XVgSrelCpIPn6cij
         oBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hMDsJ1ouh0wdeC+cPu/vQneMYrTWMaElB9JtgZDuWEk=;
        b=j8+V+tHZ6AjzazcB16EJUzerw+1lRUMdVEXwv4wpbgrEd5MU/Jn/7IWqz1Vtvbh7Gv
         elbenDHyO2FoDga3PsiGkMVLfQz7qgHrXyXQzaYyGOTYVA1RtGy5Pm3qukSRLUbxvvym
         W5rWwPsHm6Boalp7E4icO2jGtbuQKd/RMZ+BdhYeI5kBSv1e7aBIp6UW8yYNnhi2r9CE
         5pvi6JIY5wynrPu+7ZV0EOakPBW7YGoeioDIlqPpUm66djZoXZSqv2FqF/6G4HrhAVKf
         iy2AhsU2CM9wn5V/soH6hnqRA5OgCrj6NopeYxWfZyn7Xl+EOlJQaebSzd1glFwWlDnf
         U4xg==
X-Gm-Message-State: AEkoouuQ4n1augxJSpf2RnqEXiB9roiYdsukcyIhDLxroSmSOmh8UX2mzStKhxAaoalXSIILXQA2CZhYgvxn9w==
X-Received: by 10.176.3.199 with SMTP id 65mr18820632uau.32.1469896865045;
 Sat, 30 Jul 2016 09:41:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.33.135 with HTTP; Sat, 30 Jul 2016 09:41:04 -0700 (PDT)
In-Reply-To: <20160729224944.GA23242@sigill.intra.peff.net>
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
 <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com> <20160729181121.GB14953@sigill.intra.peff.net>
 <xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com> <20160729223134.GA22591@sigill.intra.peff.net>
 <xmqqwpk4kqr4.fsf@gitster.mtv.corp.google.com> <20160729224944.GA23242@sigill.intra.peff.net>
From:	Dakota Hawkins <dakotahawkins@gmail.com>
Date:	Sat, 30 Jul 2016 12:41:04 -0400
Message-ID: <CAG0BQXmF8Ro5j9oTPMCZwO4gfA+9VdGq3qQZwHJWSCuF_7h3Pg@mail.gmail.com>
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" +
 "pull.rebase = preserve" - "user.email"
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 6:49 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jul 29, 2016 at 03:45:35PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > TBH, I'm not sure anybody cares that much between the three. Even before
>> > user.useConfigOnly, this could be an issue on machines where the ident
>> > could not be auto-configured, and it seems like nobody ran across it.
>> > It's only the funny interaction with pull.rebase that makes it likely to
>> > come up, so as long as that code path is fixed (one way or another), I
>> > doubt anybody would bring it up again.
>>
>> Yup, I do not think the choice among the three would make all that
>> much difference in practice.  If I really have to pick one of them,
>> I think the one in your message I am responding to would make the
>> most sense.
>>
>> The one I sent, which I wrote as a response to some end-user request
>> on the list back then, has been sitting on 'pu' for quite a while
>> because I didn't see a real use or positive support for it, and the
>> only reason why I sent it is because this might be that one
>> real use it wanted to see.
>
> BTW, I didn't actually test yours, but if we do go that route I suspect
> you can reuse the tests I posted by just replacing "git rebase" with
> "git pull --rebase=<true|preserve> . master".
>
>> > In some ways this is less convenient, but in some ways it is
>> > more so; the user can then manually commit or even "git
>> > rebase --continue" after setting up their ident (or
>> > providing it as a one-off on the command line).
>>
>> Yup, that is the controvercial bit, and I suspect Dscho's original
>> was siding for the "set up ident first, as you will need it anyway
>> eventually", so I'll let others with viewpoints different from us to
>> chime in first before picking it up.
>
> Very sensible. Thanks.
>
> -Peff

All of the options sounds OK to me. I do like the idea of being able
to set it and --continue what I was doing.

Even more convenient than that would be an optional "user.prompt=true"
so the ident check could get what it needs from a simple terminal
prompt, set it in the local config, and try again before returning.

While that would be nice, I've been OK with the current system for my
working repositories for a while. I'm used to having to go set it and
repeat whatever I was trying to do, as it seems like I forget to set
my user.email about half of the time :)

-Dakota

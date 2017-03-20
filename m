Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E5E20958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755416AbdCTQS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:18:26 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37478 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755421AbdCTQSW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 12:18:22 -0400
Received: by mail-it0-f53.google.com with SMTP id g138so101692151itb.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fDj9xUtU0v6YQ9/xoIWqiSuu4Xdj4150uQ1HYeyoc/Y=;
        b=ftzRdVtA7vAjx3ZMXQv65g9tWrP5IrketWflWRyhvZk0pt/oX6ephh54k5csfWHQm9
         rDqXQIFblKdNhpgU6GglRTXq15xBY02bge8RmHuEedvYKuIpIxKpyePfaQvLkd6hyJ5M
         vqWoClI83qkv6oHiHPnza+tFGbv5YS6oThNJikgdwaU6nOoNKg8jZLMDgJF0B4vxoENq
         A2X0MKjQnC7XtPMQ6WjsYZ+yDS6N5E4YKRI7YOW9MN46V/oGPCokQXebYf+8YEm7CLju
         Pxbc0WQj38lyKJLtgtucOUKpZVZw7Lbwk3dyvT+OCpqIAyMQUuYRojJzMWn31nR2pjgh
         hzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fDj9xUtU0v6YQ9/xoIWqiSuu4Xdj4150uQ1HYeyoc/Y=;
        b=IfnQf15zP73U0zpKovyLx55zEH0VpdwiuE7c2AW4FIdpeJtNwZkZE3uNK6GZ4EDZPT
         tOmB82CbxHpp66Mi5bfODR6IZ7gNGoUIVnYDw81UahpSe2URBWm9bVYpXemUZHd0Xhp0
         nocAabREYo1GJPxwROuIkuoQ0YCVGbvUJJVa0ggqMd5xE6IgiEDBzTDiyzr2kOatpgcw
         mK8AL36assMm15XSJaLlhEtFYkY4f6b66ZPJdcEWr6L+RldvpaIWy/mnhqQTNfbJIELD
         SdRh832GavKpv7oUBTCojOw+CyuAe8lVmymCBtpptgWOFH7OEKqAXQL48Eu2i8FU35Vo
         3gzQ==
X-Gm-Message-State: AFeK/H3GDnKZWQhszgwFVy/ekR+kGPxVDvAivyg4zntAzAaUwubU7AASjq70crASk9HMfrBERfCYn9IQQZOeug==
X-Received: by 10.36.76.11 with SMTP id a11mr1782037itb.60.1490026163307; Mon,
 20 Mar 2017 09:09:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 20 Mar 2017 09:09:02 -0700 (PDT)
In-Reply-To: <20170320034443.wq2uf4yabsxh2nji@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com> <20170318103256.27141-4-avarab@gmail.com>
 <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com> <20170320034443.wq2uf4yabsxh2nji@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 20 Mar 2017 17:09:02 +0100
Message-ID: <CACBZZX5V3fMpwUCFr8vXMsxkXpz353-BOtaANYvnu9Qnz1GSQg@mail.gmail.com>
Subject: Re: [PATCH 3/8] tag: Change misleading --list <pattern> documentation
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 4:44 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 18, 2017 at 11:43:47AM -0700, Junio C Hamano wrote:
>
>> > +test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
>> > +   git tag -l -l >actual &&
>> > +   test_cmp expect actual &&
>> > +   git tag --list --list >actual &&
>> > +   test_cmp expect actual &&
>> > +   git tag --list -l --list >actual &&
>> > +   test_cmp expect actual
>> > +'
>>
>> OK.  I do not care too deeply about this one, but somebody may want
>> to tighten up the command line parsing to detect conflicting or
>> duplicated cmdmode as an error in the future, and at that time this
>> will require updating.  I am not sure if we want to promise that
>> giving multiple -l will keep working.
>
> I think it's expected to work under the usual last-one-wins option
> parsing. A more subtle case is that:
>
>   git tag -l -d foo
>
> would override "-l" with "-d". That's reasonable under the same rule as
> long as the user knows that the two are mode-selectors. I don't think we
> make that explicit in the documentation, though, so perhaps it isn't
> something users should rely on.

That hasn't been the case since v1.8.5 (v1.8.4-rc0-12-g1158826394).
Now supplying multiple CMDMODE invocations will die.

It is the case that we still need to manually check any pseudo-cmdmode
switches like "tag -a" (bool) v.s. "tag -l" (cmdmode). We check that
particular combination, but we doubtless have bugs like that in other
commands.

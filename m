Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213C11F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbeDSIXa (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:23:30 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33514 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeDSIX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:23:28 -0400
Received: by mail-wr0-f178.google.com with SMTP id z73-v6so11586125wrb.0
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SB4vQlymVG/M7zFUvR8ueJiXSNkg0fiXmVFPgk+GXsM=;
        b=GKYrrqUitg2/yC7StuDrsNukaaDPF1TneQrGAvihWg8XHJrVrlL5p/2SaFM842SBw7
         0s5EgMbxDJjvlo4qq+blT4pbuFpd8G3ELkl4PXibQC0eQiXIezkqaurtUibTUFXvxSTs
         DwRjW3dsdEvk7lAqbFRgGl7ryZu1u3LzvDnEisnlml/EbqnLvcmny3e8klvwcCAOxn+2
         WJmYfuUEVsnH4cHXMqfG3mkkAcNW/8xOR9YwJKowNmiw7+dsFE+UpRb1zw2BQyCdRlfn
         /S28DVQ6Xkbl5oJAxIfT0mXfduDEEQ0ciUodtKQ+I246TLOID0kJm9qH1LgUDAdNwB5S
         VpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SB4vQlymVG/M7zFUvR8ueJiXSNkg0fiXmVFPgk+GXsM=;
        b=tB1XupojmEzAI51H4bdB2C+jb3++O7kGKgZIqQ59uZ5PXjUHdLeNayASV/c0crMUh/
         BTSqisj/OPkhqDnZiNSILlVmjNnT6laItSyrAwlTLEW3L2b6cxmVXrf8TdNkw1lnCPpB
         5jnhC3ACCJoWQD1Bgw50JM0sIwSWoIDQZvmcOSSSTxrcigQnQ2YfbY8wXjtBfugIZFT0
         D+oDFY9SNEWsNvQtkXtLEjhEadsLxfeKLY/E35yEnCVinTuySPXWvFoz9yp+SYy6JFVn
         NJG55nuMllpcrYNbKHqWrqjBkrmL6XFAX2fpiE3DkPbmlx7WuhTbXAZSLPiqIaStBx+n
         Q21Q==
X-Gm-Message-State: ALQs6tCDPyW+23vYw+KgFNZjtLzj5in17WmJmktpUBA7qZkGswzc4iLq
        JVwO5oiD2S9pdxEzoJkokOlS/ZQjTbr8LqmYvL8=
X-Google-Smtp-Source: AIpwx4+8rrgzUh+oI0XeZDNmLq7vWV9b7Hcv3tkWQYe27RxIMH/At4ia/EoQngu9kM8IhqoOqf2ihFGq8GUUJKx9ToI=
X-Received: by 10.80.171.72 with SMTP id t8mr7488024edc.133.1524126207407;
 Thu, 19 Apr 2018 01:23:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Thu, 19 Apr 2018 01:23:06 -0700 (PDT)
In-Reply-To: <87fu3r257z.fsf@javad.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <871sfm737e.fsf@javad.com> <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87h8oh51jm.fsf@javad.com> <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com>
 <87sh810ym4.fsf@javad.com> <CA+P7+xq8LOUZxVd832cOQFi4V=2YvydxtT6_y4NLKvFkki4QdA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <5d522cc9-3922-9f24-3a1e-0c121c47ca96@talktalk.net> <nycvar.QRO.7.76.6.1804140146450.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87fu3r257z.fsf@javad.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 19 Apr 2018 01:23:06 -0700
Message-ID: <CA+P7+xrv54RBFx1eYbvgVyqQ88uxT73vOf3jazCVsvuXwvd-gA@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 18, 2018 at 9:24 PM, Sergey Organov <sorganov@gmail.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Hi Phillip,
>>
>> On Fri, 13 Apr 2018, Phillip Wood wrote:
>>
>>> On 12/04/18 23:02, Johannes Schindelin wrote:
>>> >
>>> > [...]
>>> >
>>> > So: the order of the 3-way merges does matter.
>>> >
>>> > [...]
>>>
>>> Those conflicts certainly look intimidating (and the ones in your later
>>> reply with the N way merge example still look quite complicated). One
>>> option would be just to stop and have the user resolve the conflicts
>>> after each conflicting 3-way merge rather than at the end of all the
>>> merges. There are some downsides: there would need to be a way to
>>> explain to the user that this is an intermediate step (and what that
>>> step was); the code would have to do some book keeping to know where it
>>> had got to; and it would stop and prompt the user to resolve conflicts
>>> more often which could be annoying but hopefully they'd be clearer to
>>> resolve because they weren't nested.
>>
>> I thought about that. But as I pointed out: the order of the merges *does*
>> matter. Otherwise we force the user to resolve conflicts that they
>> *already* resolved during this rebase...
>
> How it's relevant to what Phillip suggested? How the order of taking 2
> steps, A and B, affects an ability to stop after the first step? It's
> still either "A,stop,B" or "B,stop,A", depending on the chosen order.
>
> What's the _actual_ problem here, if any?
>
> -- Sergey

I believe the order of the merges changes which ones cause conflicts,
but it's possible to generate pre-images (i.e. a set of parents to
merge) which cause conflicts regardless of which ordering we pick, so
I'm not sure there is a "best ordering".

Thanks,
Jake

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E6C1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 20:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeDTUkQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 16:40:16 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:47092 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeDTUkP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 16:40:15 -0400
Received: by mail-wr0-f171.google.com with SMTP id d1-v6so26043229wrj.13
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q2DJqqwRyehmGoaXVKU6wFgB5WWBmicOx17ygV7Thcw=;
        b=igeY8MXTzyxSNtNypo6uuOc+G5sXmrPGzR7Cqngy1/UOSg8yiY2EboXteh/E1YmVQg
         bRcWHn5sg5BRqpwo+HMl/8E7D7J4kZljET57FOA0W+tbx03fpiy+QgEAAWPeIW/zpZmK
         fXc4RxqbP9AGxbJmqrZh2G7DQhi9AvVN9gBww2ODE2CBDStUnbrsIoHoWV9ygfcFJn7y
         GulAFKksbfPm0zoIxOS6WcY5M8qsQ5+jKMYuOgjW6RK4aZMtcirpM+/Owcs44qiQd936
         QH2JYvfNY2rMGfm+LcBDWFtA4ovmgzBO+z1P1QuAXW+24s/X6vZpgZQwX4Too973BBdz
         M89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q2DJqqwRyehmGoaXVKU6wFgB5WWBmicOx17ygV7Thcw=;
        b=Dl49Ti4Zr1+Kfd4rlHxt7kNqNB5TgrG8cZKcvQlMMI+gIpVQwkYknxlGpWnAkMz9f+
         RZnmJVlxaRRYKk1aIckliVkV2e7kS2GXBS/jEdKYzQTF5vq3K5O8ebBYOf7LBnTiq09d
         BaR3jxQXsuyXfHgLXfkjtKgbywMAVp6iLt+1SgksdMueEC9G3kbiw8V7Wh6kSUlsuMga
         9Zn2ValiuZdK8yuKMCiRfBZnWulqWn8V12ER5TxcwB570AH+8reCUly1XWX2zAQlvALT
         CMhAWbL/4tP7al1Ik+R0T71FdiCd7duobXz2LxanOBKu6B7OJVbDTslunVEZ6CVd3ihF
         hoRw==
X-Gm-Message-State: ALQs6tDGlj1kTYVWDL4QVMh6h5t9WQO7ZFVLJm/gljTiOalq5JFzpNAo
        B7UWXMKy934cebB6RQR2/qnGk4zXSCHfZP/ZlwY=
X-Google-Smtp-Source: AIpwx4/icTS2xRagW33wMyUgM9YfVmL99CAoSGHe23d35fHe2QLEYgu+6pCEoM+EDhue9SfA3u2pLd5YPmgMDxWZ4i4=
X-Received: by 10.80.241.93 with SMTP id z29mr15591383edl.62.1524256814015;
 Fri, 20 Apr 2018 13:40:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Fri, 20 Apr 2018 13:39:53 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804201017450.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <871sfm737e.fsf@javad.com> <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87h8oh51jm.fsf@javad.com> <CA+P7+xq8KJKJ0d1unW3btUhKVjOZM3EdTSKdDs96pn5J3WwSKA@mail.gmail.com>
 <87sh810ym4.fsf@javad.com> <CA+P7+xq8LOUZxVd832cOQFi4V=2YvydxtT6_y4NLKvFkki4QdA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <5d522cc9-3922-9f24-3a1e-0c121c47ca96@talktalk.net> <nycvar.QRO.7.76.6.1804140146450.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87fu3r257z.fsf@javad.com> <CA+P7+xrv54RBFx1eYbvgVyqQ88uxT73vOf3jazCVsvuXwvd-gA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804201017450.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 20 Apr 2018 13:39:53 -0700
Message-ID: <CA+P7+xpA-1L83fGkUr+bnG7b9P3z+huOuSJO=eG5Em+Cpb759w@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Organov <sorganov@gmail.com>,
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

On Fri, Apr 20, 2018 at 1:26 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake,
>
> On Thu, 19 Apr 2018, Jacob Keller wrote:
>
>> On Wed, Apr 18, 2018 at 9:24 PM, Sergey Organov <sorganov@gmail.com> wrote:
>> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >
>> >> On Fri, 13 Apr 2018, Phillip Wood wrote:
>> >>
>> >>> On 12/04/18 23:02, Johannes Schindelin wrote:
>> >>> >
>> >>> > [...]
>> >>> >
>> >>> > So: the order of the 3-way merges does matter.
>> >>> >
>> >>> > [...]
>> >>>
>> >>> Those conflicts certainly look intimidating (and the ones in your later
>> >>> reply with the N way merge example still look quite complicated). One
>> >>> option would be just to stop and have the user resolve the conflicts
>> >>> after each conflicting 3-way merge rather than at the end of all the
>> >>> merges. There are some downsides: there would need to be a way to
>> >>> explain to the user that this is an intermediate step (and what that
>> >>> step was); the code would have to do some book keeping to know where it
>> >>> had got to; and it would stop and prompt the user to resolve conflicts
>> >>> more often which could be annoying but hopefully they'd be clearer to
>> >>> resolve because they weren't nested.
>> >>
>> >> I thought about that. But as I pointed out: the order of the merges *does*
>> >> matter. Otherwise we force the user to resolve conflicts that they
>> >> *already* resolved during this rebase...
>> >
>> > How it's relevant to what Phillip suggested? How the order of taking 2
>> > steps, A and B, affects an ability to stop after the first step? It's
>> > still either "A,stop,B" or "B,stop,A", depending on the chosen order.
>> >
>> > What's the _actual_ problem here, if any?
>> >
>> > -- Sergey
>>
>> I believe the order of the merges changes which ones cause conflicts,
>
> That is a correct interpretation of the example I showed.
>
>> but it's possible to generate pre-images (i.e. a set of parents to
>> merge) which cause conflicts regardless of which ordering we pick, so
>> I'm not sure there is a "best ordering".
>
> In general, there is no best ordering, you are right. There is no silver
> bullet.
>
> I am not satisfied with stating that and then leaving it at that.
>
> In the example I presented, you can see that there are common cases where
> there *is* a best ordering. In the wrong order, even if you would force
> the user to resolve the merge conflict in an intermediate merge (which
> would introduce a nightmare for the user interface, I am sure you see
> that), then the next merge would *again* show merge conflicts.
>
> And I, for one, am *really* certain what my decision would be when offered
> the two options 1) force the user to resolve merge conflicts *twice*, or
> 2) reorder the intermediate merges and present the user with exactly one
> set of merge conflicts.
>
> So it is irrelevant that there might not be a "best order" in the general
> case, when in the common cases quite frequently there is.
>
> It is just another example where theory disagrees with practice. Don't get
> me wrong: it is good to start with theory. And likewise it is simply
> necessary to continue from there, and put your theory to the test. And
> then you need to turn this into something practical.
>
> Ciao,
> Dscho

I recall you suggested an approach of "try one way, if there are
conflicts, check the other way and see if it had conflicts".

And I also agree that forcing the user to resolve conflicts in the
middle of the operation is a huge nightmare of a user interface,
probably worse than the issues with nested merge conflicts.

Thanks,
Jake

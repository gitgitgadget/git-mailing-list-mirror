Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123F02047F
	for <e@80x24.org>; Tue, 25 Jul 2017 08:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbdGYIHb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 04:07:31 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35177 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdGYIHa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 04:07:30 -0400
Received: by mail-qk0-f180.google.com with SMTP id d145so58049401qkc.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KMgt6AotQClHfBXDszU37aHVo3gXUU074l0h++zRKaQ=;
        b=mZHrDGJ3/ZJClwEv5EfnYrRFJ8fK7LC4mhC8kyQTS0lq1dVlOKHgASr5DoaZSrNFo5
         9l3y835SgWF5R4ZZOwAM4IV4n3Duv4TwGnwEyIbl1hyt+fYYObh73ga1BdWw/XissRJy
         0GIifMz94BTOoGCg+89d8Vyi4vsHLiYyQOZ6Ih+PhD5snQ2G+6FJ6QkuEQ/GjWnOS9lA
         lsvVKRsnSg2zRd/jjmwRWe3cRIm97I6DUG0iPCjX3q+RIr7DooFUhRHQIE3WtEAs680m
         BYnb889+YO6uxoMGijwf1bZRqKJyBQ2Fcex1t59CDwScq51Ots8zk5/qHloyd2Nb1NEv
         gCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KMgt6AotQClHfBXDszU37aHVo3gXUU074l0h++zRKaQ=;
        b=q5cPycIOjwweOZS5P3uhWCqRJIxhagN02coImzytjfj8Ia8Fi48g+vKoWbKeyHe35I
         DwElX1zriBBs6WwsGVRCsafgRobCXG2eTOi5qKnzAWyr5Z9w9/9qBs/umPfqbxxz1T7A
         WxTV3pevh+2yk/cP8QZIS4xpg4i2ruiLD+S1xGhBKwAeaQLGBoPFr/C8pTm3oOpLbcDt
         vLEIGLV5mwoz1dGDyaruroYLIgdy7jXeWE9gSIKeCcs6L4bYav6KBtjc6swTQ7j5TxYk
         sScF8ZSrToo2hgLipP1ZTeFgiAx10Lk1Pe10POE5tgAxhDysBspqKWgmBNOHAkReXDJn
         110A==
X-Gm-Message-State: AIVw112Y5up8GSVZDBhfAywG5J3Qg4IFseYoaEtU1IwqX1Pxx749pgcv
        vMXwnsDMWqH48V0RFIsaZXkxo7WNzQ==
X-Received: by 10.55.140.134 with SMTP id o128mr7027457qkd.250.1500970049967;
 Tue, 25 Jul 2017 01:07:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.39.151 with HTTP; Tue, 25 Jul 2017 01:06:49 -0700 (PDT)
In-Reply-To: <20170724181118.ntqjqfihhblbvwmi@sigill.intra.peff.net>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
 <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
 <CANENsPr271w=a4YNOYdrp9UM4L_eA1VZMRP_UrH+NZ+2PWM_qg@mail.gmail.com>
 <CAH5451m0P4eZMXj8ojgbd+q-8scoJpwn9UcZLvqYKM=+8hhWPg@mail.gmail.com> <20170724181118.ntqjqfihhblbvwmi@sigill.intra.peff.net>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Tue, 25 Jul 2017 18:06:49 +1000
Message-ID: <CAH5451nbY+Xo0Fpe2OdsxwJeRV1ddZmYX7v-bPYgRsbS2kNJSg@mail.gmail.com>
Subject: Re: Should I store large text files on Git LFS?
To:     Jeff King <peff@peff.net>
Cc:     Farshid Zavareh <fhzavareh@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 July 2017 at 04:11, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 24, 2017 at 02:58:38PM +1000, Andrew Ardill wrote:
>
>> On 24 July 2017 at 13:45, Farshid Zavareh <fhzavareh@gmail.com> wrote:
>> > I'll probably test this myself, but would modifying and committing a 4GB
>> > text file actually add 4GB to the repository's size? I anticipate that it
>> > won't, since Git keeps track of the changes only, instead of storing a copy
>> > of the whole file (whereas this is not the case with binary files, hence the
>> > need for LFS).
>>
>> I decided to do a little test myself. I add three versions of the same
>> data set (sometimes slightly different cuts of the parent data set,
>> which I don't have) each between 2 and 4GB in size.
>> Each time I added a new version it added ~500MB to the repository, and
>> operations on the repository took 35-45 seconds to complete.
>> Running `git gc` compressed the objects fairly well, saving ~400MB of
>> space. I would imagine that even more space would be saved
>> (proportionally) if there were a lot more similar files in the repo.
>
> Did you tweak core.bigfilethreshold? Git won't actually try to find
> deltas on files larger than that (500MB by default). So you might be
> seeing just the effects of zlib compression, and not deltas.

I tweaked nothing!

The space saving I assumed was pretty much just zlib compression, and
I wasn't sure how much delta we actually could get, and how long that
might take to run.

> You can always check the delta status after a gc by running:
>
>   git rev-list --objects --all |
>   git cat-file --batch-check='%(objectsize:disk) %(objectsize) %(deltabase) %(rest)'
>
> That should give you a sense of how much you're saving due to zlib (by
> comparing the first two numbers for a copy that isn't a delta; i.e.,
> with an all-zeros delta base) and how much due to deltas (how much
> smaller the first number is for an entry that _is_ a delta).

Let's have a look:

$ git rev-list --objects --all |
  git cat-file --batch-check='%(objectsize:disk) %(objectsize)
%(deltabase) %(rest)'
174 262 0000000000000000000000000000000000000000
171 260 0000000000000000000000000000000000000000
139 212 0000000000000000000000000000000000000000
47 36 0000000000000000000000000000000000000000
377503831 2310238304 0000000000000000000000000000000000000000 data.txt
47 36 0000000000000000000000000000000000000000
500182546 3740427683 0000000000000000000000000000000000000000 data.txt
47 36 0000000000000000000000000000000000000000
447340264 3357717475 0000000000000000000000000000000000000000 data.txt

Yep, all zlib.

What do you think is a reasonable config for storing text files this
large, to get good delta compression, or is it more of a trial and
error to find out what works best?

Regards,

Andrew Ardill

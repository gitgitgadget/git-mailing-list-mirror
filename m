Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994BA1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 23:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbdFEXaB (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 19:30:01 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:36333 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbdFEX3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 19:29:54 -0400
Received: by mail-ot0-f172.google.com with SMTP id i31so5965190ota.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dOnHsusd57LJobE/K0PMCOATpqnr+rBQ8QE21LUYUnc=;
        b=U9c2rpBKUHHDf/PgC2L/da0V2oC9rPyjeREn5m+5IO3eoi1qhMdvarLCWNkClfhA+9
         9/FhtOrbdM4Nj/0hQzYD+wZ9tRl1CbWssBDx9xN758XDZJ9IqqMqodavUkIVZ83ZwDBD
         Bld/cUEUjA9essWGlM2q2ZyUD+nzvq36QzoNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dOnHsusd57LJobE/K0PMCOATpqnr+rBQ8QE21LUYUnc=;
        b=Q4BoSvwO5MXTXvmm1MHOP9I4aPeypPnNFRo10NQxHxnLnuyN3gM67MfGaTArfs0qMb
         rzeuWoVIcW+H6UnF1+KG8NWtLxtLQm7JFGxLx3ohqTjQJ+V02GhBMWnxT6l/6FKElX5o
         8x6dGaTsHq89LdoaJKgg6vrTSnfvMZK3wiwL/WOYAPyJiuyRHn59VaLTFeq0ypu8miUq
         OAVzB9wW1B2/WrG0Dy6WOzfLK75LeAWvxt3QcN56HY4/4VUzynVW487FbvoNkL1C/uF3
         iaUXdzMI1UnivJmzbpIlDngZPtTcmP7wdbp8PjJHYYR0ho3ZWuv0rz0p7lVITFWsfMSV
         Sowg==
X-Gm-Message-State: AKS2vOzdyl9tfylP5Hwoafyd5pa4hxqypuj4LT8HHPl8rffhUOwnKMto
        daJVo5cyEnvJagObLCk9YWJkajZZRuo3
X-Received: by 10.157.50.41 with SMTP id t41mr11911351otc.70.1496705393047;
 Mon, 05 Jun 2017 16:29:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.62.71 with HTTP; Mon, 5 Jun 2017 16:29:52 -0700 (PDT)
In-Reply-To: <CAKOu8-0DG_wQf4ch_MH=rjAncg1iP=uA1U7XHgXe7JNrEJSkGg@mail.gmail.com>
References: <CAPRL90JeQ3i1m7ydYzTCFgtZ4cC+gYEXFeAKvCuAVwPLXpsgXg@mail.gmail.com>
 <CAE5ih7-Nmy2J6zO9mx7g=L7Ey9PnVUcD3wnXBN4_0znwOHaUeQ@mail.gmail.com>
 <CAKOu8-2iBV=sAP0WeRMQFT+0y5cJ1g6A3bQ5x=D=8q9ocxnBVg@mail.gmail.com> <CAKOu8-0DG_wQf4ch_MH=rjAncg1iP=uA1U7XHgXe7JNrEJSkGg@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 6 Jun 2017 00:29:52 +0100
Message-ID: <CAE5ih79VCpmMmaq0AEW=5HeOmVdpjpSmh=1CheUZbqvbNfBFbA@mail.gmail.com>
Subject: Re: Git p4 sync changelist interval
To:     =?UTF-8?B?0JDQvdC00YDQtdC5INCV0YTQsNC90L7Qsg==?= 
        <1134togo@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 June 2017 at 19:50, =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=95=D1=84=
=D0=B0=D0=BD=D0=BE=D0=B2 <1134togo@gmail.com> wrote:
> 2017-06-04 14:09 GMT+03:00 Luke Diamand <luke@diamand.org>:
>>
>> On 4 June 2017 at 10:56, =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=95=D1=
=84=D0=B0=D0=BD=D0=BE=D0=B2 <1134togo@gmail.com> wrote:
>> > Hello,
>> >
>> > My goal is to sync the repository from p4 using an interval of
>> > changelists so that the first changelist version of the repository
>> > would be considered as an initial commit.
>> > So I used the following command:
>> >
>> >  git p4 clone //depot@cl1,cl2
>> >
>> > And when it finished, the files, that were created before the cl1 were
>> > not in the HEAD.
>>
>> Do you mean that if foo.c was created at cl1+1, that after doing the
>> clone, it wasn't there?
>>
>> If so, that doesn't sound right to me.
>>
>> I have just tried doing what I think you mean:
>>
>> 1. Create p4 depot
>> 2. Add foo.c (at CL 2)
>> 3. Add bar.c (at CL 3)
>> 4. git-p4 clone //depot@2,3
>>
>> I end up with both files.
>>
>> >
>> > The problem, as I see it, is that before syncing changes in the given
>> > range, p4 task does not sync to cl1 version of the repo, and applies
>> > commits to the empty repository.
>> > Is it a bug or my misunderstanding of how git p4 should work?
>>
>> Possibly I'm misunderstanding what you're doing! Can you give a
>> sequence of steps to show the problem?
>
> What I meant is:
>
> 1. Create p4 depot
> 2. Add first.file (CL 2)
> 3. Add second.file (at CL 3)
> 4. Add third.file (at CL 4)
> 5. Modify first.file (at CL 5)
> 4. git-p4 clone //depot@3,5
>
> In this case first.file, will not be represented in the repository.

Hmmm, it's not working right for me. Although in my case I seem to be
missing the second file.

It's fine if I don't use the revision range "3,5".

Luke

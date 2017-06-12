Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEB51F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 15:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbdFLPxA (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 11:53:00 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36362 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbdFLPw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 11:52:58 -0400
Received: by mail-pf0-f177.google.com with SMTP id x63so52908749pff.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 08:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zEtheDY+52pWU3hn+h/RaIV8T90d60+VoCeoUH4Tmic=;
        b=QTl90hgi0rdGhDfZvX9dzZQbcA8sY4nSUSlcowiuiNbv9RLVqKQ/ooOPUCHw3cmXcZ
         35Vm9oA703o9k0CS01Grs9X2miBEy4JfG9jgUI5he0zcVn4IXJKveesjvrQxJYPFUXm8
         R0sxVlbfXC+dgNDrnufP2z+FNwStet+L8ct/clEhhMcmyHNkUhW5L+E/byJaAGi5ZL0F
         xQygK1TwsHbODL3fmAKvfLwajDmI4vCiIszmHu57D6kBm/nqgEqNhmAvYRewv9fGbMMY
         zftbyKC46j4FVka4dnhZRaDSyIFPUewbfVexQc7IWwhkYLBfl3aFkd0fPTOkGWWn7r4I
         q/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zEtheDY+52pWU3hn+h/RaIV8T90d60+VoCeoUH4Tmic=;
        b=GQ+1fHQS3nQHRCSJ9KNAjSD4Ma/6DRyQ4VsXnQ2o6PSu4GBIYGfbHZ5Rn1GPDpPqz4
         ir6j7MqmormfGvCZP9IkbQhegmiUN9+JBk74T2loeq88Ywr+E/NWiUAMT1pCVVu23u7e
         7wlFUKYgUhPcby3RTgOyHSIVwJjEsytnOb+XsCMPN2oCqdyaxnPVJ2lrTyBeNoqmwDQc
         SUMJdjXsy5vetx1wAvqztPWOykdF9HvUkPeQbhTsjfqg5Dy6UStwO0P9QthIHlloIhPb
         rRkk6qd0UHVtVmW4a4npqEpxhNFFcQglZpborFSfvWb/M6nOwWOMDSRFzDnzsK7oFsQj
         Vn3w==
X-Gm-Message-State: AODbwcDmISX30aQe3vdlCqWfegvfMIseFKJapGTQJ4UN2SWQJPvX/B8G
        05RRtjGhz98BipIxMDs=
X-Received: by 10.98.153.135 with SMTP id t7mr14330248pfk.160.1497282777389;
        Mon, 12 Jun 2017 08:52:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id y29sm15119576pff.50.2017.06.12.08.52.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 08:52:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lars Schneider" <larsxschneider@gmail.com>,
        "Philip Oakley" <philipoakley@iee.org>
Cc:     <git@vger.kernel.org>, <peff@peff.net>
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
References: <20170609142151.94811-1-larsxschneider@gmail.com>
        <31A456B20D984421AA958A39B2FCD29D@PhilipOakley>
Date:   Mon, 12 Jun 2017 08:52:55 -0700
In-Reply-To: <31A456B20D984421AA958A39B2FCD29D@PhilipOakley> (Philip Oakley's
        message of "Sat, 10 Jun 2017 13:48:50 +0100")
Message-ID: <xmqqlgoxp5ig.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Lars Schneider" <larsxschneider@gmail.com>
>> Many open source projects use github.com for their contribution process.
>> Although we mirror the Git core repository to github.com [1] we do not
>> use any other github.com service. This is unknown/unexpected to a
>> number of (potential) contributors and consequently they create Pull
>> Requests against our mirror with their contributions. These Pull
>> Requests become stall [2]. This is frustrating to them as they think we
>> ignore them and it is also unsatisfactory for us as we miss potential
>> code improvements and/or new contributors.
>>
>> GitHub offers a way to notify Pull Request contributors about the
>> contribution guidelines for a project [3]. Let's make use of this!
>>
>> [1] https://github.com/git/git
>> [2] https://github.com/git/git/pulls
>> [3]
>> https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/
>>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>
> I see there are currently 84 open PRs (13 in the last 14 days), so it
> is real.

Not so insignificant fraction of these are done purely for the
purpose of using submitgit, though.  In other words, if submitgit
were improved not to require a pull request against [1] (instead, it
could be pointed at a branch in a contributor's repository and do
the fromatting), these numbers will go down.

>> +Thanks for taking the time to contribute to Git! Please be advised,
>> that the Git community does not use github.com for their
>> contributions. Instead, we use a [mailing
>> list](http://public-inbox.org/git/) for code submissions, code
>> reviews, and bug reports.
>
> Isn't the mailing list git@vger.kernel.org, with an archive at
> http://public-inbox.org/git/ ?
>

I agree that I found the URL of the archive somewhat misleading for
those who want to contribute.  Giving the mailing list address makes
a lot more sense.  As suggested by Ævar in the thread, it would also
be good to suggest submitgit, given that the target audience of this
message was already prepared to throw a pull request at us.

>> +Please [read the maintainer
>> notes](http://repo.or.cz/w/git.git?a=blob_plain;f=MaintNotes;hb=todo)
>> to learn how the Git

Two minor issues here.

1. push the "read" outside [], i.e.

	Please read [<human readable name of the thing>](<URL for
	the thing>) to learn...

   as what is inside [] and what is inside () ought to be the moral
   equivalents.

2. the thing is not called "the maintainer notes"; it is called "A
   note from the maintainer". 

> Is using the repo.or.cz address deliberate as a way of highlighting
> that Github isn't the centre of the universe when accessing a DVCS
> repo?
>
> Maybe the kernel.org repo should be first, or at least the alt-git.git
> repo at repo.or.cz listed in those same notes.

I'd prefer [the k.org address](https://git.kernel.org/pub/scm/git/git.git/plain/MaintNotes?h=todo).

>> +project is managed, and how you can work with it. In addition, we
>> highly recommend you to [read our submission
>> guidelines](../Documentation/SubmittingPatches).

Again, push "read our" outside [].

Thanks.

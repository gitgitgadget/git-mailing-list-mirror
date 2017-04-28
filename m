Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1DC1FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 08:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162903AbdD1I6L (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 04:58:11 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33787 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033719AbdD1I6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 04:58:07 -0400
Received: by mail-io0-f193.google.com with SMTP id k87so9605426ioi.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M5EE7qsIxXIry4dNlAwj3zteJ28D7AFWoKiw0iMz12g=;
        b=lYztI3qBvCYaKIGg1f6sPt9IWX+mDxT1Q4l9MOFK5ZpB1koV5wfECf3xH/B7Myzf6e
         pNuNYRWTon178ldlqdWJvnF/+2qfZFvHZp0IuwHAMqVgGH/norQkxaufK2ugp0vYvu2V
         OkiGl/YH4O101HLLkGciAeqRX5ihDd9bFZWv8Ag3Jslf8zW1CUOmvGstCN6szZZQsPlY
         Pidq7quAJHZci3XvC0c2R6MWQbK0Qc37KqeDDUYU6MmmT7Qjs+HG0Em6EgwdDsv/nivd
         n8Ioe725HjUkt1J3jqubKtx2aKkl9D+SGUQP8IXHb9Qy0nWD78aSW4vYqtdwFG6LLTps
         DsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M5EE7qsIxXIry4dNlAwj3zteJ28D7AFWoKiw0iMz12g=;
        b=SfI/zeSr5RWZ9zQ1ESpB9bwLJQ+KfFhpCp66+MbeT2ePFXbO7k8Me9e3btwlLg6rZK
         xl1yi+32vRWEquIzGzEf6OWSJVfjqzr6rKpcadgB0i2m1eImhUR6Wr+NfAQBUNCFW4M3
         z1jkv/rxk/c84tgsfyQIlDF97S0ofbcHMuL/7L9Px3HZjAYn4PdXp2AC81BUl2s0P3LR
         hMeFRn5HD4BoEnkpC2hW6P//VEsTdjuTey793m4JGzRdD/1epw2go6nSyIaxNbGMM0//
         hBe+oTnGYdJ0dXPMF6o1F9u/UHSg/G7ZHFMspqq7AOeKp1SMV2kGQsuzxQYvtPL9yG40
         QY7w==
X-Gm-Message-State: AN3rC/7vSteMydAkMLAB/M0pC/WK7SKi2SeTyzJsPktaWkCnwrRL/spl
        UkmIZzZtijV+QqwXOru1VjQ+lPqnBA==
X-Received: by 10.107.138.9 with SMTP id m9mr9296439iod.80.1493369881294; Fri,
 28 Apr 2017 01:58:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 28 Apr 2017 01:57:40 -0700 (PDT)
In-Reply-To: <20170427222700.GD146047@google.com>
References: <20170426231236.27219-1-avarab@gmail.com> <20170427222700.GD146047@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 28 Apr 2017 10:57:40 +0200
Message-ID: <CACBZZX7H5KwHXiQd=YFSuoY=VLMb7kXyaxDQg-iiiBb=DL8X8w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] clone: --no-tags option
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 12:27 AM, Brandon Williams <bmwill@google.com> wrot=
e:
> On 04/26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This is an expansion of the previously solo 02/05 "clone: add a
>> --no-tags option to clone without tags" patch (see
>> <20170418191553.15464-1-avarab@gmail.com>).
>>
>> This addresses the comments by Junio & Jonathan Nieder on v2 (thanks a
>> lot), and in addition implements a --no-tags-submodules option. That
>> code was implemented by Brandon & sent to me privately after I'd
>> failed to come up with it, but I added tests, a commit message & bash
>> completion to it.
>
> Na you would have come up with it, I've just lived in submodule land a
> little too long (though not as long as Stephan has!) :D
>
>> The WIP 5/5 patch implements a submodule.NAME.tags config facility for
>> the option, but is broken currently & floats along in this submission
>> as an RFC patch. AFAICT it *should* work and it goes through all the
>> motions the similar existing *.shallow config does, but for some
>> reason the tags=3Dfalse option isn't picked up & propagated in a freshly
>> cloned submodule.
>>
>> I'm probably missing something trivial, but I can't see what it is,
>> I'm hoping thath either Stefan or Brandon will see what that is.
>
> Overall the series looks good.  I've mentioned in the other threads that
> it probably makes more sense to have --recurse-submodules simply pass
> through known good commands to its children (e.g. --no-tags) simply
> because it makes the UX a little bit easier to work with (I don't have
> to remember all the fancy --OPT-submodules stuff, only
> --recurse-submodules).  That is unless you have some good rational that
> I'm not considering (completely possible :D).

I have no good (or bad) reason for that other than just wanting to add
--no-tags to submodules while I was at it, and then I was just
following the pattern the option to pass along --depth was
establishing.

But if that's some anti-pattern and the consensus is that this
submodule feature should instead work as you describe (which looks
like the case) I'll change it to work like that.

>>
>> Brandon Williams (1):
>>   clone: add a --no-tags-submodules to pass --no-tags to submodules
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>>   tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"
>>   clone: add a --no-tags option to clone without tags
>>   tests: rename a test having to do with shallow submodules
>>   WIP clone: add a --[no-]recommend-tags & submodule.NAME.tags config
>>
>>  Documentation/git-clone.txt                        |  21 ++++
>>  Documentation/git-submodule.txt                    |   8 +-
>>  builtin/clone.c                                    |  19 +++-
>>  builtin/submodule--helper.c                        |  21 +++-
>>  contrib/completion/git-completion.bash             |   3 +
>>  git-submodule.sh                                   |  13 ++-
>>  submodule-config.c                                 |   8 ++
>>  submodule-config.h                                 |   1 +
>>  t/t5612-clone-refspec.sh                           | 103 ++++++++++++++=
+++---
>>  ...odules.sh =3D> t5614-clone-submodules-shallow.sh} |   0
>>  t/t5616-clone-submodules-tags.sh                   | 106 ++++++++++++++=
+++++++
>>  11 files changed, 284 insertions(+), 19 deletions(-)
>>  rename t/{t5614-clone-submodules.sh =3D> t5614-clone-submodules-shallow=
.sh} (100%)
>>  create mode 100755 t/t5616-clone-submodules-tags.sh
>>
>> --
>> 2.11.0
>>
>
> --
> Brandon Williams

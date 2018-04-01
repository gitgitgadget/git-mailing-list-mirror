Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87DB51F404
	for <e@80x24.org>; Sun,  1 Apr 2018 14:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeDAOkC (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 10:40:02 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:32951 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753504AbeDAOkB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 10:40:01 -0400
Received: by mail-pl0-f41.google.com with SMTP id s10-v6so741043plp.0
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kOejjVxenJo2rMIhgs62OqInfKGlqsHmD7W9DqMPP9w=;
        b=QvamMBszQyBFhnJcRAxehBVBpjTqH4a8i8ZZHGSFFpIxIGI1Eh9/AFHMXOOppe8d1Q
         4/4BcHUB9/8nRPqbHNEYZq9AWCHDpQqamU9U6V8qaUA6H1CNwj5C7qrsz+LESvnVPMIZ
         2Vevaw7v14jQ/B/7ODLAmYTk0S/mrghIXLp/qRN5XPjuyInOZksMfB7e+Erw3IuoqBYR
         exxEP2S6qY0NNPuOXnyDBWgSdNsylfV7bRGplKPdIsOAmFk/DBt/TPjqVe8tUlt0fu2B
         1TcFUQjy3lbRotBRf9Zrvkji21hjR21LjpGpWhlf5/3FORF2AmwYo3p5qigP+PHyn1RS
         X1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kOejjVxenJo2rMIhgs62OqInfKGlqsHmD7W9DqMPP9w=;
        b=ImlBBoj4Zq6P0agJh4QBEpTi8XOnOs28rPsr4QxlSlZN6Lwq2Nb1gSXPB2GQ6PyYfv
         Ui+57hMTFPsXbAdRFZ9/1S43b9gsislwzp7iagjgOx/D48s5nQxz6Oal0GiwUT9nBKjw
         TzwUuPb3d+J8JP5kNQBy4KwaRTqVQZne56Ipne7plh74qzGu0xrH3F8J7epL85G1ICiI
         QZ1K6uC2SSz+najmaDnVg2h3KmRO0n8hq6kEe4ZrgzyNolgL+TuEUM+gjVXZRZolMUU1
         0umQYn9qoriTlhO+jIH9z73tQgmBG3ei6AfP1XrBl8/i51H1rV+a5SmzdcFiM3M9QHo7
         rCCg==
X-Gm-Message-State: AElRT7GFabZdK3ACPNDzEAEU5KZj3aolT6Z/xMkQT6C7xW1R1fzj3IMk
        xwb/3InsaCBbzyzOo95fzcY=
X-Google-Smtp-Source: AIpwx49hxVOmHGG6ppbm4MM7ri5Imt70F40IFM8rpaK/QrFCom/S63/0+g16Dubww4xcR5DHD/i5wQ==
X-Received: by 2002:a17:902:d681:: with SMTP id v1-v6mr5357656ply.284.1522593600781;
        Sun, 01 Apr 2018 07:40:00 -0700 (PDT)
Received: from rempc0jmh7t.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id j83sm18532648pfe.178.2018.04.01.07.39.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Apr 2018 07:40:00 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [GSoC] [PATCH] travis-ci: added clang static analysis
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAMOtk6Df_7Jb9bX=8PfB9e4-5rRi8QSmXEK7=DmZui6LNBMSLQ@mail.gmail.com>
Date:   Sun, 1 Apr 2018 16:39:52 +0200
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <74BBE628-B8FC-4699-9A23-F774D4908011@gmail.com>
References: <20180305200400.3769-1-sidm1999@gmail.com> <89AEA176-2D3F-4271-958E-1C6BCC944842@gmail.com> <CAMOtk6Df_7Jb9bX=8PfB9e4-5rRi8QSmXEK7=DmZui6LNBMSLQ@mail.gmail.com>
To:     Siddhartha Mishra <sidm1999@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Mar 2018, at 18:45, Siddhartha Mishra <sidm1999@gmail.com> =
wrote:
>=20
> On Mon, Mar 12, 2018 at 3:49 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> Hi,
>>=20
>> That looks interesting but I agree with Dscho that we should not =
limit
>> this to master/maint.
>>=20
>> I assume you did run this on TravisCI already? Can you share a link?
>> I assume you did find errors? Can we fix them or are there too many?
>> If there are existing errors, how do we define a "successful" build?
>>=20
>> Thanks for working on this,
>> Lars
>>=20
>=20
> Thanks for the reply,
>=20
> I assume there will be false positives in the code which we can't fix
> by making small modifications to the code as recommended in the FAQ
> (https://clang-analyzer.llvm.org/faq.html). According to the FAQ,
> there is no solid mechanism for suppressing a specific warning, so are
> options are limited. Some of the things which might help reduce the
> noise are:
>=20
> 1) To add specific tags in our source code to tell the analyzer to
> ignore the code. This is probably a bad idea since it is intrusive and
> forces changes to the actual source code which only affect one task.
>=20
> 2) Count the number of bugs in the previous pushed build and fail the
> build if the number of bugs increases. It doesn't help remove the
> noise from the error log but it does tell you if you've added more
> bugs. However if you add a bug and remove one, it'll pass the job and
> might mislead you into thinking that the code is correct.
>=20
> 3) Write a script to check the diff of the error log from that of the
> previous pushed build(ignoring the line numbers). I haven't thought
> about how exactly it would be implemented so I'm not commenting on it.
>=20
> Is there a better solution that I'm missing or should I try coming up
> with a script to come up the diff?

That's a good summary and I don't see a better solution. While (3)
sounds nice, I think (2) is the fastest/most pragmatic solution.

We already use the Travis cache [1]. You could use that mechanism to=20
store a file with the latest number of bugs in the cache directory=20
$HOME/travis-cache

If the "number of bugs" file does not exist, then create it and don't
complain. If the file exists and the previous number of bugs is higher
or equal, then don't complain either. If the file exists and the =
previous
number of bugs is lower, then let the build fail.

Do you think that could work?

Cheers,
Lars=20

[1] https://docs.travis-ci.com/user/caching/


>=20
> Thanks for the time,
> Siddhartha
>=20
> On Mon, Mar 12, 2018 at 3:49 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> Hi,
>>=20
>> That looks interesting but I agree with Dscho that we should not =
limit
>> this to master/maint.
>>=20
>> I assume you did run this on TravisCI already? Can you share a link?
>> I assume you did find errors? Can we fix them or are there too many?
>> If there are existing errors, how do we define a "successful" build?
>>=20
>> Thanks for working on this,
>> Lars
>>=20
>>> On 05 Mar 2018, at 21:04, SiddharthaMishra <sidm1999@gmail.com> =
wrote:
>>>=20
>>> Added a job to run clang static code analysis on the master and =
maint branch
>>>=20
>>> Signed-off-by: SiddharthaMishra <sidm1999@gmail.com>
>>> ---
>>> .travis.yml               | 17 ++++++++++++++++-
>>> ci/run-static-analysis.sh |  9 ++++++++-
>>> 2 files changed, 24 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 4684b3f4f..9b891d182 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -48,7 +48,7 @@ matrix:
>>>      before_install:
>>>      before_script:
>>>      script: ci/run-linux32-docker.sh
>>> -    - env: jobname=3DStaticAnalysis
>>> +    - env: jobname=3DCocciStaticAnalysis
>>>      os: linux
>>>      compiler:
>>>      addons:
>>> @@ -59,6 +59,21 @@ matrix:
>>>      before_script:
>>>      script: ci/run-static-analysis.sh
>>>      after_failure:
>>> +    - if: branch IN (master, maint)
>>> +      env: jobname=3DClangStaticAnalysis
>>> +      os: linux
>>> +      compiler:
>>> +      add_ons:
>>> +        apt:
>>> +          sources:
>>> +          - ubuntu-toolchain-r-test
>>> +          - llvm-toolchain-trusty
>>> +          packages:
>>> +          - clang
>>> +      before_install:
>>> +      before_script:
>>> +      script: ci/run-static-analysis.sh
>>> +      after_failure:
>>>    - env: jobname=3DDocumentation
>>>      os: linux
>>>      compiler:
>>> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
>>> index fe4ee4e06..6ae032f54 100755
>>> --- a/ci/run-static-analysis.sh
>>> +++ b/ci/run-static-analysis.sh
>>> @@ -5,6 +5,13 @@
>>>=20
>>> . ${0%/*}/lib-travisci.sh
>>>=20
>>> -make coccicheck
>>> +case "$jobname" in
>>> +ClangStaticAnalysis)
>>> +     scan-build -analyze-headers --status-bugs make
>>> +     ;;
>>> +CocciStaticAnalysis)
>>> +     make coccicheck
>>> +     ;;
>>> +esac
>>>=20
>>> save_good_tree
>>> --
>>> 2.16.2.248.ge2408a6f7.dirty
>>>=20
>>=20


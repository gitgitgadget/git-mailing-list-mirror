Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0CA120899
	for <e@80x24.org>; Tue, 22 Aug 2017 09:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932429AbdHVJ07 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 05:26:59 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbdHVJ06 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 05:26:58 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MG9cl-1doiYy1vM7-00F9JJ; Tue, 22 Aug 2017 11:26:55 +0200
Subject: Re: [PATCH v2 1/3] Documentation/git-merge: explain --continue
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, hIpPy <hippy2981@gmail.com>
References: <cover.1503319519.git.git@grubix.eu>
 <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
 <ddd9c06813f8e2e9d8160f2ed965e728190bc573.1503319519.git.git@grubix.eu>
 <CAN0heSrG7ackEW1BMpadNnPKSUCXATbxfUykcpppC6-Y2OCWJQ@mail.gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <8e8c8cdc-cad8-550d-9669-3f078f0d77d1@grubix.eu>
Date:   Tue, 22 Aug 2017 11:26:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSrG7ackEW1BMpadNnPKSUCXATbxfUykcpppC6-Y2OCWJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:pXhCSq0yUI/2Rpsu48awp2Ab7GaJ4Vso+INS41NanylMW7ISN6k
 BWCh1pd22p3rE9Qp+lBEIlXhRdzmxcP0dCbmtKOxIXZJ2WLGFeQcNsIuVb7y6GpNeHH0dFl
 jvT0HC1W+XPXFQmb+AGuML+OHWA9npGGQrPLOV9wOlPFx0RLuIvEKARUGMWUzXN4J7fKDwb
 Tjssh07bx6cUw1rqjcatQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UK5anDAirpQ=:kWE7xuV09HlBBwTnUELqNq
 PfrIw/eq/QeXm6CJ9nY/svG6uiv7i6AhAwZviWyxnUaZGhoVjMOmMH0ZpD6PmV9oaalGS0FM3
 ZpT9SPjQXw8UrHDTGq2uU+3VrBSU2SZJQXuVEx6v5CeCVd41ntyuv9/nK7Gb1Dlq+x9+76P8r
 7K5YGibpTAHoNzdHeINpNzNL30d0HjbuezpNUCTvPGvJBBlT9Ubn5/2SzeB27tz2F/bEIXrCm
 pvOGde+3PXJNBPsp76EdqbYfmzhlWDYBajgrj0b0KoI9DHCU3E8v4xXaCpJsrXUB+KYNqIwJK
 WQeP4hG2lOZ2ols6eOxF3lRT6QO/nqbnh2cfqMrl3nlvrBPOZDfDDr2NaopaJpaR8cwgH1enm
 qeHeg3t6CYnXbFzCmlJgURFnLNqIB9ILdhLGgtAkzgk+qVPVQ+8HviUYylguz4Kga7hQ1FIq3
 EAiHRCwCgg5DE1efJ3CHHCjfLsW4peoFeqxCpAtpSYsmMKKR6Sxqh+aqOOWmL77+JKsQwAG6Z
 nZRTZ8Te9d0sBY/dqFRHEjs45iUPgrBSotr7c9VMk+EBzNIhELy+DyRfJSfau+fg7l0Sp/yKg
 qtk/HNj2RteOilWOQa/w8A/JXldrKwXdb4lgiz44zguzJKsjEhSTQhYJ0NebjuO1ZrTOmF68/
 kSlKVtQ3xwSyCroqdr9/qo4MryLgmRYynpPGoGY+zJex6IGYEDGjBoSZVs9kg5FrX/L4XPgCO
 msoAR3htS4D2LhDO+zRRyac5Mu+9HNBvub4TrBgeJxTipsmM363PfwA4h5U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren venit, vidit, dixit 21.08.2017 18:43:
> On 21 August 2017 at 14:53, Michael J Gruber <git@grubix.eu> wrote:
>> Currently, 'git merge --continue' is mentioned but not explained.
>>
>> Explain it.
>>
>> Signed-off-by: Michael J Gruber <git@grubix.eu>
>> ---
>>  Documentation/git-merge.txt | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
>> index 6b308ab6d0..615e6bacde 100644
>> --- a/Documentation/git-merge.txt
>> +++ b/Documentation/git-merge.txt
>> @@ -288,7 +288,10 @@ After seeing a conflict, you can do two things:
>>
>>   * Resolve the conflicts.  Git will mark the conflicts in
>>     the working tree.  Edit the files into shape and
>> -   'git add' them to the index.  Use 'git commit' to seal the deal.
>> +   'git add' them to the index.  Use 'git commit' or
>> +   'git merge --continue' to seal the deal. The latter command
>> +   checks whether there is a (interrupted) merge in progress
>> +   before calling 'git commit'.
>>
>>  You can work through the conflict with a number of tools:
> 
> There are actually two things going on here. First, this mentions git
> merge --continue. Second, it explains what that command does. But the
> latter is done earlier (not exactly like here, but still).

I didn't see that explained in the man page at all - on the contrary, I
only saw a forward reference (see section...), but then only an
explanation of what "resolving" means (including the "git commit"-step).
It is unclear to me from the man page which steps of "resolving" the
command "git merge --continue" does - you could think it does "git
commit -a", for example.

> When git merge --continue originally appeared, this part of the docs was
> discussed briefly. Maybe interesting:
> 
> https://public-inbox.org/git/xmqq60mn671x.fsf@gitster.mtv.corp.google.com/
> 
> Martin
> 

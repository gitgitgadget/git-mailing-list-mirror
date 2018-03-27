Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FDB51F404
	for <e@80x24.org>; Tue, 27 Mar 2018 15:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeC0PDB (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 11:03:01 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36306 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeC0PDA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 11:03:00 -0400
Received: by mail-ua0-f178.google.com with SMTP id v9so14523983uaj.3
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LOW4vBJg1/tGSy5R+Kr0WPzNc4WJk8534vplJgnVHms=;
        b=kWSNGCnthGru5SBdWIxKAg6vU9qeWetj/7Van8TlSJ44m5aPm8SJl0t96JfhINzuEy
         dbogDpio8iot0X93OH28UVt2QE/JGti3l0h57Rr7nHfqOOw/SqpOux6QjZrzAkhBPMFD
         kS5G6cz+KikV4oCA/aB4qm/0inhdLlGT34MMo/zM9GPzxZK6XsJUMz4S0ObqZHi0TWcy
         oMiVJxItgR1erqkBH3+tdmRMwxG8CRGcxJcTiVrZofrTftmqcjZgX+PZidrip1J7dSMF
         y8baUgnPY6QS7QjwbeuepIDo54oYvKln8Zpbd+x+Mmf2JAY1X6UYVqgmrXPJ+Y2xUFkT
         cQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LOW4vBJg1/tGSy5R+Kr0WPzNc4WJk8534vplJgnVHms=;
        b=CLWFDw3VO/tIIPRncIxqz8dvhg7b1Tb8tRvn0JV+QH5CoZNC0Brczxdef5l9s+QD4d
         PrGIoyD2cBDLiOCTchKvKLYiwG2rx6wZBlKjvHcRwIS0rlqY5RThQCBZM570xrFbGTMy
         T28BiHbXrrwIlnXLkXFbK7x7fI3bKCBzkOYNc8iH7cYzZeFJbPDS8tRat7ucZ9UdVyER
         ACVtBWP4uUzlc30jjqvjXa63SQAavz9bQjmvc8pzKuZ2pCzlwCm9yJ0ln/1BdYwl6Iu2
         oORnSieCSEUbr571aC3XtMie02bj3oEi1DsRsaGGu1SFAQc54rkSkH3R1ZDKdR7U/OnA
         du8A==
X-Gm-Message-State: AElRT7HraYE8mDKrZ/0r2MfWOiVy4GPbhFxlm+YGzirNi2ansVz/GaEj
        GkRsu99iknH4gjcGeSerL66Nl4f71mIKHF3H8gY=
X-Google-Smtp-Source: AG47ELtlOPxysKeeCQL4TGjlax/JFirTpOYKUNuB+fkXiHv/iEczv8q8Qs84gTs3YiBLSSvKowmqoNSdi8n0lMvuMx8=
X-Received: by 10.176.36.69 with SMTP id g5mr25976721uan.196.1522162980121;
 Tue, 27 Mar 2018 08:03:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Tue, 27 Mar 2018 08:02:59 -0700 (PDT)
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 27 Mar 2018 17:02:59 +0200
Message-ID: <CAM0VKjmRiOjb6Jsx1XCfGWe_9+AqJGeBvAWt2sM1_rJArdEVQA@mail.gmail.com>
Subject: Windows build on Travis CI (was: Re: [PATCH v2 01/36] t/helper: add
 an empty test-tool program)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 3:57 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi G=C3=A1bor,
>
> On Tue, 27 Mar 2018, SZEDER G=C3=A1bor wrote:
>
>> On Tue, Mar 27, 2018 at 12:14 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > However, it seems that something is off, as
>> > ba5bec9589e9eefe2446044657963e25b7c8d88e is reported as fine on Window=
s:
>> > https://travis-ci.org/git/git/jobs/358260023 (while there is clearly a=
 red
>> > X next to that commit in
>> > https://github.com/git/git/commits/ba5bec9589e9eefe2446044657963e25b7c=
8d88e,
>> > that X is due to a hiccup on macOS).
>> >
>> > It seems that the good-trees feature for Travis does not quite work as
>> > intended. G=C3=A1bor?
>>
>> AFAICT it works as expected.
>>
>> When a build job encounters a commit with a tree that has previously
>> been built and tested successfully, then first it says so, like this:
>>
>>   https://travis-ci.org/szeder/git/jobs/347295038#L635
>
> But what if it has not been built successfully (as was the case here)?
> This very commit that is "succeeding" on Travis fails to compile on
> Windows.

Then why has the GfW web app reported success?

  https://travis-ci.org/git/git/jobs/358260023#L512

>> and then skips the rest of the build job (see the 'exit 0' a few lines
>> later).
>>
>> In case of this Windows build job we haven't seen this tree yet:
>>
>>   https://travis-ci.org/git/git/jobs/358260023#L467
>>
>> so the build job continues as usual (see the 'test -z Windows' two lines
>> later).
>>
>> Unfortunately, I have no idea about how the rest of the Windows build
>> job is supposed to work...
>
> Maybe Travis timed out waiting for the result, and marked it as a success=
?

This Windows build ran for 9 min 27 sec, i.e. not long enough for a
timeout on Travis CI.  (OTOH, clearly not long enough to build Git and
run the test suite on Windows, I know.)

BTW, a timeouted build job is marked as "errored" and the timeout is
mentioned in its trace log:

  https://travis-ci.org/git/git/jobs/331669291#L509

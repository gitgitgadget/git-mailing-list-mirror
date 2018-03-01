Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1C21F576
	for <e@80x24.org>; Thu,  1 Mar 2018 08:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935164AbeCAIRB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 03:17:01 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:39291 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934985AbeCAIRA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 03:17:00 -0500
Received: by mail-io0-f179.google.com with SMTP id b34so6236451ioj.6
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 00:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ag0Z8tSshOe2trEwCGze8w6quEaJfKeLA3VCogFe3mE=;
        b=N4lw/g/LqoVgLghrRFcdbN8uz+Wpy4xYjqNomx1tQ+2eSugosSKpmmFmYki8JFJWBN
         GLpjHMSc1qLtuf0SjaC45E66FfgWGBx24sTHg9zsWtYJFa+MAariMRmapRf9tIP87HBx
         tJO9oqHl9ERS/ZRV64q4Ko/Ykm/aQ/crMiUXKSAgpiiSp3NkmA/O546kxFSy0wkmkxHF
         /zeBONrvQ1D4OkYIwWzBtxlnEg5s3gGZ4EOs7wQy/XLW7vZPwzIerD+d1da+3szpMZXn
         8fKDq+QwJ2+BORkSOKW5IWNEvVZqQYVx08f7CbgMdzHfzqPK1hbtdRhTLgMOiDUY+KwJ
         h2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ag0Z8tSshOe2trEwCGze8w6quEaJfKeLA3VCogFe3mE=;
        b=AUtnwiGNovQXkfCl/GSrAWzvxhpYThyzMZLj6uaL8AZtNG/RySBIcxZV9wxiSGa2dO
         sEJaUOpWOkGwOUCpgKcEcBGunJFWUpzp7idbsGuMc13OXwYPbwHlfAzRxTkMCA3tAj7H
         kftGcwoc4sdviBocwCbPy3ushnlSXdg0OzenakcnWjYZLsS3/6jm2LSRHZkfJ4itKgZA
         P/NreP3TAnYCA4DwKKgMYYwrPQquQb7d+0XjnJMYngBxdtpfcYCSKI6pv7NP4J+e5TWG
         KxrI9VSuHRG2vE5t1j4sAOB/Am9tYg3DI+qIOyXRocMOWIiX+mPMosapYwWMCk9zvh0s
         /m5w==
X-Gm-Message-State: AElRT7FzejiwT4Gl6qkb0RahNhJ6ZpXNMPjyJEARfjZrPdiHkXruIwhW
        ee3Q94hNQ5IJ+BVGqsRh6gi+j64/srTy0Qi9/xs=
X-Google-Smtp-Source: AG47ELuwsiUSXUYtl2lyEJAiGS8CPkF+xsHoM4tjap+5bAGx9+zNIXfRAibqmLiP3ZqwLd9UlmNsv1AeGbcIDtMsW98=
X-Received: by 10.107.13.73 with SMTP id 70mr1003666ion.7.1519892219648; Thu,
 01 Mar 2018 00:16:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.137.144 with HTTP; Thu, 1 Mar 2018 00:16:58 -0800 (PST)
In-Reply-To: <20180301073629.GC31079@sigill.intra.peff.net>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr>
 <20180228074918.GA32127@sigill.intra.peff.net> <000501d3b0a4$29162a80$7b427f80$@nexbridge.com>
 <CANgJU+VYkmUhJT=CHQ4HTqoV4gWhr9P4-65BfrY-RWgwJJhEUA@mail.gmail.com> <20180301073629.GC31079@sigill.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 1 Mar 2018 09:16:58 +0100
Message-ID: <CANgJU+XiT6iuABL=95mGvdEbV7xMK6-mwOs4OO1Apvyp9KGqOA@mail.gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
To:     Jeff King <peff@peff.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Git <git@vger.kernel.org>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1 March 2018 at 08:36, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 28, 2018 at 05:51:14PM +0100, demerphq wrote:
>
>> I would look into putting it into a module and then using the PERL5OPT
>> environment var to have it loaded automagically in any of your perl
>> scripts.
>>
>> For instance if you put that code into a module called Git/DieTrap.pm
>>
>> then you could do:
>>
>> PERL5OPT=-MGit::DieTrap
>>
>> In your test setup code assuming you have some. Then you don't need to
>> change any of your scripts just the test runner framework.
>
> That's a clever trick.
>
> It's not clear to me though if we just want to tweak the programs run in
> the test scripts in order to get test_must_fail to stop complaining, or
> if we consider the unusual exit codes from our perl-based Git programs
> to be an error that should be fixed for real use, too.

Yeah, that is a decision you guys need to make, I am not familiar
enough with the issues to make any useful comment.

But I wanted to say that I will bring this subject up on perl5porters,
the exit code triggered by a die is a regular cause of trouble for
more than just you guys, and maybe we can get it changed for the
future. Nevertheless even if there was consensus it can be changed it
will take years before it is widely distributed enough to be useful to
you. :-(

Ill be bold and say sorry on the behalf of the perl committers for
this. Perl is so old sometimes things that used to make sense don't
make sense anymore.

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"

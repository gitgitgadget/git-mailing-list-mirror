Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090011FAE2
	for <e@80x24.org>; Wed, 28 Feb 2018 16:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeB1QvT (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 11:51:19 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:38750 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbeB1QvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 11:51:16 -0500
Received: by mail-it0-f48.google.com with SMTP id j7so4304892ita.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 08:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rtDUfkAzrNADQRFXEoqbMhkCEBDdsWM4Bn2vXYsj7mg=;
        b=ENj3axQzkXksKoMARNvYWApTJMPhvxuNg8D6QVmQk1r8iMiQk3FUFyFFLcdZ/Een5g
         wZ0S6NIg0B74UCwM4h1ZtlZKYKKseV0VENZI5kAFeODVffWHimCs1wINgKfPJAWId1WL
         OlFZ7FXU+2At8QaYzy3EFrHNS5eh2ugktcmWPV1A4/Oo1xpw+N4RGdsCDcnQj/Bs3NE+
         LjlOfN7PelFV6gQLTkCyUSN7VeaEYFQ260pJxfvn1L2p3o4sp/0T2uoi1KBlRN8tr2NC
         dSDAHAjER/+B/TvF2xUqsoS5kmq/rl1GmfEXixhuODNMEqpH8mW+sTNt4Kc4EJ8YQVbS
         gF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rtDUfkAzrNADQRFXEoqbMhkCEBDdsWM4Bn2vXYsj7mg=;
        b=tTAVltBJzEW2TEWTh7KhjADzyyTKxgRgORFwDz2e22BD/XH6JCwVoadakxlJUGyrsY
         BbZM7zjky0VXTG5pEjjFxLwfWoiIYWAXSmTuI9Gd9JteRI7Bib9mJC5gNK5zO/PsTk7s
         clQFBUNoESHPijtA6WkA8ZxT4ZUc/XHbiL/VrNyPeEEY8zPstQtnjw9RaoZojtkb3rmZ
         +GKrCF9PmqiGpuEDfjV1DIc+8klzJWBX4FwNwKxcN1QVrNI+bGeivjX3bzJ3h+Q/ojoV
         hbsYxOPnjyRTm7QKXisEagVBMsfNDgsKKeM2yaS9UtrfQUpT0mgNDSVxPU/qkSq2fJS1
         9VYw==
X-Gm-Message-State: APf1xPCvJLtfhgxM1/OetqIdwW03vxJQtJF4EU/zf3WzhOQD3pI81kDQ
        tdtrNxh97TVD1mm0vAdIzmKW/ho6ZVseopiAAlk=
X-Google-Smtp-Source: AG47ELvRZQfBJymhdx7ESG/nFsW8gRlvb3gkmc97R7nj/Te2hPxO6ts1PGW6XjP8l/4BNjzj/I/8obKfrG17MwFy064=
X-Received: by 10.36.33.17 with SMTP id e17mr16766813ita.44.1519836675542;
 Wed, 28 Feb 2018 08:51:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.137.144 with HTTP; Wed, 28 Feb 2018 08:51:14 -0800 (PST)
In-Reply-To: <000501d3b0a4$29162a80$7b427f80$@nexbridge.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr>
 <20180228074918.GA32127@sigill.intra.peff.net> <000501d3b0a4$29162a80$7b427f80$@nexbridge.com>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 28 Feb 2018 17:51:14 +0100
Message-ID: <CANgJU+VYkmUhJT=CHQ4HTqoV4gWhr9P4-65BfrY-RWgwJJhEUA@mail.gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git <git@vger.kernel.org>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 February 2018 at 15:55, Randall S. Becker <rsbecker@nexbridge.com> wrote:
> On February 28, 2018 2:49 AM, Peff wrote:
>> On Wed, Feb 28, 2018 at 07:42:51AM +0000, Eric Wong wrote:
>>
>> > > > >  a) We could override the meaning of die() in Git.pm.  This feels
>> > > > >     ugly but if it works, it would be a very small patch.
>> > > >
>> > > > Unlikely to work since I think we use eval {} to trap exceptions
>> > > > from die.
>> > > >
>> > > > >  b) We could forbid use of die() and use some git_die() instead (but
>> > > > >     with a better name) for our own error handling.
>> > > >
>> > > > Call sites may be dual-use: "die" can either be caught by an eval
>> > > > or used to show an error message to the user.
>> >
>> > <snip>
>> >
>> > > > >  d) We could wrap each command in an eval {...} block to convert the
>> > > > >     result from die() to exit 128.
>> > > >
>> > > > I prefer option d)
>> > >
>> > > FWIW, I agree with all of that. You can do (d) without an enclosing
>> > > eval block by just hooking the __DIE__ handler, like:
>> > >
>> > > $SIG{__DIE__} = sub {
>> > >   print STDERR "fatal: @_\n";
>> > >   exit 128;
>> > > };
>> >
>> > Looks like it has the same problems I pointed out with a) and b).
>>
>> You're right. I cut down my example too much and dropped the necessary
>> eval magic. Try this:
>>
>> -- >8 --
>> SIG{__DIE__} = sub {
>>   CORE::die @_ if $^S || !defined($^S);
>>   print STDERR "fatal: @_";
>>   exit 128;
>> };
>>
>> eval {
>>   die "inside eval";
>> };
>> print "eval status: $@" if $@;
>>
>> die "outside eval";
>> -- 8< --
>>
>> Running that should produce:
>>
>> $ perl foo.pl; echo $?
>> eval status: inside eval at foo.pl line 8.
>> fatal: outside eval at foo.pl line 12.
>> 128
>>
>> It may be getting a little too black-magic, though. Embedding in an eval is at
>> least straightforward, if a bit more invasive.
>
> I like this solution. The $64K question for me is how (a.k.a. where) to instrument this broadly instead of in each perl fragment in the test suite.  The code:
>
> $SIG{__DIE__} = sub {
>   CORE::die @_ if $^S || !defined($^S);
>   print STDERR "fatal: @_";
>   exit 128;
> };
>
> eval {
>   die "inside eval";
> };
>
> print "eval status: $@" if $@;
>
> die "outside eval";
>
> as tested above, in NonStop results in an exit code of 128 whether run from a script or from stdin (a good thing). I'm happy to do the heavy lifting on this, but  a bit more direction as to the implementation would help.

I would look into putting it into a module and then using the PERL5OPT
environment var to have it loaded automagically in any of your perl
scripts.

For instance if you put that code into a module called Git/DieTrap.pm

then you could do:

PERL5OPT=-MGit::DieTrap

In your test setup code assuming you have some. Then you don't need to
change any of your scripts just the test runner framework.

Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E925F1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 17:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeB1RTN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 12:19:13 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:37577 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752887AbeB1RTK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 12:19:10 -0500
Received: by mail-io0-f172.google.com with SMTP id d71so4017815iog.4
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 09:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2LMDU5JP0IOi3h43zkHwY99Qws4KUdhAdNcmd/x9b7Y=;
        b=cvvBZe6/3GSfeA3YGDjo7eFesWJSw0gaNH3we+2gY5MYspWDZwCfRtMOmRvQxjbrcm
         d2PLUeSLtTqJOLdUuDfXLqLYqt8ROlhETMqy2o23EDDjUuYwOR0FrlF2VpzOAcTQKJYz
         JitLcKDPi57RutcXPt/8gNT115CtzkkfdYUj2OpSeY7viu46BsRiqX0OChpJ8bMSspix
         tYyAz02oBFh1JMyc4RnDS7uoQJsueHl2/CHWV9DeFkcp84lNKncGZZnszN43q+LSC7r5
         gPw1uMILixHvhGhhBZBSVFoKJRbDBXqO5ODDT9aimvw6Fu0mcqMfaxCXUq2CI7jLZ05S
         5sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2LMDU5JP0IOi3h43zkHwY99Qws4KUdhAdNcmd/x9b7Y=;
        b=OxLXEMPcfZmOIOWXmSMp6z9e+PbvX0/+1Fg2Xq8InSXKlDO/JoNZO29mDEKxjwO/Px
         XSG0fx3dboPzrA8/PaV1MDmpoaTkHI6KhNwGhqTOA6LEQ8TthuToWqUTM6RJqjbe2339
         mzgec50Bq/dHmeXZYrmw4sFlrlv5HjdDLpTiagox4fDnK4U3nYJupLAmQwuo44Yj2GFT
         dyFWRClRDimDXaHv9RkPPIiXkE/jpoVPEgXc41ZGNn4o3n/ApWN2RsZvCNAGClb3dvv/
         4vs5fITw7feRwSjXb+GslUaW/pIX4EChUgWrAN2IXSZgG+e8wq/zXxaR7Ivcre8Y4b48
         6gOw==
X-Gm-Message-State: APf1xPD63XsWOh4rt2L2EkQj+y+Uh84EBkvy3vWJA2VKwljLe2CdD4Nu
        eMG2UDhFJrWjPN30mvHhj1RSpAKHTvph3QhnZQrj/bB2
X-Google-Smtp-Source: AG47ELsFhoXfgEDq0gggb11j5+R8hCuljgbLHT2AeZMUgYJf4nymdQsNPB6j/oY0yhCR7AatPOKn2/x/dIORqeYdn/M=
X-Received: by 10.107.48.209 with SMTP id w200mr20416271iow.128.1519838349722;
 Wed, 28 Feb 2018 09:19:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.137.144 with HTTP; Wed, 28 Feb 2018 09:19:09 -0800 (PST)
In-Reply-To: <003901d3b0b7$0a144280$1e3cc780$@nexbridge.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr>
 <20180228074918.GA32127@sigill.intra.peff.net> <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com>
 <003901d3b0b7$0a144280$1e3cc780$@nexbridge.com>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 28 Feb 2018 18:19:09 +0100
Message-ID: <CANgJU+WFKqou=ZXcdr8V_ST=opHSBm9ksEVowxRB7o7DDEmuvg@mail.gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git <git@vger.kernel.org>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 February 2018 at 18:10, Randall S. Becker <rsbecker@nexbridge.com> wr=
ote:
> On February 28, 2018 11:46 AM, demerphq wrote:
>> On 28 February 2018 at 08:49, Jeff King <peff@peff.net> wrote:
>> > On Wed, Feb 28, 2018 at 07:42:51AM +0000, Eric Wong wrote:
>> >
>> >> > > >  a) We could override the meaning of die() in Git.pm.  This fee=
ls
>> >> > > >     ugly but if it works, it would be a very small patch.
>> >> > >
>> >> > > Unlikely to work since I think we use eval {} to trap exceptions
>> >> > > from die.
>> >> > >
>> >> > > >  b) We could forbid use of die() and use some git_die() instead=
 (but
>> >> > > >     with a better name) for our own error handling.
>> >> > >
>> >> > > Call sites may be dual-use: "die" can either be caught by an eval
>> >> > > or used to show an error message to the user.
>> >>
>> >> <snip>
>> >>
>> >> > > >  d) We could wrap each command in an eval {...} block to conver=
t the
>> >> > > >     result from die() to exit 128.
>> >> > >
>> >> > > I prefer option d)
>> >> >
>> >> > FWIW, I agree with all of that. You can do (d) without an enclosing
>> >> > eval block by just hooking the __DIE__ handler, like:
>> >> >
>> >> > $SIG{__DIE__} =3D sub {
>> >> >   print STDERR "fatal: @_\n";
>> >> >   exit 128;
>> >> > };
>> >>
>> >> Looks like it has the same problems I pointed out with a) and b).
>> >
>> > You're right. I cut down my example too much and dropped the necessary
>> > eval magic. Try this:
>> >
>> > -- >8 --
>> > SIG{__DIE__} =3D sub {
>> >   CORE::die @_ if $^S || !defined($^S);
>> >   print STDERR "fatal: @_";
>> >   exit 128;
>> > };
>>
>> FWIW, this doesn't need to use CORE::die like that unless you have code =
that
>> overrides die() or CORE::GLOBAL::die, which would be pretty unusual.
>>
>> die() within $SIG{__DIE__} is special cased not to trigger $SIG{__DIE__}
>> again.
>>
>> Of course it doesn't hurt, but it might make a perl hacker do a double t=
ake
>> why you are doing it. Maybe add a comment like
>>
>> # using CORE::die to armor against overridden die()
>
> The problem is actually in git code in its test suite that uses perl inli=
ne, not in my test code itself. The difficulty I'm having is placing this a=
ppropriate so that the signal handler gets used throughout the test suite i=
ncluding in the perl -e invocations. This is more a lack of my own understa=
nding of plumbing of git test framework rather than of using or coding perl=
.

Did you reply to the wrong mail?

Create a file like:

.../Git/DieTrap.pm

which would look like  this:

package Git::DieTrap;
use strict;
use warnings;

SIG{__DIE__} =3D sub {
   CORE::die @_ if $^S || !defined($^S);
   print STDERR "fatal: @_";
   exit 128;
};

1;
__END__

and then you would do:

export PERL5OPT=3D-MGit::DieTrap

before executing any tests. ANY use of perl from that point on will
behave as though it has:

use Git::DieTrap;

at the top of the script, be it a -e, or any other way that Perl code
is executed.

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"

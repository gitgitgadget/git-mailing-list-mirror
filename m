Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB3301FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 18:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbdFGSFB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 14:05:01 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35747 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdFGSFA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 14:05:00 -0400
Received: by mail-it0-f43.google.com with SMTP id m62so114856613itc.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mtNXZWrjgtjspz3kpAzJQqcjMTi8fZjyZ7Hrs+rOHds=;
        b=p7bholPUA8vQFEm+yGn/BJS602xYCQvieePXjRrSFCHsEymmexzuGTI9FWhQqMqqcg
         Rub77KgoMAxcP/xmPnM1n+eCmui4A/i19VtPeLGLhhuMs3GEmnpj9jxcfTJqEMxB2JXf
         BfVYY9OVvnvMR3KVx+F0Pz4AZXMACb6tXfy3re6gw17wse/YtbBFPkKcPjckQ2uxiHrB
         8RukuiFBCSCfAel3DLTkpAGhmGGM63Q7ZEKQ7EqlxcxXzrW79YDJAa8LAqpywS8QZxAB
         Zbjcl6vGDZrBueMooMjMSJupkozIbfPcmcmGC66w8Jn4M6gV52wDd9lf88ZOTSFYTSIQ
         nTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mtNXZWrjgtjspz3kpAzJQqcjMTi8fZjyZ7Hrs+rOHds=;
        b=lpv1Ed4H52D0qX/i1vgCo9rAJS2gwEu5Vxwmm7VsigWHyfo+kneC6EbjZ14Eq5jGmk
         mtPNWf4ERS8svM8PDU+bV8CGOzRL5qfKwqXis0VGmM/U9L+HH7frb/ATkpgnrNeCtKjl
         U7qpP2cUQvqw7g471sGwbP7rQ/jAB0nB6fp/8QLlvRbrmC2hv0cDpU5N9Tpr8hz8VHae
         HqgJkgG38kol0o5vRsuqEMNEQ/JlV737iwFqA2Xg6P1O3lORWWj8DBJdI0bBTrtZSUUF
         Mz/gsaMRM6DSwiNvop/6/giNadeVSx5dO8XWg5WHpyEcCxZxwl8pVzaIgc7tNIr+9bxK
         DOZg==
X-Gm-Message-State: AODbwcDuBRI0tmzXYi+UngGiAsCNXbmGdN9eCOdLbcsKbtsHgiMLsRoJ
        93YmH48Q55sERhkpJTk4iNUxx/w2Jri1l7E=
X-Received: by 10.36.212.71 with SMTP id x68mr692422itg.67.1496858699731; Wed,
 07 Jun 2017 11:04:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.135.7 with HTTP; Wed, 7 Jun 2017 11:04:58 -0700 (PDT)
In-Reply-To: <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com>
References: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
 <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com> <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com>
From:   Liam Breck <liam@networkimprov.net>
Date:   Wed, 7 Jun 2017 11:04:58 -0700
X-Google-Sender-Auth: bxWBfyzhoBocud00qfanZuLQVn4
Message-ID: <CAKvHMgRpS3AgRAm1ukH18kX5jNF6PEU8YTsq7mQ36myQgRe=Pw@mail.gmail.com>
Subject: Re: send-email: Net::SMTP::SSL failure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your help!

On Wed, Jun 7, 2017 at 10:16 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Jun 7, 2017 at 7:00 PM, Liam Breck <liam@networkimprov.net> wrote=
:
>> On Tue, Jun 6, 2017 at 10:47 PM, Liam Breck <liam@networkimprov.net> wro=
te:
>>>
>>> This is configured to send via a gmail account
>>> git send-email --to-cover --cc-cover <patch-list>
>>>
>>> I See
>>> Attempt to reload IO/Socket/SSL.pm aborted.
>>> Compilation failed in require at
>>> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
>>> BEGIN failed--compilation aborted at
>>> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
>>> Compilation failed in require at /usr/lib/git-core/git-send-email line =
1386.
>>> fatal: 'send-email' appears to be a git command, but we were not
>>> able to execute it. Maybe git-send-email is broken?
>>>
>>> Net/SMTP/SSL.pm v1.04
>>>
>>> perl v5.26.0
>>>
>>> Seen in git 2.11.1, 2.12.2, 2.13.0, 2.13.1 on Arch Linux
>>
>> Also fails with perl 5.24.1 & 5.24.0
>>
>> Last working config was git 2.9.3 on perl 5.24.1
>>
>> The relevant code from git-send-email is:
>>
>>             require Net::SMTP;
>>             $smtp_domain ||=3D maildomain();
>>             $smtp_server_port ||=3D 25;
>>             $smtp ||=3D Net::SMTP->new($smtp_server,
>>                          Hello =3D> $smtp_domain,
>>                          Debug =3D> $debug_net_smtp,
>>                          Port =3D> $smtp_server_port);
>>             if ($smtp_encryption eq 'tls' && $smtp) {
>>                 require Net::SMTP::SSL;
>>                 $smtp->command('STARTTLS');
>>
>> I really wish git bundled its non-core perl libs...
>
> What's the output from just:
>
>     perl -MNet::SMTP -we1

No output, exit code 0, however...

$ perl -MIO::Socket::SSL -we1
Can't load '/usr/lib/perl5/site_perl/auto/Net/SSLeay/SSLeay.so' for
module Net::SSLeay: libssl.so.1.0.0: cannot open shared object file:
No such file or directory at /usr/lib/perl5/core_perl/DynaLoader.pm
line 193.
at /usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
Compilation failed in require at
/usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
BEGIN failed--compilation aborted at
/usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
Compilation failed in require.
BEGIN failed--compilation aborted.

I don't have {vendor,site}_perl/auto/ tho I have the package for
ssleay installed.

Since which git release was that required?


> I have not looked deeply at this, but the error you're getting means
> "we tried to load it before and failed, and here you are trying
> again".
>
> This is almost definitely due to this line in git-send-email:
>
>         if (eval { require Net::SMTP; 1 }) {
>
> And more generally, this code is all buggy:
>
>     4 matches for "eval.*require" in buffer: git-send-email.perl
>     153:my $have_email_valid =3D eval { require Email::Valid; 1 };
>     154:my $have_mail_address =3D eval { require Mail::Address; 1 };
>    1118:        if (eval { require Net::Domain; 1 }) {
>    1129:        if (eval { require Net::SMTP; 1 }) {
>
> Well, "buggy" in the sense that we're just happy-go-lucky trying to
> load these modules, and if they have an error we don't report it, then
> when we try to load them again perl just emits a generic error saying
> you're trying to require() something that already failed somewhere
> before, a minimal test case for that is:
>
>     $ cat /tmp/Fails.pm
>     package Fails;
>     die "oh noes";
>     $ perl -I/tmp -we 'eval { require Fails }; require Fails'
>     Attempt to reload Fails.pm aborted.
>     Compilation failed in require at -e line 1.
>
> Whereas what we really want to do is some variant of:
>
>     $ perl -MData::Dumper -I/tmp -we 'eval { require Fails } or warn
> $@; require Fails'
>     oh noes at /tmp/Fails.pm line 2.
>     Compilation failed in require at -e line 1.
>     Attempt to reload Fails.pm aborted.
>     Compilation failed in require at -e line 1.
>
> Or even the more adventerous, this can have some bad side-effects with
> some libraries (you lie to perl saying you haven't seen it before),
> but I doubt Net::SMTP cares much, particularly when we're just about
> to report an error:
>
>     $ perl -MData::Dumper -I/tmp -we 'eval { require Fails } or do {
> delete $INC{"Fails.pm"} }; require Fails'
>     oh noes at /tmp/Fails.pm line 2.
>     Compilation failed in require at -e line 1.

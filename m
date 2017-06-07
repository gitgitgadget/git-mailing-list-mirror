Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54C421FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 19:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbdFGTa3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 15:30:29 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35292 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdFGTa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 15:30:28 -0400
Received: by mail-io0-f171.google.com with SMTP id k93so11386404ioi.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cfryWuiDncRv0H1yj7G1ZmSzKlmB4g2vFRrXYpTieM8=;
        b=Gl9nTM5pDuIfMXJCqd++IkaXircnyIIjjvGXw5yZFuu+hVVIVVsIvphk3ONZl32/Y2
         D88gzwul9mICm1IXD4u1i8SPF4Lq5CvRaplhFdVY7k4e9JniLYNW88UDRoQLYITOboRK
         tHe6C1qgw6OZYHKDlYGAQoRJWEztFZv2H9Umal7hO75qAfjSE12zH9EWqt9ZTr7+aGQJ
         1GUwLmhRxQ4vJaUyuPu+uZIxBARZU4l3GVHp6ifm2cWHMW5TaQXKKcOnOrnkFDmGOVmo
         HVPYddoD/6VsiUvjd/XBEqF7AkzzVZUsm2AKljhFYvHgBOIFA/iePa5C05rQaswB97sN
         9sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cfryWuiDncRv0H1yj7G1ZmSzKlmB4g2vFRrXYpTieM8=;
        b=R6D19sot4XKrwsLqke46krrLCOrI43DJ4pcWaJZz+IWQVQc8f9I+8okLBnawc0UbrN
         R2sN8+cdrJTXPw6on85iVBp4MXQ3joJaq+LItC7AOh2vvJTRnsD/gFE7SnG7UtteoCMl
         QL19VYGGEuvohsEzzLbPLHN5c95k8yuBqDcp7vtj1ivSO2IGVVdwCJopcxvjhoXNa/En
         X+Z/HyxPDVoj7BG7RYYqu57BD7OyEAmoBthxUU0jAqx3Aiw7wVdwQr2XCTQn5acsAkZQ
         PK/EcHCgKh/kcWMo1d++AjRB/2OWxRwAAic3Mj8CmReSH4u88nho6792MuIU3Te6GqMt
         hqAw==
X-Gm-Message-State: AODbwcCtp2BlIKUeg61VVNb2bbMbk+9MaYiAqxbosVh0VCVf7o1xqVcO
        IxwSKKs/WOWYcK0nEtZLeWF00V1B/A==
X-Received: by 10.107.173.18 with SMTP id w18mr10239378ioe.80.1496863826389;
 Wed, 07 Jun 2017 12:30:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Wed, 7 Jun 2017 12:30:05 -0700 (PDT)
In-Reply-To: <CAKvHMgRpS3AgRAm1ukH18kX5jNF6PEU8YTsq7mQ36myQgRe=Pw@mail.gmail.com>
References: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
 <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com>
 <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com> <CAKvHMgRpS3AgRAm1ukH18kX5jNF6PEU8YTsq7mQ36myQgRe=Pw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 7 Jun 2017 21:30:05 +0200
Message-ID: <CACBZZX5dwUq58nghuMqnuGfe9sPm1VBxVwZGZcTCYgeO5OdyTg@mail.gmail.com>
Subject: Re: send-email: Net::SMTP::SSL failure
To:     Liam Breck <liam@networkimprov.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 8:04 PM, Liam Breck <liam@networkimprov.net> wrote:
> Thanks for your help!
>
> On Wed, Jun 7, 2017 at 10:16 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Wed, Jun 7, 2017 at 7:00 PM, Liam Breck <liam@networkimprov.net> wrot=
e:
>>> On Tue, Jun 6, 2017 at 10:47 PM, Liam Breck <liam@networkimprov.net> wr=
ote:
>>>>
>>>> This is configured to send via a gmail account
>>>> git send-email --to-cover --cc-cover <patch-list>
>>>>
>>>> I See
>>>> Attempt to reload IO/Socket/SSL.pm aborted.
>>>> Compilation failed in require at
>>>> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
>>>> BEGIN failed--compilation aborted at
>>>> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
>>>> Compilation failed in require at /usr/lib/git-core/git-send-email line=
 1386.
>>>> fatal: 'send-email' appears to be a git command, but we were not
>>>> able to execute it. Maybe git-send-email is broken?
>>>>
>>>> Net/SMTP/SSL.pm v1.04
>>>>
>>>> perl v5.26.0
>>>>
>>>> Seen in git 2.11.1, 2.12.2, 2.13.0, 2.13.1 on Arch Linux
>>>
>>> Also fails with perl 5.24.1 & 5.24.0
>>>
>>> Last working config was git 2.9.3 on perl 5.24.1
>>>
>>> The relevant code from git-send-email is:
>>>
>>>             require Net::SMTP;
>>>             $smtp_domain ||=3D maildomain();
>>>             $smtp_server_port ||=3D 25;
>>>             $smtp ||=3D Net::SMTP->new($smtp_server,
>>>                          Hello =3D> $smtp_domain,
>>>                          Debug =3D> $debug_net_smtp,
>>>                          Port =3D> $smtp_server_port);
>>>             if ($smtp_encryption eq 'tls' && $smtp) {
>>>                 require Net::SMTP::SSL;
>>>                 $smtp->command('STARTTLS');
>>>
>>> I really wish git bundled its non-core perl libs...
>>
>> What's the output from just:
>>
>>     perl -MNet::SMTP -we1
>
> No output, exit code 0, however...
>
> $ perl -MIO::Socket::SSL -we1
> Can't load '/usr/lib/perl5/site_perl/auto/Net/SSLeay/SSLeay.so' for
> module Net::SSLeay: libssl.so.1.0.0: cannot open shared object file:
> No such file or directory at /usr/lib/perl5/core_perl/DynaLoader.pm
> line 193.
> at /usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
> Compilation failed in require at
> /usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
> BEGIN failed--compilation aborted at
> /usr/share/perl5/vendor_perl/IO/Socket/SSL.pm line 19.
> Compilation failed in require.
> BEGIN failed--compilation aborted.
>
> I don't have {vendor,site}_perl/auto/ tho I have the package for
> ssleay installed.
>
> Since which git release was that required?

The actual issue here is that your Net::SSLeay package is broken
because it's linked to libssl.so.1.0.0 which has since gone away. You
should see that it's missing if you run whatever the Arch equivalent
is of these Debian commands:

    $ dpkg -L libnet-ssleay-perl|grep \.so$
    /usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLeay.so
    $ /usr/bin/perldoc -l Net::SSLeay
    /usr/lib/x86_64-linux-gnu/perl5/5.24/Net/SSLeay.pod
    $ dpkg -S /usr/lib/x86_64-linux-gnu/perl5/5.24/Net/SSLeay.pod
    libnet-ssleay-perl: /usr/lib/x86_64-linux-gnu/perl5/5.24/Net/SSLeay.pod
    $ dpkg -L libnet-ssleay-perl|grep \.so$
    /usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLeay.so
    $ ldd -r /usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLeay.so
2>&1|grep libssl
            libssl.so.1.1 =3D> /usr/lib/x86_64-linux-gnu/libssl.so.1.1
(0x00007f2523bb5000)
    $ dpkg -S /usr/lib/x86_64-linux-gnu/libssl.so.1.1
    libssl1.1:amd64: /usr/lib/x86_64-linux-gnu/libssl.so.1.1

But that this isn't reported is a bug in git-send-email. This
(untested) patch is probably the least invasive and easiest way to
deal with this:

diff --git a/git-send-email.perl b/git-send-email.perl
index 7fd5874436..3f0fcf9040 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1354,6 +1354,8 @@ EOF
                        die __("The required SMTP server is not
properly defined.")
                }

+               delete $INC{"Net/SMTP.pm"} if exists $INC{"Net/SMTP.pm"}
+                                             and !defined $INC{"Net/SMTP.p=
m"};
                require Net::SMTP;
                my $use_net_smtp_ssl =3D
version->parse($Net::SMTP::VERSION) < version->parse("2.34");
                $smtp_domain ||=3D maildomain();

on closer inspection none of the other require() uses in that script
are run twice, so they don't have the same issue with hiding the
initial error.


>> I have not looked deeply at this, but the error you're getting means
>> "we tried to load it before and failed, and here you are trying
>> again".
>>
>> This is almost definitely due to this line in git-send-email:
>>
>>         if (eval { require Net::SMTP; 1 }) {
>>
>> And more generally, this code is all buggy:
>>
>>     4 matches for "eval.*require" in buffer: git-send-email.perl
>>     153:my $have_email_valid =3D eval { require Email::Valid; 1 };
>>     154:my $have_mail_address =3D eval { require Mail::Address; 1 };
>>    1118:        if (eval { require Net::Domain; 1 }) {
>>    1129:        if (eval { require Net::SMTP; 1 }) {
>>
>> Well, "buggy" in the sense that we're just happy-go-lucky trying to
>> load these modules, and if they have an error we don't report it, then
>> when we try to load them again perl just emits a generic error saying
>> you're trying to require() something that already failed somewhere
>> before, a minimal test case for that is:
>>
>>     $ cat /tmp/Fails.pm
>>     package Fails;
>>     die "oh noes";
>>     $ perl -I/tmp -we 'eval { require Fails }; require Fails'
>>     Attempt to reload Fails.pm aborted.
>>     Compilation failed in require at -e line 1.
>>
>> Whereas what we really want to do is some variant of:
>>
>>     $ perl -MData::Dumper -I/tmp -we 'eval { require Fails } or warn
>> $@; require Fails'
>>     oh noes at /tmp/Fails.pm line 2.
>>     Compilation failed in require at -e line 1.
>>     Attempt to reload Fails.pm aborted.
>>     Compilation failed in require at -e line 1.
>>
>> Or even the more adventerous, this can have some bad side-effects with
>> some libraries (you lie to perl saying you haven't seen it before),
>> but I doubt Net::SMTP cares much, particularly when we're just about
>> to report an error:
>>
>>     $ perl -MData::Dumper -I/tmp -we 'eval { require Fails } or do {
>> delete $INC{"Fails.pm"} }; require Fails'
>>     oh noes at /tmp/Fails.pm line 2.
>>     Compilation failed in require at -e line 1.

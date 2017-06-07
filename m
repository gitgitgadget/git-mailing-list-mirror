Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B1E1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 17:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbdFGRRE (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 13:17:04 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37969 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdFGRRD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 13:17:03 -0400
Received: by mail-it0-f54.google.com with SMTP id r63so9607941itc.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VFMt/us/qNisej+mAh5xSJ0bopWwWnQz/9tu0z6GyOM=;
        b=F7abgcrjKJ//pFPmx0vxDKZHtp8FMHTCQcWbCR0/2XWtsWDG++vddsndEpgciyvGcD
         C15tlDw/IcvzYyxqLlzO63DmxcnGDNYSISE6l5UVM08hEiq+GMnKWh4SbO5+6IgqYW+p
         ZAR389Alrk8F4lwqarfq56NyX4fsNktJrZeY4t7VWw/PolqquMKAcNlvDTJegV9+9BkW
         VvpcNlFUG6XbHHPZ0Ud/fuSGJGmHXunM2ZHaInaDr8iO4pdB9nBrf6eZKEEkcnd9cxX3
         56XozDAO21o+OlPn92AjgIV0BxbqIX8UbBDMsTScH0Ow1+hLKDAMLthyIU+JWx22MzGl
         YD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VFMt/us/qNisej+mAh5xSJ0bopWwWnQz/9tu0z6GyOM=;
        b=a8Q0wXbqnRTh10/81P+z3BA3stMZj9WoOlWTCjphcOAkO1MSWCnVYZByizmM/OigoJ
         aAnTd78c8AgQmGgrLueBtLRUkEZC59D3Cpr/R8S7fNLID4u7hJ6VFQ0yTMCwb4mZY0xC
         BSkAh2iETqm9Sfl17P1+P4n9iX0mnPMbmZ9tempr2rQdEHL+47bkMIL/5nPraUbKzzTn
         CqWYUFNeYSuNjyb5q9uveYXr1KsWlJt5v2xw4Xmq/nH0tEKgZTqdH6o2wJS/5LlV1bAT
         HwJPQIVlob0hg6lTZudWGLGH6tL16Lbl3XJt7Y/R7Vu2VqR7lLYUxX712JNYRDUlwtLB
         M/FA==
X-Gm-Message-State: AODbwcDXxdOWTetUwa7YbaLOkPz0r+S1dOH0YYoADruzlpwhhrWgZ8C3
        /LmEQD6AAAC42vFoNngRZilD0Eg+Ugp6WGs=
X-Received: by 10.36.164.67 with SMTP id v3mr925307iti.71.1496855822530; Wed,
 07 Jun 2017 10:17:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Wed, 7 Jun 2017 10:16:41 -0700 (PDT)
In-Reply-To: <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com>
References: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
 <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 7 Jun 2017 19:16:41 +0200
Message-ID: <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com>
Subject: Re: send-email: Net::SMTP::SSL failure
To:     Liam Breck <liam@networkimprov.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 7:00 PM, Liam Breck <liam@networkimprov.net> wrote:
> On Tue, Jun 6, 2017 at 10:47 PM, Liam Breck <liam@networkimprov.net> wrote:
>>
>> This is configured to send via a gmail account
>> git send-email --to-cover --cc-cover <patch-list>
>>
>> I See
>> Attempt to reload IO/Socket/SSL.pm aborted.
>> Compilation failed in require at
>> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
>> BEGIN failed--compilation aborted at
>> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
>> Compilation failed in require at /usr/lib/git-core/git-send-email line 1386.
>> fatal: 'send-email' appears to be a git command, but we were not
>> able to execute it. Maybe git-send-email is broken?
>>
>> Net/SMTP/SSL.pm v1.04
>>
>> perl v5.26.0
>>
>> Seen in git 2.11.1, 2.12.2, 2.13.0, 2.13.1 on Arch Linux
>
> Also fails with perl 5.24.1 & 5.24.0
>
> Last working config was git 2.9.3 on perl 5.24.1
>
> The relevant code from git-send-email is:
>
>             require Net::SMTP;
>             $smtp_domain ||= maildomain();
>             $smtp_server_port ||= 25;
>             $smtp ||= Net::SMTP->new($smtp_server,
>                          Hello => $smtp_domain,
>                          Debug => $debug_net_smtp,
>                          Port => $smtp_server_port);
>             if ($smtp_encryption eq 'tls' && $smtp) {
>                 require Net::SMTP::SSL;
>                 $smtp->command('STARTTLS');
>
> I really wish git bundled its non-core perl libs...

What's the output from just:

    perl -MNet::SMTP -we1

I have not looked deeply at this, but the error you're getting means
"we tried to load it before and failed, and here you are trying
again".

This is almost definitely due to this line in git-send-email:

        if (eval { require Net::SMTP; 1 }) {

And more generally, this code is all buggy:

    4 matches for "eval.*require" in buffer: git-send-email.perl
    153:my $have_email_valid = eval { require Email::Valid; 1 };
    154:my $have_mail_address = eval { require Mail::Address; 1 };
   1118:        if (eval { require Net::Domain; 1 }) {
   1129:        if (eval { require Net::SMTP; 1 }) {

Well, "buggy" in the sense that we're just happy-go-lucky trying to
load these modules, and if they have an error we don't report it, then
when we try to load them again perl just emits a generic error saying
you're trying to require() something that already failed somewhere
before, a minimal test case for that is:

    $ cat /tmp/Fails.pm
    package Fails;
    die "oh noes";
    $ perl -I/tmp -we 'eval { require Fails }; require Fails'
    Attempt to reload Fails.pm aborted.
    Compilation failed in require at -e line 1.

Whereas what we really want to do is some variant of:

    $ perl -MData::Dumper -I/tmp -we 'eval { require Fails } or warn
$@; require Fails'
    oh noes at /tmp/Fails.pm line 2.
    Compilation failed in require at -e line 1.
    Attempt to reload Fails.pm aborted.
    Compilation failed in require at -e line 1.

Or even the more adventerous, this can have some bad side-effects with
some libraries (you lie to perl saying you haven't seen it before),
but I doubt Net::SMTP cares much, particularly when we're just about
to report an error:

    $ perl -MData::Dumper -I/tmp -we 'eval { require Fails } or do {
delete $INC{"Fails.pm"} }; require Fails'
    oh noes at /tmp/Fails.pm line 2.
    Compilation failed in require at -e line 1.

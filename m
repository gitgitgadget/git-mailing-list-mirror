Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06391F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 06:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbdFHG11 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 02:27:27 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37820 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdFHG10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 02:27:26 -0400
Received: by mail-it0-f44.google.com with SMTP id m47so15697103iti.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 23:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QpPp76ugFqcjIWbrfVp9dAt8LgH+vrvFlTmK6xT4JgQ=;
        b=OVUGr60km/A3LaAUhM8+SVEe5bOz/5zB29maTE+lAjSI2qZWi2H0Q/i/8OkNcN34jh
         /jwap9b67Iq17oVdi9EM5QpA5Dq4VKlgg2oFZquFrJjC6zklPdhEUyTEvWlmUxiSbJGL
         2yHJEj2D9Do+nZJRN0ADFG9zw0snU07Abnigv6OyvypZchmWr0UobV5cm7ih27gqrqXV
         OGN+5Z3Fs1jqUYA9xw/Hjy9wB+kLxaV98zBvNbPefuHRIKCIUsHFs6acKifVJRnw3q9Z
         qSYwVa8wHGEs42YdA47pS4laaMgogo3qcEs4F4fj2agYPxprubAXZEz4APvzmkBoRMkd
         +JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QpPp76ugFqcjIWbrfVp9dAt8LgH+vrvFlTmK6xT4JgQ=;
        b=IFmefF9R2Hwm7q4VfJwHG3qHN7IQAZcvAntR3Gjw1ud1RVrkGAHXhYOsRSB/LLRFNs
         DIyWvumTKySjw3wOXSkg2XtH6EZ+IsKysCkto/vPyzKDughrPK7ooK7wYdap7elU5Glr
         l4ThYESRmtA95cqGRXQ6r3xgcAN2yb+DPeFyQn8NkaPfAOTZ9D9E8UWWA2gG/zhfUBHR
         t0vWMuStBBATKTCgGsqenoELLbVbrDvpYOu7ovKV8bDEGfqTi5dX4WXT9nv9cQpZXU2t
         NetnNp/GY4FwdjiZGxgfCxcHMvGECwYDhweQQmnYgPZEx50JwF51GwnJCdr9n3V6PTtQ
         KHAg==
X-Gm-Message-State: AODbwcBiVm/nh/VgY/u4LR/md0q5/7+LOmhOm46aL8EWH3xEMhdUB54w
        dS1fUJ+e6ZMYR0kPdAi0AUv78plWhA==
X-Received: by 10.36.138.131 with SMTP id v125mr3937874itd.66.1496903245736;
 Wed, 07 Jun 2017 23:27:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Wed, 7 Jun 2017 23:27:04 -0700 (PDT)
In-Reply-To: <CAJZjrdU=743ikOCxCJ9stQ5qZsndZDXt1jquxGwBrid4YhVsGA@mail.gmail.com>
References: <CAJZjrdU=743ikOCxCJ9stQ5qZsndZDXt1jquxGwBrid4YhVsGA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 8 Jun 2017 08:27:04 +0200
Message-ID: <CACBZZX5wr2k0+i-0CKde_P5key=b+mh0jf47D9oJ449j=MohSw@mail.gmail.com>
Subject: Re: send-email: Net::SSLeay failure
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Liam Breck <liam@networkimprov.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 8, 2017 at 3:32 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
> On Wed, Jun 7, 2017 at 8:26 PM, Liam Breck <liam@networkimprov.net> wrote=
:
>> On Wed, Jun 7, 2017 at 5:06 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>>> On Wed, Jun 7, 2017 at 4:43 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>> <avarab@gmail.com> wrote:
>>>> Ah, so you installed Net::SSLeay via CPAN, and then upgraded your Arch
>>>> openssl, breaking the CPAN-built *.so object?
>>>>
>>>>> Agreed that send-email should be report errors properly. It's a rathe=
r
>>>>> essential tool.
>>>>
>>>> Indeed, do you get a meaningful error if you apply my patch?
>>>
>>> FWIW I'm on Arch as well and am getting what I assume is a related erro=
r:
>>>
>>> SSLeay.c: loadable library and perl binaries are mismatched (got
>>> handshake key 0xdb80080, needed 0xde00080)
>>>
>>> The last patch I sent out was on 5/23, and I just ran a system upgrade
>>> today (only one I've done since then), which presumably is what
>>> "broke" send-email. I used CPAN to install Net::SMTP::SSL,
>>> Mime::Base64, and Authen::SASL; I assume that Net::SSLeay is installed
>>> as a dependency of one of the three (presumably the first)?
>>>
>>> I know Net::SSLeay isn't controlled by Arch's package manager:
>>>
>>> $ perldoc -l Net::SSLeay
>>> /usr/lib/perl5/site_perl/Net/SSLeay.pod
>>> $ pacman -Qo /usr/lib/perl5/site_perl/Net/SSLeay.pod
>>> error: No package owns /usr/lib/perl5/site_perl/Net/SSLeay.pod
>>>
>>> =C3=86var's patch unfortunately does not fix or change anything for me.
>>
>> Right because it attempts to log a diff issue.
>>
>>> Liam: when you say "uninstall" /usr/{lib,share}/perl5/site_perl/*, do
>>> you just mean rm -rf?
>>
>> You need these new arch packages:
>> perl-mime-tools perl-net-smtp-ssl perl-authen-sasl
>>
>> To uninstall the cpan stuff I did this in case I need to put anything ba=
ck
>>
>> mkdir -p siteperl_uninstall/{lib,share}
>> sudo mv /usr/share/perl5/site_perl/*  siteperl_uninstall/share/
>> sudo mv /usr/lib/perl5/site_perl/*  siteperl_uninstall/lib/
>>
>> You could comment on this issue here
>> https://bugs.archlinux.org/task/54334
>
> Changed the subject line; my issue seems to be less related to yours
> than I thought. I followed the steps you describe and I'm still
> getting the mismatch error I mentioned above.
>
> The closest I've gotten to figuring this out is that for some reason
> SSLeay.so is unhappy:
>
> $ ldd -r /usr/lib/perl5/vendor_perl/auto/Net/SSLeay/SSLeay.so
>                                 linux-vdso.so.1 (0x00007ffc67fb0000)
>         libssl.so.1.1 =3D> /usr/lib64/libssl.so.1.1 (0x00007f891e58b000)
>         libcrypto.so.1.1 =3D> /usr/lib64/libcrypto.so.1.1 (0x00007f891e11=
0000)
>         libc.so.6 =3D> /usr/lib64/libc.so.6 (0x00007f891dd6b000)
>         libpthread.so.0 =3D> /usr/lib64/libpthread.so.0 (0x00007f891db4d0=
00)
>         libdl.so.2 =3D> /usr/lib64/libdl.so.2 (0x00007f891d949000)
>         /usr/lib64/ld-linux-x86-64.so.2 (0x00005598da604000)
> undefined symbol: PL_thr_key
> (/usr/lib/perl5/vendor_perl/auto/Net/SSLeay/SSLeay.so)
> undefined symbol: Perl_sv_setnv_mg
> (/usr/lib/perl5/vendor_perl/auto/Net/SSLeay/SSLea
> [many more undefined symbol errors]
>
> =C3=86var and anyone else familiar with Perl, any ideas? The best I can g=
et
> from the Arch forums is that this tends to occur when perl calls an
> external lib built against a different version of perl, but I can't
> tell if that's happening here.

Do you mean why does it emit a bunch of "undefined symbol" errors?
That's perfectly normal, it's because you're pointing ldd at a library
that expects symbols from libperl, since that'll be loaded first when
it's run, but the stand-alone invocation doesn't have that, I get the
same on Debian.

$ ldd -r /usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLeay.so
2>&1|grep -c 'undefined symbol'
56
$ LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/libperl.so.5.24 ldd -r
/usr/lib/x86_64-linux-gnu/perl5/5.24/auto/Net/SSLeay/SSLeay.so 2>&1 |
grep -c 'undefined symbol'
0

That by itself does not suggest the library is broken, and your
version seems to link to a working libssl.

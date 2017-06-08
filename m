Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A171FAED
	for <e@80x24.org>; Thu,  8 Jun 2017 01:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbdFHBdd (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 21:33:33 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36072 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdFHBdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 21:33:33 -0400
Received: by mail-it0-f44.google.com with SMTP id m47so119066395iti.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 18:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=AiQbCAQfEenTSQE4nSYLFxfUxeKxCV9UmjBfsE58rkg=;
        b=swe3jWkoLEAvMTzHvhzFnwbQ4Npeajt1tDkGXPyFf/wyMRupbt9Iei0wCjHwpfmy83
         H2L2xd6jLUzswYxybzifz/9OPIxyqlDjo7n5pp7a6Ip2dVG9c3+QnsxrCfH8a85lorba
         iRmkTHULIB3FFEwbOGO+zqK7Fm2dqKnh/tM/FBfUoQ6RyZ6SARFOeTg/ixnamkEXKp1b
         QX2t70T2XFLkXxRryFZP2tCEAYRIFvttd9PL3SLofSCILLkLBS4dbxZDAzUNe9o/bCxr
         /VsN7f2t45mlfj20RDggyYe25/YOomAqJOhSYM6QvA8fJVa/tuETVX+IsKdS6h/uOlAj
         6lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=AiQbCAQfEenTSQE4nSYLFxfUxeKxCV9UmjBfsE58rkg=;
        b=pkvrEaZ1TllDGiZtk0JM0ppiGeCpst9+zJBM0QIBPyDabX7nbSUKTVT+VvegKfe2nq
         cdHjjNSnTK9dKGNfg4EbE7kAEeTX/hPUrAqXsdtF1kFbgz9dUnUQRiHG7obCNScC8fcX
         NFLsWNXgupkQ/+hWGdoubl1vTFhImqy+8EWF9e0eRM1H23NjZpKu3A4PWLGlmEcQ3xNO
         nMRswXoJNsB1zXqwEhEna0pLqUV3d9X0PffWLZn6Uzo+SZy2RRSBuOga2nCU89bwSZeg
         jywKoAQpxGwxmWwKCw0bu0moKokvqcEnJgoCI4JxmJPwQh3JS1a+VTjBoXBqrQiMJJGP
         ppIg==
X-Gm-Message-State: AODbwcBJbZ3agaoCASYIS8ktrsYm1j2mwUdJJtdhY4gWWqp7fPtimLnZ
        h4gwIwRumAztc79nOtBiZ6c+b8V0XaXaUXQ=
X-Received: by 10.36.61.76 with SMTP id n73mr3294306itn.51.1496885612078; Wed,
 07 Jun 2017 18:33:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Wed, 7 Jun 2017 18:32:51 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 7 Jun 2017 21:32:51 -0400
Message-ID: <CAJZjrdU=743ikOCxCJ9stQ5qZsndZDXt1jquxGwBrid4YhVsGA@mail.gmail.com>
Subject: Re: send-email: Net::SSLeay failure
To:     Liam Breck <liam@networkimprov.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 8:26 PM, Liam Breck <liam@networkimprov.net> wrote:
> On Wed, Jun 7, 2017 at 5:06 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>> On Wed, Jun 7, 2017 at 4:43 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> Ah, so you installed Net::SSLeay via CPAN, and then upgraded your Arch
>>> openssl, breaking the CPAN-built *.so object?
>>>
>>>> Agreed that send-email should be report errors properly. It's a rather
>>>> essential tool.
>>>
>>> Indeed, do you get a meaningful error if you apply my patch?
>>
>> FWIW I'm on Arch as well and am getting what I assume is a related error=
:
>>
>> SSLeay.c: loadable library and perl binaries are mismatched (got
>> handshake key 0xdb80080, needed 0xde00080)
>>
>> The last patch I sent out was on 5/23, and I just ran a system upgrade
>> today (only one I've done since then), which presumably is what
>> "broke" send-email. I used CPAN to install Net::SMTP::SSL,
>> Mime::Base64, and Authen::SASL; I assume that Net::SSLeay is installed
>> as a dependency of one of the three (presumably the first)?
>>
>> I know Net::SSLeay isn't controlled by Arch's package manager:
>>
>> $ perldoc -l Net::SSLeay
>> /usr/lib/perl5/site_perl/Net/SSLeay.pod
>> $ pacman -Qo /usr/lib/perl5/site_perl/Net/SSLeay.pod
>> error: No package owns /usr/lib/perl5/site_perl/Net/SSLeay.pod
>>
>> =C3=86var's patch unfortunately does not fix or change anything for me.
>
> Right because it attempts to log a diff issue.
>
>> Liam: when you say "uninstall" /usr/{lib,share}/perl5/site_perl/*, do
>> you just mean rm -rf?
>
> You need these new arch packages:
> perl-mime-tools perl-net-smtp-ssl perl-authen-sasl
>
> To uninstall the cpan stuff I did this in case I need to put anything bac=
k
>
> mkdir -p siteperl_uninstall/{lib,share}
> sudo mv /usr/share/perl5/site_perl/*  siteperl_uninstall/share/
> sudo mv /usr/lib/perl5/site_perl/*  siteperl_uninstall/lib/
>
> You could comment on this issue here
> https://bugs.archlinux.org/task/54334

Changed the subject line; my issue seems to be less related to yours
than I thought. I followed the steps you describe and I'm still
getting the mismatch error I mentioned above.

The closest I've gotten to figuring this out is that for some reason
SSLeay.so is unhappy:

$ ldd -r /usr/lib/perl5/vendor_perl/auto/Net/SSLeay/SSLeay.so
                                linux-vdso.so.1 (0x00007ffc67fb0000)
        libssl.so.1.1 =3D> /usr/lib64/libssl.so.1.1 (0x00007f891e58b000)
        libcrypto.so.1.1 =3D> /usr/lib64/libcrypto.so.1.1 (0x00007f891e1100=
00)
        libc.so.6 =3D> /usr/lib64/libc.so.6 (0x00007f891dd6b000)
        libpthread.so.0 =3D> /usr/lib64/libpthread.so.0 (0x00007f891db4d000=
)
        libdl.so.2 =3D> /usr/lib64/libdl.so.2 (0x00007f891d949000)
        /usr/lib64/ld-linux-x86-64.so.2 (0x00005598da604000)
undefined symbol: PL_thr_key
(/usr/lib/perl5/vendor_perl/auto/Net/SSLeay/SSLeay.so)
undefined symbol: Perl_sv_setnv_mg
(/usr/lib/perl5/vendor_perl/auto/Net/SSLeay/SSLea
[many more undefined symbol errors]

=C3=86var and anyone else familiar with Perl, any ideas? The best I can get
from the Arch forums is that this tends to occur when perl calls an
external lib built against a different version of perl, but I can't
tell if that's happening here.

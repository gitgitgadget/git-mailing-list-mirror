Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750181F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 09:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750819AbdFHJxx (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 05:53:53 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33296 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdFHJxw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 05:53:52 -0400
Received: by mail-io0-f180.google.com with SMTP id b184so17916935ioe.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MBW3sxPGDPwQEe+2nHDrAWz3Nxml+SxZa/PxSQZWWgI=;
        b=aD3sK1JVgHyne6qjL2GWiLaQhCPDS3LNyxUVYOVd6pyFCqgn+9BFw4p2YXN9YhXphd
         r89ACQarxQG9SDZ0Lv0jt5XGGYsThrnqWqS2RPz2AAnlk0/exzcstR0avWisEg3KJ/p9
         Hi1IJazsfcev7uvFv8JF3Fpbfm81w8/1YOzqJ5QY5qgbszdPQeIRzStCFz0GOBNV8XZ4
         fZnRyvg9dlT6pObhPuqATniuIJaPzmSScfHFxnNkDYzGvHE9jm0sf0GtDnNnFFIl2aPk
         3BlV1KauyIDEE2IwLtz1BhLSZZQFxW+WcX1T15TfVC0gpM362pML9qRrgGsaZDl5Rh0M
         //Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MBW3sxPGDPwQEe+2nHDrAWz3Nxml+SxZa/PxSQZWWgI=;
        b=i7t6g9ZRu5mGPwMMTc1mhOerrqle49tZWgMnGkUAWFRLHw22/Zh1ehGs9PXdBhLC/b
         vvEOl2xS2uH0QCyJOYuwDELQeFNL5CI48V5lAngQT2XeJCmfJamNi3pzgb+NK0/0bnae
         b4b74pv/eHckFIDIBCOaSyoeRrpfotljRzj3y5PLKNhLWirCuTyKt7z+IjJ6A5JZqyvS
         QbRMs55x0vFFFWZmMOlAxaylqihvjlyM0u7bsfNAv+Suq4qoeoNT76Col2YrjaztiPfk
         UIIopXgHRNidwQBB3jfQkyUPVz0StmUasGKbHlFmr2yflAomfBbAw4vRmtmCQfj4LHZ6
         OjQw==
X-Gm-Message-State: AODbwcBWe+ARJQEovLIq0Vu1+DiJWwZQI9QPkYNVuG1TCOFRndmOuCMV
        3NPUbkgxfY4BYtxocwiB0l/E5wR76Q==
X-Received: by 10.107.173.18 with SMTP id w18mr12961481ioe.80.1496915631959;
 Thu, 08 Jun 2017 02:53:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Thu, 8 Jun 2017 02:53:31 -0700 (PDT)
In-Reply-To: <CAJZjrdWkqNVLgZ5KYQ33zjO25raLhAHGxqPezjUsQ692wKTudg@mail.gmail.com>
References: <CAJZjrdU=743ikOCxCJ9stQ5qZsndZDXt1jquxGwBrid4YhVsGA@mail.gmail.com>
 <CACBZZX5wr2k0+i-0CKde_P5key=b+mh0jf47D9oJ449j=MohSw@mail.gmail.com> <CAJZjrdWkqNVLgZ5KYQ33zjO25raLhAHGxqPezjUsQ692wKTudg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 8 Jun 2017 11:53:31 +0200
Message-ID: <CACBZZX57=y0kHFDDAKfiFjpr8_BUsBFK6ic--zv8=SAmtD0AoQ@mail.gmail.com>
Subject: Re: send-email: Net::SSLeay failure
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Liam Breck <liam@networkimprov.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 8, 2017 at 11:06 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
> Sorry, I should've been clearer. Currently send-email fails for me
> with this error:
>
> SSLeay.c: loadable library and perl binaries are mismatched (got
> handshake key 0xdb80080, needed 0xde00080)
>
> I thought the undefined symbol stuff in the .so could have been part
> of the problem, but I guess not. None of the fixes that worked for
> Liam worked for me either, so I'm not quite sure where the issue is.
> The closest I've found to a meaningful suggestion for the error is
> that Perl is relying on a library built against a different version of
> Perl, but I have no idea what library that might be.

The issue is that SSLeay.so is compiled against a different version of
perl, presumably you installed it via CPAN in the past and then
upgraded your system perl version.

The easiest solution is probably just to re-run "sudo cpan
Net::SSLeay", or alternatively rm -rf all these files and install them
via your package system.

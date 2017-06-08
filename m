Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C8A1F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 09:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdFHJ70 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 05:59:26 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36369 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdFHJ7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 05:59:25 -0400
Received: by mail-io0-f169.google.com with SMTP id y77so17928157ioe.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fA9FfQa4egQs/RjHoKrq3e0O72YQ59LSFbi9LNMVDuw=;
        b=M6H4xPma04MN4Uat8xMnS62Su2pj5hVRXNGJxxnuwFPwxI+dDlTYswylt7sCoBIHV+
         HksryhIQM7SYczGCOKzMGwOIjkPHFYli89yQube1E6RYwsdqxfS6pgC3+q+PNM3b4qZA
         dXBKRQyZqgnEFwfyRpmMiSmHq5ALlusoAZsNLJy1eN9MsGO2ljpWj+hKNDWWOFcw3Brh
         k9r6d97WyC3RPdH2pn7SswsNuhFktz67qtyD6yAYeetYTi97xSK2JjK7XTSbfISp1Sxr
         14zSBaLdyp4nnl24s719eSbz7XltZNNWILPwpoiThDE5WnruyydkNI1MBhuiIjmm/6nR
         b4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fA9FfQa4egQs/RjHoKrq3e0O72YQ59LSFbi9LNMVDuw=;
        b=D0p/FWBJGIyJiyYj9wTVIp2hCfhDocM2qnAZ17k1SUyXoTc9yGsiAHBuiycHaE0wua
         iul4+lFUnDrI+tIbEtvQcUGI5jpmrYUYLybbtL25hfJ/hrKqFkE1rrJwZWpSgDGmQ1pU
         uGwNI9OKEmKCsyZiAES0MsFfvWc7TPG65W2AgCotX6BMMeertzRKX6p899e9bEanz1dZ
         HQsE55z81xSlMOZP6fMgV+Y8oZxFm+Yow/DoQQnbSry8hNHai7an1vB9u2wkH8KZt5WN
         14LdWOeCTW72LWVmjJCaMSynQpJE2k5HJ0Q8SBsoIucplq0Cu4fz+8NQ30sjrN5QtdU+
         OJaw==
X-Gm-Message-State: AODbwcC86w3EUsfj6ljD857tbzxRlDFEPoEyeSBFFm4hYZvHLtqaqTZ/
        QypieVMX2Z+44dmTK/K6oneZOu06WN4+
X-Received: by 10.107.181.73 with SMTP id e70mr2808223iof.85.1496915964173;
 Thu, 08 Jun 2017 02:59:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Thu, 8 Jun 2017 02:58:43 -0700 (PDT)
In-Reply-To: <CACBZZX57=y0kHFDDAKfiFjpr8_BUsBFK6ic--zv8=SAmtD0AoQ@mail.gmail.com>
References: <CAJZjrdU=743ikOCxCJ9stQ5qZsndZDXt1jquxGwBrid4YhVsGA@mail.gmail.com>
 <CACBZZX5wr2k0+i-0CKde_P5key=b+mh0jf47D9oJ449j=MohSw@mail.gmail.com>
 <CAJZjrdWkqNVLgZ5KYQ33zjO25raLhAHGxqPezjUsQ692wKTudg@mail.gmail.com> <CACBZZX57=y0kHFDDAKfiFjpr8_BUsBFK6ic--zv8=SAmtD0AoQ@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 8 Jun 2017 05:58:43 -0400
Message-ID: <CAJZjrdUGpujOhYrcziO-ncF8g1LsJCG1+GMNbguMFHN-UJ6gKQ@mail.gmail.com>
Subject: Re: send-email: Net::SSLeay failure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Liam Breck <liam@networkimprov.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 8, 2017 at 5:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Jun 8, 2017 at 11:06 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
>> Sorry, I should've been clearer. Currently send-email fails for me
>> with this error:
>>
>> SSLeay.c: loadable library and perl binaries are mismatched (got
>> handshake key 0xdb80080, needed 0xde00080)
>>
>> I thought the undefined symbol stuff in the .so could have been part
>> of the problem, but I guess not. None of the fixes that worked for
>> Liam worked for me either, so I'm not quite sure where the issue is.
>> The closest I've found to a meaningful suggestion for the error is
>> that Perl is relying on a library built against a different version of
>> Perl, but I have no idea what library that might be.
>
> The issue is that SSLeay.so is compiled against a different version of
> perl, presumably you installed it via CPAN in the past and then
> upgraded your system perl version.
>
> The easiest solution is probably just to re-run "sudo cpan
> Net::SSLeay", or alternatively rm -rf all these files and install them
> via your package system.

I thought I already had rm -rf'd them, but upon double-checking it
turns out I didn't nuke the CPAN version of Net::SSLeay properly.
Thanks.

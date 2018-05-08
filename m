Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F49F200B9
	for <e@80x24.org>; Tue,  8 May 2018 03:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbeEHDVv (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 23:21:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36103 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbeEHDVt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 23:21:49 -0400
Received: by mail-wr0-f195.google.com with SMTP id p4-v6so404959wrh.3
        for <git@vger.kernel.org>; Mon, 07 May 2018 20:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RVpavi4pCEE4KG4Ehzi4cMDSkf0vgUBqBQFO8JDCvqQ=;
        b=ScVxypF93GB0OEYUS4LUH+6RA8GWd4Kvk/JDts4vZ287SlUhI1UZh7kS/7TK83uTod
         nyzUUXChY0YD7fSN9WtaBghLHW2645m261Jk3eMwSPcsWsG0yqAcGvKIqbIc+yba9USZ
         rQelZFhtobIL78pJsEy+wYzuNdE45zmPaJrSIa39I9e1QK6DQSaql6QRmqPCAC0xqnDC
         /dccAvBX8dj1frFB2k5yUrNhavRZ90ieQ+LIzzbYVOt4kuGTpmdD/2ZXtb2Gq7+AGi8D
         Q2gHSVuTD9cTj4YDZkgRUIt8zFKYwIbEjQRyyTTfh7TPJdG/lZ0IxX0cbSNogxxVCigH
         7ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RVpavi4pCEE4KG4Ehzi4cMDSkf0vgUBqBQFO8JDCvqQ=;
        b=JWVzMghuC7wUO2fNAdPn2FBuee4OLD0b5WhqEUBaLwamynr5MBlfYMjrqk8nfjKLp4
         4rcuE/JnI4JJn1JHE1kcqw5+65opTq91kQc0zpkmkXi0qtymaPTrwdeX/g73X00vSJe8
         2va5xOonfIoD00iycK/d4G2o2xkR/o0I3B/QDOtZt6JkgJa1rAiRTOUR7CVBwlsRc5Sw
         FH5aie/MGFphD5eUw9qkMxm/8jDAZVVxFVnwg0FO4YD6WFVD6NsFpgJ49yCs46GPL52F
         9l+rFNp/U5tIJgQSbHHAq65BYVs79fDpzYQ1VepHscOS/5mfgVBBQcb/8m6L8Ut/9q0e
         FCPA==
X-Gm-Message-State: ALQs6tDJBdfbyyV2fYw26T+FSJFJpWvAyHCRMXx14vuKeCEg51QI4S+E
        WC1WxXArlba/zPbTl1OJSzxi+eblnTI=
X-Google-Smtp-Source: AB8JxZrBoswDFo/7FSAadHmmG/jzUfnhX/UiWRDSRLMyV+PptPnheSV35Rn0J11ZGHQbEDzuR+A0UA==
X-Received: by 2002:adf:85b8:: with SMTP id 53-v6mr33456191wrt.31.1525749707823;
        Mon, 07 May 2018 20:21:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b133-v6sm4839810wmh.12.2018.05.07.20.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 20:21:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] mailmap: update brian m. carlson's email address
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
        <20180508015845.268572-1-sandals@crustytoothpaste.net>
Date:   Tue, 08 May 2018 12:21:46 +0900
In-Reply-To: <20180508015845.268572-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 8 May 2018 01:58:45 +0000")
Message-ID: <xmqqzi1an86t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> An earlier change, cdb6b5ac (".mailmap: Combine more (name, email) to
> individual persons", 2013-08-12), noted that there were two name
> spellings and two email addresses and mapped the crustytoothpaste.net
> address to the crustytoothpaste.ath.cx address.  The latter is an older,
> obsolete address, while the former is current, so switch the order of
> the addresses so that git log displays the correct address.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I intentionally avoided the use of the first person here, because I
> wasn't sure what the preference of the list was on that.  Hopefully it
> reads naturally and isn't awkward.
>
> If not, I can send a v3.

Nah, the updated text is perfect.  Thanks, will replace.

>
>  .mailmap | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 7c71e88ea5..df7cf6313c 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -25,8 +25,8 @@ Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
>  Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
>  Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
>  Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
> -brian m. carlson <sandals@crustytoothpaste.ath.cx> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
> -brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>
> +brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
> +brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
>  Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
>  Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
>  Cheng Renquan <crquan@gmail.com>

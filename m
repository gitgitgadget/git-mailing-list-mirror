Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7E720286
	for <e@80x24.org>; Thu,  7 Sep 2017 17:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbdIGRVK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 13:21:10 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36306 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbdIGRVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 13:21:10 -0400
Received: by mail-yw0-f179.google.com with SMTP id w204so1063710ywg.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g6dGpeH13jFqgXsPl8EBGY1mIr13vd32grTlMRsG8xs=;
        b=KwDH4IILTxFRAb+NZUyymq2w3/3YjZZ99KMp39EXPlWXk+leAd5I91DIBfwAm0dShe
         Vf8XtxIVgiMB3qfyDKpPVTjlqszDInnoI3uUkiQsLK9bQi+f5NaLECbfcQjeDtC1aoMa
         AXn09GwpvzPzZ7oh/mgM7KnjUBCyx839wYLqeZwvrio14B3D//Y3ew3nIP3hrZX39AlL
         3PVpsz7uhyCd/yB5hCKnvDdMu3S2XlRZtGjXT89JaD6O07Up3AogoWLcv2gGqZ628ee/
         +IPrStcSlCX2LDRfM+qOIxBR4Mc7awSKCmCKaWaboziWmgRVqvNOxV3xCm7HfSgbdyXU
         iiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g6dGpeH13jFqgXsPl8EBGY1mIr13vd32grTlMRsG8xs=;
        b=WYnpsmqaQZsK50Re3XernUUiUwWJaN1waijBZDjTLxpwJJbnVx4TvByBpcdMIGNg+W
         yhONqcaN/aFKwBiqZS7bNa3jW4ik1tilo8bOo7ZGz3YCIqF6LBpi2L8/5oNWrRrN7NMs
         oH9FeV0/y5/JUfodhrZB662KlQQbEbgkgHndXYu/tNX16ONG54JzFa4Cl19JlqBtdueu
         b1PP94xLnQYr+hmItYnxqUtTkPWg2aggb3mqWfEZ744ZXHMWCkVSHhqQY4jzFkjGwX0O
         dtPHWMRJqPlOi8330VosBhR3J/9xawVCSMP1TYQr8tXNynnYE65YOTHQwrIV9SPd6lFj
         M2kQ==
X-Gm-Message-State: AHPjjUhACKRP4uA7jqmS9hMfC1Ntr9V34L30Sd/NT4xCobRvlSMwC6q8
        j6oDrx1fZMEO6N7w77N0ql/07wq46+pIjVU=
X-Google-Smtp-Source: AOwi7QDCJPrH9PEH/knXpmOPKxh4LsRu4eummhVMnu2cx0Ist/Y5uzGIhSylpJDizY85POJxYXi8zMcmw3laDY8qwVo=
X-Received: by 10.37.162.144 with SMTP id c16mr45773ybi.244.1504804869148;
 Thu, 07 Sep 2017 10:21:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Thu, 7 Sep 2017 10:21:08 -0700 (PDT)
In-Reply-To: <20170907070827.sysqmszdwduruwis@weakknees.security.iitk.ac.in>
References: <20170906093913.21485-1-root@shikherverma.com> <20170907070827.sysqmszdwduruwis@weakknees.security.iitk.ac.in>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 7 Sep 2017 10:21:08 -0700
Message-ID: <CAGZ79kb3vv0sfqRBjJwOb1vFGeRgztZRdbqinv89NmhQaAb9CA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
To:     Shikher Verma <root@shikherverma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2017 at 12:08 AM, Shikher Verma <root@shikherverma.com> wrote:
> Hey everyone,
>
> I felt like I should introduce myself since this is my first patch on
> the git mailing list (or any mailing list actually) :D

Welcome to the list. :)

> I am Shikher[1], currently in my 4th year undergrad at IIT Kanpur.
> This summer I was lucky enough to intern at NYU Secure Systems Lab[2]
> mentored by Santiago. We looked into how signed pushes work and how
> we can use them to increase the security of git. We encountered a
> strange error in tests which resulted in a patch[3] and I wrote a
> python script to verify push certificates[4]. I was pretty surprised
> to not find any push certificate on the remote repo after I did a
> signed push, hence this RFC.
>
> Anyway this is my first time trying to contribute to a large OSS so
> forgive me if I make any noob mistakes.

Patches are very welcome. Everyone was a noob once, but that
changes quickly.

Thanks,
Stefan

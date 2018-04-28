Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50FEC1F404
	for <e@80x24.org>; Sat, 28 Apr 2018 07:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933456AbeD1HpT (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 03:45:19 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:53502 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933450AbeD1HpS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 03:45:18 -0400
Received: by mail-wm0-f53.google.com with SMTP id 66so5770474wmd.3
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V3UPzM08TsASsl+Hy1hMMVZhQo96tSnicYhrSTOrViY=;
        b=bR6S4PNGkg/OeFXZLkIjU7UR9VPL/rLQPSAC10kTpWiDoOFB+acsEIEzMq43Paar76
         yJze8ZFFTBpNdaTctHNUBawq+kSBzHnvKOSlOUhDLbo3gKmIjCEQ8Gm7tSQoV8KFEy7E
         T4ebScESDHBrU7kBCHmtPeC0n3UuV4FRRaksha/jawhtuQNTrfVAqx5BuhTcs7kxhR+8
         OijHisyNVi8CpvxoBn/8/4kRln3gZCChU5F4qsNz+34iBcqNQwGDUijf+6k1G6Ewu8iu
         gRaH2sZsl9GDhyCqQEn4eEKoiiBC9jAWPJ1UUVvzR4lGco/anDN7Zk88uKEJdJblJluI
         8ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V3UPzM08TsASsl+Hy1hMMVZhQo96tSnicYhrSTOrViY=;
        b=DwnP/dPux+B0FXzbJLQDuWUHXHFl4SCUrIDdsEyoPhIqQ+jNetgHMU3TqSw+q+Lmbp
         1H+9i1HiR155EhIdRYAfrGsPIscL0XUG0oEwrVi4PTyHalj0oX6P3WSMrVlqHOCfFd7Y
         HiMuPH+L8DShMpvFFX7Z3WDXNAcB+RRDAWNZ2wLS4igWGcq4Sn8GG3B8BIX2HDds1RlN
         k0J7P7zU0Lx16r+ODRMlQhV5d3KHLeXAZdOkQetHdzLVljO4ugo1Qh7915MCm8mnelrx
         rF/8vxz/KGrqkoYM9TKhz/dlH8L5/qNLFHJ63EUdtHYC0Wj0BxB7M3SGTp272jLogJyw
         gqnQ==
X-Gm-Message-State: ALQs6tBgz4dejVgqiGXYnQ1nb7gQvxLj59mLEOokDKCGZNHIcxs8xJMg
        67bbpd//MPXSDewYX1x4r8R7yEG7ZzwLv2rYacE=
X-Google-Smtp-Source: AB8JxZq/UuX+4jmSXINDm1Y7oq8Q3gTTwyuP8ipgaNwAES8cEY5I2J5M4zP4LMKM38poYPHjKYBc+iiXXVh6T/AyE5s=
X-Received: by 2002:a50:d002:: with SMTP id j2-v6mr7037317edf.44.1524901517111;
 Sat, 28 Apr 2018 00:45:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Sat, 28 Apr 2018 00:44:56 -0700 (PDT)
In-Reply-To: <d4d8d8208b6a41c380ecf20807763bcf@XCH15-05-02.nw.nos.boeing.com>
References: <d4d8d8208b6a41c380ecf20807763bcf@XCH15-05-02.nw.nos.boeing.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 28 Apr 2018 00:44:56 -0700
Message-ID: <CA+P7+xryOt_-vg7cpvqRapM7nWuhWXjhpUR1xi-5MY_RH5UwAQ@mail.gmail.com>
Subject: Re: Branch deletion question / possible bug?
To:     "Tang (US), Pik S" <Pik.S.Tang@boeing.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 5:29 PM, Tang (US), Pik S <Pik.S.Tang@boeing.com> wrote:
> Hi,
>
> I discovered that I was able to delete the feature branch I was in, due to some fat fingering on my part and case insensitivity.  I never realized this could be done before.  A quick google search did not give me a whole lot to work with...
>
> Steps to reproduce:
> 1. Create a feature branch, "editCss"
> 2. git checkout master
> 3. git checkout editCSS
> 4. git checkout editCss
> 5. git branch -d editCSS
>

Are you running on a case-insensitive file system? What version of
git? I thought I recalled seeing commits to help avoid creating
branches of the same name with separate case when we know we're on a
file system which is case-insensitive..

> Normally, it should have been impossible for a user to delete the branch they're on.  And the deletion left me in a weird state that took a while to dig out of.
>
> I know this was a user error, but I was also wondering if this was a bug.

If we have not yet done this, I think we should. Long term this would
be fixed by using a separate format to store refs than the filesystem,
which has a few projects being worked on but none have been put into a
release.

Thanks,
Jake

>
>
> Thanks,
>
> Pik Tang
>

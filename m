Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C30F41F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbdAYX5q (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:57:46 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34084 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdAYX5q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:57:46 -0500
Received: by mail-lf0-f53.google.com with SMTP id v186so137618217lfa.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 15:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nr0VfGmBJoosyyspaKY2HtxA5NW8zy/2nVsJPmbenyI=;
        b=H335K6AfGtFR5vqDH8hfiRxfqLinAyGpxwRfL+SwInevXEKWKk2G+PA3SMC+SsGxkv
         VzckzEX6EXTm8hTNYg4eEMSMVn7p7nhldy5YPjQc6sTX+cU7aNkTXmp6CgROGgC2FdCZ
         ACQRi4CYq8ctZj62123sFYCVMOeN6bQ54P/H4ZGN+MRnKncIXeNhPNyEygJCWxyJLoxD
         Pl5O7U9TvZ8EhvCr+XU4uvTvNAj6PpY1UO2PWrZySFYeV6G4LPluTWntTkSQGic37Rjw
         zYLYbY9C3WdWQsZEQ8/KSnZ0Gsy5sh7UEACWaPa5owwktV3NGUIAQU0V3pawTJCoqNtH
         4QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nr0VfGmBJoosyyspaKY2HtxA5NW8zy/2nVsJPmbenyI=;
        b=ClzXoMvYRHZcmCXn1fHmqXHcgo16ztA8gwthNw+euNkGmX2motREYAlgD4w0bKNVwh
         zEq1AgXAcC1CCV52Q/x3S3XKkAgwfpT+v/cYJwNlyWlFTy9BaKj+JtTLoRNi7iT2UtIw
         JPolGo2NZd5GaFpVucCE4x/0UJAA03f5UpVTiD97DewF72tV6KUQPDRkpJ8nLiVrpW9S
         z2oZlZ4LDQ4DE3UXXlBlDkIs/me/XJILE+M18AZl90YGTm1x+IwAyc423WIQ5sAjDviH
         vMvtIe31tBWrIM6EtspmxyLyU6+God2Jf8P24CUciUiVD1WPYaQj9ZKL9fHIv4hRsTsR
         ilfw==
X-Gm-Message-State: AIkVDXJPjBuUd42SpICaIihA1eBwxJKeCgodwHVdZ3cXMN2de/cwRE/zLXyV/aEB9Um0vJhIOOkVSjhCODiUXw==
X-Received: by 10.25.145.90 with SMTP id y26mr731lfj.49.1485388664371; Wed, 25
 Jan 2017 15:57:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.20.193 with HTTP; Wed, 25 Jan 2017 15:57:23 -0800 (PST)
In-Reply-To: <xmqqh94m7leb.fsf@gitster.mtv.corp.google.com>
References: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
 <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com>
 <CAE1pOi3eh7ao3NocV=PRFDby8y5ttjFR=-_VB0FoJv4MpjExaA@mail.gmail.com>
 <CA+P7+xo9WBwHjAXeUTn4bh=F6hvw1gA-79h-GmwQoeRpeLj2jQ@mail.gmail.com> <xmqqh94m7leb.fsf@gitster.mtv.corp.google.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Wed, 25 Jan 2017 15:57:23 -0800
Message-ID: <CAE1pOi0CgfxQTygg_i3dc_-_Lb8qgOOk_0hg+goJvm7PyLZseg@mail.gmail.com>
Subject: Re: Force Confirmation for Dropping Changed Lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 January 2017 at 15:46, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>> Mmm, that sounds complex. The "my-code.x" is made up so I could keep
>>> my example as simple as possible. In reality, it's Maven's POM files
>>> (pom.xml).
>>>
>>> So there is no setting for any of this? There is no way to switch off
>>> auto merging for certain files?
>>
>> Not really sure, but a quick google search revealed
>> https://github.com/ralfth/pom-merge-driver
>>
>> Maybe that will help you?
>
> Its readme seems to indicate that it is either solving a different
> problem, or solving the same problem with the opposite goal in mind,
> in that its goal seems to be to forcibly resolve what textually does
> not resolve cleanly by choosing sides with an arbitrary policy, so
> that humans do not have to get involved when they ordinarily would
> have to.
>
> Hilco's goal sounded to me the opposite---to force conflict even
> when the two histories did what textually does resolve cleanly and
> require humans to get involved even when they ordinarily wouldn't
> have to.

Yes, unfortunately, you are correct. This seems to do the exact
opposite of what I want.

Before I start learning about custom merge drivers, is what I want
even possible? If yes, would you happen to know some good examples of
(custom) merge drivers? (Python, Ruby, Java are all okay.)

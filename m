Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7FE61F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 22:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeKZIxq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 03:53:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46017 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeKZIxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 03:53:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so16933198wrr.12
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 14:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eVkD5d9fS9lK9aMUHRjpgwLexWBnFWMSIgRrCTLJ/7U=;
        b=RneD/cvJaqc+F+ng7am8A73lwHQQ2mkZhdGnP/rTDLDK0xuX0C1xZUcoCMu/Srfksh
         CVa+gdTjF/uaavIiDx2B/6wwWZaH/vMPkR6WHJBWABR5pGyah+ywWYWuzw0GySOKt2LF
         EAwSARULnsj3iLx4sRz4xMahv0eJyFqxxnk8Md0O1jT8XX+2iqjnH16KZEokl2IQBg0y
         VN1gWlg976c6nkvgQOQDgx+szlo7rPaVDUKNcYvt9M1rgDxlUjpxLv4+SjBhiAgmUupM
         VMQ09TquBAVFsLrEmHoiGCS5XqZF8IuAaUw7+F1Cb6JTInOlv4NgvXOL5ewlw2ty3uxw
         MZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eVkD5d9fS9lK9aMUHRjpgwLexWBnFWMSIgRrCTLJ/7U=;
        b=n2MFAYW1JTa3UQz/FUn95Frgsbh6bXEUzg+b3dq71XNdAC3U6Xemq5YQJYThPDERjA
         gjCCn4SuxU2Gbk9QFvokd05rfw52s8BujaF/3mrybi8a22TgZcCB4Bc0GRekB6j1u6ST
         kqpQv4scQZP0xBhADrYka4/lwtbWGncf89XkhUUeH0nagU13QYrut0BMG0eq8cRfLOTg
         ObEUccDS5LKYUye93COmjyJGVP060fLFallEKvoEZuvh8UhYx1ZUvqQB7xWeRNOZViEd
         M/o0myFIynE86GJ6bdS+nl/mOO5YUgm40NxmjTYvGKjixMTcHkuYJ1S6DpedSZMkxSX5
         6H9w==
X-Gm-Message-State: AA+aEWYfV2rLZNUlBRwk6JcVeAFvL3DhTipeW/46mS4jKAI+PopHa4R6
        1CZ8H2j3YzMvrM7SG8ZrA1aBHiEj
X-Google-Smtp-Source: AFSGD/WoDIedzYP/RteCJCZZLrP4HvKjTNkgafN0jVP6lmMEpkfH7GKvK2B64QFyCWtg2AA8WuXs9g==
X-Received: by 2002:adf:fb8b:: with SMTP id a11mr20680939wrr.318.1543183299660;
        Sun, 25 Nov 2018 14:01:39 -0800 (PST)
Received: from localhost ([31.127.45.106])
        by smtp.gmail.com with ESMTPSA id 142sm6045908wmw.27.2018.11.25.14.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 14:01:38 -0800 (PST)
Date:   Sun, 25 Nov 2018 22:01:38 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>, szeder.dev@gmail.com,
        Jeff King <peff@peff.net>
Subject: Re: t5570 shaky for anyone ?
Message-ID: <20181125220138.GK4883@hank.intra.tgummerer.com>
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/25, Torsten Bögershausen wrote:
> After running the  "Git 2.20-rc1" testsuite here on a raspi,
> the only TC that failed was t5570.
> When the "grep" was run on daemon.log, the file was empty (?).
> When inspecting it later, it was filled, and grep would have found
> the "extended.attribute" it was looking for.

I believe this has been reported before in
https://public-inbox.org/git/1522783990.964448.1325338528.0D49CC15@webmail.messagingengine.com/,
but it seems like the thread never ended with actually fixing it.
Reading the first reply Peff seemed to be fine with just removing the
test completely, which would be the easiest solution ;)  Adding him to
Cc: here.  

> The following fixes it, but I am not sure if this is the ideal
> solution.
> 
> 
> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index 7466aad111..e259fee0ed 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -192,6 +192,7 @@ test_expect_success 'daemon log records all attributes' '
>  	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
>  		git -c protocol.version=1 \
>  			ls-remote "$GIT_DAEMON_URL/interp.git" &&
> +	sleep 1 &&
>  	grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
>  	test_cmp expect actual
>  '
> ----------------
> A slightly better approach may be to use a "sleep on demand":
> 
> +	( grep -i -q extended.attribute daemon.log || sleep 1 ) &&
> 

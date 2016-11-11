Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208A120798
	for <e@80x24.org>; Fri, 11 Nov 2016 23:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936449AbcKKXOu (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 18:14:50 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35748 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbcKKXOt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 18:14:49 -0500
Received: by mail-yw0-f195.google.com with SMTP id b66so2416000ywh.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 15:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lOX+lFoSJMbOlYaeX/2cV/Uc5pS7Q7WIiTpE66lTrtY=;
        b=k5D2RfjY5rmvNydKnISBZBulRt48vrepW7zisqPBydoYHT8c9emQld4Rv8oPUFUpQq
         BC+SQ2pzy+Th4kww1CsAJFX0mtU8gzNz4R8eKicRdZIa8At+kQS6618G/Yr8oCroGtRS
         s7EyUZDinDMtKt+PodtGkCoCTxSCfiDDWydgPD/jhSkgqasAo7wIdygV7et3FeTYTbmU
         mPJJVLv8MdgiEVsRDHg9vb2QMMg2dr7wKu1hmZl+wmFys2lccIEZ/md85I6pSV+ws9ku
         7eli8p8YeO1apAcR3sY3fnSU8dy0f8eY4RMHxGA+ZDqtAwzdGJ6GPb0EXOLe3KZsnvxG
         aBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lOX+lFoSJMbOlYaeX/2cV/Uc5pS7Q7WIiTpE66lTrtY=;
        b=Rsu2wkQ3h6saHRHkoOJq5KveqprOXMu3kW3efzts0jc20C1BWsgnn7Ucy/Nd7GHEDz
         Tmy5/P3qKCKLhib2knLkZwXR4miVFny+bJHMdVwugDuTnBMsdzqcvcwMg7ES/Aju6Rgh
         /KvYqxzyRBOw2xmAWsW4y00LNBm2W20oMc5ueqe9eLCPth3pe9Ak9LYEQo9Wv+P+Zhf5
         LsJjtmLSpKmBuzhM/8IXhxjlbzKB8TX1yobeLZuuqT8CFbrjGbNYHpJYDtyjZZHzjcgk
         si6mBnwnBoD5A+uTQmm72uC9JD9YiBr5qpNWJ3Ky6sOwvP7HueNXQaHcc3h3NVT6tTwm
         eHgQ==
X-Gm-Message-State: ABUngveEIIjAJanE29NuF7bwupvuaeXmOx1ro39lzQmUc0RDL++FGlNTJuWzyP/Qd3Lxp9QDUxQi0o6lgPZxXA==
X-Received: by 10.13.254.71 with SMTP id o68mr6151034ywf.318.1478906088885;
 Fri, 11 Nov 2016 15:14:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Fri, 11 Nov 2016 15:14:28 -0800 (PST)
In-Reply-To: <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
References: <20161111201958.2175-1-dennis@kaarsemaker.net> <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 11 Nov 2016 15:14:28 -0800
Message-ID: <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>
>> No tests or documentation updates yet, and I'm not sure whether
>> --follow-symlinks in other modes than --no-index should be supported, ignored
>> (as it is now) or cause an error, but I'm leaning towards the third option.
>
> My knee-jerk reaction is:
>
>  * The --no-index mode should default to your --follow-symlinks
>    behaviour, without any option to turn it on or off.
>

I agree. We shouldn't have to specify this for no-index.

Thanks,
Jake

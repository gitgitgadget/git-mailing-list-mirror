Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71B320372
	for <e@80x24.org>; Mon,  9 Oct 2017 18:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755309AbdJISkf (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 14:40:35 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:43663 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755214AbdJISkc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 14:40:32 -0400
Received: by mail-qk0-f170.google.com with SMTP id w134so24499019qkb.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rF/z3wqUq/KHpy8zQeIsIQuc6rPEaXCb+iDvj3GEg0Q=;
        b=Fbgy7phGWssd6GNLn/L9b0wjrWfk9UBDLYifJTn3eBfJ50Y4BtLcMUVL5cEEPgK17Q
         XyfoQimKr0+iSAzxHFquBYihedd7io6Ccsq4DgzHKALwVWmtPdU2vQtwGpnV6NHhTDK3
         5E5T/Qj1JJjcNpDkT/bcXrCRJxSrdhHlVnOWZc22BouWwyRyHS4C4pI9CwGwP0MfZLnp
         GogoZ8krHvYCJyhDuzZ0xzoucsBj1vr8ONcGCQKZaZVYDcTPgjkzrO3zIauqvVZqVOH6
         8DFD++Gsa2TOJJ8mgXOvT9Hsv7g0zPkNspe80WVndm2i0DyddGARFAKb+bXe+8zC5Ovq
         fxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rF/z3wqUq/KHpy8zQeIsIQuc6rPEaXCb+iDvj3GEg0Q=;
        b=IOBtdbgDBcfo0upEWqAuCAwCeMDNm0KLp7VvNI3i1odAdoyJG97A+YHRr0aaAr5cQy
         y5K7gE+5ePgnuo9QaNME4sWP09NHaq+xN6VumEK7WVPCwtwi7BrPD5wqd2OoHc5cX1Fy
         az4AmUQflq7sOrLsP7ZdP5+d/vVAjaLfAHBUrUigz86ggFjtlXA9CiRGTvhqS78YNF+q
         SKNwWvIFBOv6i+hkkxQBXBbap/mW3+jlCMSLgJ4IRvjJJhY+RupuaCmDsneNekY6ySTq
         a3Fq30vKdCyhj29vRz1K7octCknVnQ44I825WfW+4aUOZMfOm2zrMhIxpT8KfFhdh1Ar
         rvpQ==
X-Gm-Message-State: AMCzsaXtu9EZbqXwH0dZljrgxWkPtx+2EAu/N8J0J1Q2QPNxvn5Uv2z8
        /d+v5ih14NaB8HKxjQCTrofGk57UKxgPxGJe7s0VFw==
X-Google-Smtp-Source: AOwi7QBhhMK8mEpnz/qEfGPpoe8/fNTl/e6YlSsk3yS9M1JhWfr0iMdT2/Or/k5WWQs715jGefj6xRkJaxYtYseUDQI=
X-Received: by 10.55.56.14 with SMTP id f14mr11052710qka.286.1507574432204;
 Mon, 09 Oct 2017 11:40:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.47.238 with HTTP; Mon, 9 Oct 2017 11:40:11 -0700 (PDT)
In-Reply-To: <E2CD2BA7-130B-479B-84DF-A7AFA0EBF30F@gmail.com>
References: <20171005200227.8028-1-johannes.schindelin@gmx.de> <E2CD2BA7-130B-479B-84DF-A7AFA0EBF30F@gmail.com>
From:   Steve Hoelzer <shoelzer@gmail.com>
Date:   Mon, 9 Oct 2017 13:40:11 -0500
Message-ID: <CACbrTHeKw9fN6uARHsjyKZe+B839UHSqbNhgzz=0Dk8_VCZE-A@mail.gmail.com>
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.2(2)
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 3:22 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
>
>> On 05 Oct 2017, at 22:02, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
>>
>> Dear Git users,
>>
>> It is my pleasure to announce that Git for Windows 2.14.2(2) is available from:
>>
>>       https://git-for-windows.github.io/
>>
>> Changes since Git for Windows v2.14.2 (September 26th 2017)
>>
>> New Features
>>
>>  * Comes with BusyBox v1.28.0pre.16467.b4c390e17.
>>  * Comes with Git LFS v2.3.2.
>
> Just a heads-up:
> Git LFS 2.3.2 contains a bug in the `git lfs clone` and `git lfs pull` calls:
> https://github.com/git-lfs/git-lfs/issues/2649
>
> I expect 2.3.3 to be out soonish.

It's out now.

Steve

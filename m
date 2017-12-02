Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366E820A40
	for <e@80x24.org>; Sat,  2 Dec 2017 15:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbdLBPf1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 10:35:27 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:36429 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbdLBPfY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 10:35:24 -0500
Received: by mail-it0-f52.google.com with SMTP id d16so5562241itj.1
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l5mVRT0ZXdzni+qV2+NCD68JNqYkMVjsXk9+SJcC26k=;
        b=URkqIiwiIYPO3sgijl0PNMeEvELrLAN1tf464Fs6XMHStAJRsX0bqLKM+dO6paOlZP
         IKTc1kWh/Thj80NIIOzYcvP9hdoV2oWWo9hEPeYT7i5HSAXKplKUgezzfy2aNxJzoT5i
         J11SneCfA+8cBtFdnWJD+B2XZVQUUFFn8oy+V/HXRH3DcGGb727FcnLaCEtLyOsFliGw
         eY+KxDjVXEXxpKCmg0cOt110iLjZQ/4z0ZSavUhCyz3iRZ9nhYiWqbfICJU4G68aNsgb
         PH9KxtirFsrQwwO37g0F81MxVDA7a/Y26C6YNDVp1VEeHuC203AJHY/HU2Xz1Q61W4Mf
         hHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l5mVRT0ZXdzni+qV2+NCD68JNqYkMVjsXk9+SJcC26k=;
        b=UJBgPx8nHtLJt4jf/nrEfoZ2XJNKhlvpi2a+xmiRNP/2ZhavZ2yncbzuZmdiF06wFW
         YtJq+9SAVu3/mnWk9YneM2jJzJX/8vwsAieK7J6bwatkRkt/scWWZee+90QBtNWIGnHw
         75rw2Om1U1DA9ZCyaqa89ljaunLXks6OBxTQby5X9Xd5kAzqWL67+dI8bzVhjwr0fSza
         eZsw+/ovjwLuWGaPjFbO1RkoSBU174nGxiH0wCY5O61VSp4DI7tfopVX0cxHUbNQ+nLe
         Dwb+lrPd2XnC7mzeZVOsMW9dsuqC8/Fj60rRhqQQ0jrGNQkS5mfJZ1PwNtNG+GjU/du/
         V7XA==
X-Gm-Message-State: AKGB3mIQ6+M5ZFw7F5txa/wPCQm8ZCotavL/khIeTCeLlJyjq+W/gET4
        szd11JcfgfSMoqgB2hP3/uj0lvhYFQ0Ie+xL0f0=
X-Google-Smtp-Source: AGs4zMb9YB75XZ5Mdfw90YZbh1uwlDvBU4Brgk4GTZdHhb6dWQ3ARFduVeUhDYSKzlPZKyJi6dwVQ+GzToBPLPP9xEk=
X-Received: by 10.36.1.4 with SMTP id 4mr6518069itk.59.1512228923692; Sat, 02
 Dec 2017 07:35:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.36.169.76 with HTTP; Sat, 2 Dec 2017 07:35:23 -0800 (PST)
In-Reply-To: <A6F43B7B-F0AF-46E7-B34B-7D54493E2C8B@gmail.com>
References: <CAL1_K8AYf1jKDO8+czcqkUxDAuOODgKv9avaiikWi+4zpqenMQ@mail.gmail.com>
 <57A92686-9161-4234-8341-CD6FAD7AE049@gmail.com> <CAL1_K8C3bNMae6PFk73c7n6AvnbO=5Sujz3oqL_jBj=DpiEO1g@mail.gmail.com>
 <A6F43B7B-F0AF-46E7-B34B-7D54493E2C8B@gmail.com>
From:   Patrick Rouleau <prouleau72@gmail.com>
Date:   Sat, 2 Dec 2017 10:35:23 -0500
Message-ID: <CAL1_K8A=7xmLCYzWa0ejtwjy9P+rD+D0cqz+kOXCaQWOgQfuEw@mail.gmail.com>
Subject: Re: git-p4: cloning with a change number does not import all files
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 1, 2017 at 7:45 AM, Lars Schneider <larsxschneider@gmail.com> wrote:
> Oh, I am with you. However, I only used git-p4 for a very short time in the
> way you want to use it. Therefore, I don't have much experience in that kind
> of usage pattern. I was able to convice my management to move all source to
> Git and I used git-p4 to migrate the repositories ;-)
>
> Here is a talk on the topic if you want to learn more:
> https://www.youtube.com/watch?v=QNixDNtwYJ0
>
> Cheers,
> Lars

Sadly, there is no way I convince the company to switch to git. They
have acquired
many companies in the past years and they have standardized around Perforce.
It is in part because they want access control and they need to store
a lot of binary
files (including big VM images).

I keep this video close to explain why I like git:
https://www.youtube.com/watch?v=o4PFDKIc2fs

Regards,
P. Rouleau

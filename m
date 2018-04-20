Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F07A21F404
	for <e@80x24.org>; Fri, 20 Apr 2018 21:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeDTVjL (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:39:11 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:33300 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeDTVjL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:39:11 -0400
Received: by mail-yb0-f181.google.com with SMTP id y5-v6so3524539ybg.0
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GZRE/TUj3cWrXt99mQIaNo9PKtau2zzI39M1v/JUsII=;
        b=sk9pOWzWwOhJ+RoQtukkTBMK/8nU+7L0D2dsvOs+1qzH4Gj7sVCQhj9JKufu3lQTYp
         SkXrTRq/FTyrwIDH/4Z6DM/4XHbXEEMN/I8B7HnAsatMm5ZJf4ihUAmR2djiN3J4NCnA
         rCzPF5Ujg3Dl9FuUX/vvHtXRSoM8zc0MwQBd5i/kwSZw73Ht/SWs8nhqO1XSvv0RXPsi
         ufs7Pp1XMx+xlLvpYb84/QShgBNSLlskT/VMFpp6E/QOoz/2TvmJfNvMFRMOB6RMcrsJ
         q8musGsIsMk+ft7g+LsVqLdyVvN1P6LgtAGADa3Ib/VYuvBlDd/hRIDjvaL2xQk2DzFc
         mO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GZRE/TUj3cWrXt99mQIaNo9PKtau2zzI39M1v/JUsII=;
        b=muUZDL1jrJmP/5OKaRaU8py51AtSe5D+rHnVTdYS/zSbF+1auM5jrGOeG0Luk3ykxF
         DfhNAKhkbbHto8jTlghQsGTfw7u4Umwg1KDOHogDQ1vl7pCtj5z2CvJCXLqWG7lul4sk
         loBGO1gtV72BbpfjhSNiAf9EB/0hFixWP2wVYuoUIs11G2MCA9kip1XrWEMyPenExZOf
         YwEuPhlLCBqCL+bB6jpLXTSk2UWjCPytWXBnKYgh71aYqmyuyCLYsi2Ka+RJAji8WLWy
         JRPGJgTwBlxowPnDSgTYfqh5nI6GbiwT12CBNVWHAZqpYxXa9aOnhBTnrOQ4vnv8JE7b
         FFBw==
X-Gm-Message-State: ALQs6tD7i4SObJVaWG+qSd+UdB+jyspdGtD5WE0BAt5cL0TUNt5Lxfhy
        b6erZmsEAZuKNmqmT09SQADEWKEy35T4tKhilETpjQ==
X-Google-Smtp-Source: AIpwx48RBgxSlpX5NaJNDLiaYrcjB50QKNIl8I/pkfYqelBZyIL0QpzC+eJb6qnmSdawH788CuD02kCT1uk4QNeYV38=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr7170515ybc.307.1524260350062;
 Fri, 20 Apr 2018 14:39:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Fri, 20 Apr 2018 14:39:09
 -0700 (PDT)
In-Reply-To: <CAMSYVsc7c3Gw7OYLDRi5GiZX1m4Cx=eGJJUutRTX9Bn=z9EDMw@mail.gmail.com>
References: <CAMSYVsc7c3Gw7OYLDRi5GiZX1m4Cx=eGJJUutRTX9Bn=z9EDMw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Apr 2018 14:39:09 -0700
Message-ID: <CAGZ79kYuhFPW6SHnPDB6iTcn_Bf29Y+Rn1xKB5AyOvibyz9yYA@mail.gmail.com>
Subject: Re: Feature requst
To:     Yuri Weinstein <yuri.weinstein@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 2:31 PM, Yuri Weinstein
<yuri.weinstein@gmail.com> wrote:
> "git grep xxx" currently does not follow symlinks.
> Please consider adding this functionality

Is this related to
https://public-inbox.org/git/20180409090047.lfru2ul5fbnggfg7@bod/ ?

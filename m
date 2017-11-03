Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A16020281
	for <e@80x24.org>; Fri,  3 Nov 2017 02:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964926AbdKCC1c (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 22:27:32 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:56848 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964891AbdKCC1b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 22:27:31 -0400
Received: by mail-qt0-f172.google.com with SMTP id z28so1685866qtz.13
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jS2RRM37rkx7iSYpHNOQW1bXDSGeybpGCmEnNmd+H0A=;
        b=p2cq4JAhXMLX4lSok99Z/7I8nbNvVw2qKe0YziHDGykkQa0opoqcaFskzXNugMfkeL
         EnF4GM+gx97X2TMZKV6EHrnXIP3ehSNE8VXe2RBfKr9HuE0+DpnZfhBAfIcwGBXQIeKb
         cqgVoJh/LRD2i28PzuQjPIDB/6AgB4vZRaYH8oglVajIw6C+pifk3IMyhdMqsXULFFnQ
         KwwTglFnbz52dQwsgslugllx+Y8cp3vXHEVo32MpI4iTF2bp7TLhMrqsv3lmFm1xucU9
         wKZyi+H7qB2YDWVWFLobvearZf2TsC4T/69Xiok6lAr27Drl1+YhWzIURCpluVssgisT
         8GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jS2RRM37rkx7iSYpHNOQW1bXDSGeybpGCmEnNmd+H0A=;
        b=QN5+R47vYSPYJHo87RJ+hMSpNj1Cehs59LJU9+a2YdzYjiWdRrwxyrWBBpIhsLRg7s
         jHj9lbBROQr8UA9QvfacGP928AtOwOwWLcK2k/An3GgxrKrnn42NDixcX7h4dl5/nEDQ
         nehOoUWfLHFfcOfD5KdE+XazpduUa0uhjCf0dHgrQpzOtA56XuCfWTGfF+G0Dr8Bgvef
         rFKlBtzXgAkVlGBwHRQJKbBaeva1CmjRmXygl426SLyHG90rfPZ+n+RRyKllF6yiNuJo
         0UGgTP0mXaAnyriPw/hfcy9mdw2h+k3kgm3AEjtu4yewmeugLonX/UPIzLesVhBihZPE
         DYZg==
X-Gm-Message-State: AJaThX5eVfmD+6bSY75Pp5rzC2h3mck/RgOa23enQ7UKG56a+ppFBF3q
        ladgGf6QPlsgRKfBiH5k0PzmP0sifdasqGOTQS6mjw==
X-Google-Smtp-Source: ABhQp+TBr5gO2/7eF9+R2H33XHw3JiNy1HzE7pRGk5ZoeeVvErnlfw8GrKPnBd/BEMOG4PEFquyKCaZPZpPAjbLOcb8=
X-Received: by 10.237.34.201 with SMTP id q9mr7982700qtc.198.1509676050676;
 Thu, 02 Nov 2017 19:27:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 2 Nov 2017 19:27:30 -0700 (PDT)
In-Reply-To: <CAM0VKjn7=eCZpz-naWv5SjrpjXFs+wVCOXLN852cfvSoZTuJrg@mail.gmail.com>
References: <20171102000722.1503-1-szeder.dev@gmail.com> <20171102181048.16417-1-sbeller@google.com>
 <CAM0VKjn7=eCZpz-naWv5SjrpjXFs+wVCOXLN852cfvSoZTuJrg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Nov 2017 19:27:30 -0700
Message-ID: <CAGZ79kZaCwU8S8R-nAzCcV=izpTnsbZsBjJLpoWkid2AF54f9g@mail.gmail.com>
Subject: Re: [PATCHv2] config: document blame configuration
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 6:26 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> On Thu, Nov 2, 2017 at 7:10 PM, Stefan Beller <sbeller@google.com> wrote:
>
>> +blame.blankBoundary::
>> +       Show blank SHA-1 for boundary commits in linkgit:git-blame[1].
>
> This is still SHA-1 instead of object id (or perhaps "commit object
> name" would be even better).
> Not sure whether oversight or intentional.

definitely oversight.

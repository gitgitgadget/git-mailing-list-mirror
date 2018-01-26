Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4271F576
	for <e@80x24.org>; Fri, 26 Jan 2018 10:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbeAZKcP (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 05:32:15 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:42953 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeAZKcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 05:32:14 -0500
Received: by mail-qt0-f170.google.com with SMTP id c2so101870qtn.9
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aU9J/S3r9QjE++yg5ACRHfjsmVbnSWlXDD4ko9RU4qQ=;
        b=dRltAm8IoHst5jEmyasBrWucKmNwmaMv+MYyrQPJY6oCngv1zRW8Oi5U7kfo+jfbXn
         IV9cAyYK8820M66cS3zNMbozP+jWkUQ9HVWDmRQbnaxfHmkKro4anIhm544j1PFunWrX
         Qss0MYu2awbZW5Z5yz2dLUZB5gyP5MVP5Hns2gdMPi1ZBrSjk6f135ZM+g0eVrGo4rbT
         W4haYNF5s9PUi0hnZ02vKLUb0F0e3mYhe16JNVlKqxuaJqr+sDCp7Xi1YykLkM8ovdZ7
         Vy8DsNA17dFTbttYzYRf1whWMDYvmmgFtCjwrLpjRYx/TorrNywKqjySbWh59+9XHeZL
         xNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aU9J/S3r9QjE++yg5ACRHfjsmVbnSWlXDD4ko9RU4qQ=;
        b=af3xzuvPkzO5+UwQsijw/CACglAddVWHhkikjHZuTEy8L+KH0tzIJGHV2s3RVb3oAM
         /gTJbM9hC1cPSE8rYsxkb4+SzDtu2+oheSRNa6Rb8MNWBad5MOza4sG6KwSGEl12mLJN
         IPhlOMmcbzo/Vrj7V9lXWr6GATrHpBUZJ0dJsibmfg9s0YCJhhH0OIMI9oDcVkyM2YHW
         bEFAytw+hotrO379GyZBodITv8yLe5hyHUAT+FZzyKCn8Rx4Sq92ApEc++HGaAk02a1C
         He4ggpBwlnS6vWb4K6oYFQJqISKVuKnmeb/rQUC69eWG6k8R58lfgQPMQvZMvmvLRIjh
         usEQ==
X-Gm-Message-State: AKwxyterzSXfjVcOFx0/Qo+wg+f5Ewye6g6sl6I9/0HP5KI7HEciF/ki
        nIBxWhQVF7zO1RBw1swPuvTtBxVNVoyiYdeWrXFp3w==
X-Google-Smtp-Source: AH8x227YHwhQKbinCeXuETPCgeuKFASnsN1cGDA2DkLzix8Q1BPtKawYsWuW4u9aCcdkjlwIKJu2CMFv5EDD9B0v2sA=
X-Received: by 10.200.26.69 with SMTP id q5mr21291747qtk.174.1516962733552;
 Fri, 26 Jan 2018 02:32:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.54 with HTTP; Fri, 26 Jan 2018 02:32:13 -0800 (PST)
In-Reply-To: <CAP8UFD14V-3T0kV=VxYLdozGp5yT-Rzio7PiY8sFn_rVUDxnjA@mail.gmail.com>
References: <CAL21BmkTbr9qYK3+bsbwh9aDQ1twqrNkyUdbaFPSAn5y7ov40Q@mail.gmail.com>
 <CAP8UFD14V-3T0kV=VxYLdozGp5yT-Rzio7PiY8sFn_rVUDxnjA@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 26 Jan 2018 13:32:13 +0300
Message-ID: <CAL21Bm=h4o5k2mQ7vob3m-6N-YZ4Rmr5X3_w90ifpR53_+Wnyw@mail.gmail.com>
Subject: Re: Please review my code
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-25 23:22 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
> Hi Olga,
>
> On Thu, Jan 25, 2018 at 6:20 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>> Hi everyone,
>> I haven't sent the code by mailing lists because 25 commits (every
>> commit in separate message) look like a spam.
>
> Yeah, so now that you added tests, it might be interesting to see if
> the patch series can be refactored to be shorter or to be clearer.
>
>> Please look at my code:
>> https://github.com/telezhnaya/git/commits/catfile
>> You could send me any ideas here or in Github.
>
> I left some comments on GitHub. My main suggestion is to try to get
> rid of the is_cat global and if possible to remove the "struct
> expand_data *cat_file_info" global.

Thanks for your comments, I find them very useful. Most of issues are
fixed except the main one, that you mentioned here :)
I left the comment on GitHub.
https://github.com/telezhnaya/git/commit/403ab584fbf543acef1ecdf279ce31f4fc=
2ced3f

Thanks again!
Olga

>
>> The main idea of the patch is to get rid of using custom formatting in
>> cat-file and start using general one from ref-filter.
>> Additional bonus is that cat-file becomes to support many new
>> formatting commands like %(if), %(color), %(committername) etc.
>
> Yeah, that is a really nice result.
>
>> I remember I need to rewrite docs, I will do that in the near future.
>
> Great, thanks,
> Christian.

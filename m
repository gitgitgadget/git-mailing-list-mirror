Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 836581F4B7
	for <e@80x24.org>; Wed,  4 Sep 2019 00:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfIDArK (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 20:47:10 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:38766 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfIDArK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 20:47:10 -0400
Received: by mail-ua1-f48.google.com with SMTP id 107so3982498uau.5
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RPP7XyqLjaY9lUResCEImgykJRmNgBX4x0MXUJbnIE4=;
        b=sRIQQk/maiU6N2gsIDGg9pZCB7iKjLEwNxJVGetR5hySFzdKZZaJrdm7uhFGS9Xv17
         iuksmlRuss1uFD2lmmEHdDYooIDN09j45t1FO4GwORpuwO8TQzE2eSbLfkVP1u634lTj
         KyOjsbzNSVmgGq8pR+k93TVRRBpja3u3syEVc6EtWAfYRuL1LAqV2/swd1xafIWyBDyc
         OhzKZ5I7x44NuJenVMqAJvzQm6dWlDm11v8Pyfv8Dozw6bssqZ3++8mkVazQWv5PWGQs
         v+LGT+iN3ONVv9hJAgqix7iC9tqfBjpcUS+zn9rU89wE+vPgaaWZx79x3bKHTg+kCgqH
         c0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RPP7XyqLjaY9lUResCEImgykJRmNgBX4x0MXUJbnIE4=;
        b=JlFUyCW8S9p7aOF5RGugtwy4U76OV7+GxmHvCpa1oa9JxhOGflJW2ohvbwLZAxYtGK
         hFag6Xwq4tr2Kqcl/VDkDQFPEgFdoB3sKfmYu/lARVCYKku6rWU4Lk2+n/5H6L6BmpAn
         ffUIDNOt6wMPWMV1T0GbF+e1vecDAFf5XoMGcl6d6flKkc8xf6F6ntib6mQ8gROpP7sz
         bdURoKkE2c+ND2iLVnlyPAfbRiUCcS/StxG5ALzE6otFsdcdqvRo+AljiZCkUtjxOGo3
         x4VXHuSXk508WnJN7aj5KUYwQPsmtK0aNcoIqlY+sxFcrGtr7dM1qFxV6RfxF/FELFrw
         miyw==
X-Gm-Message-State: APjAAAWAlgtRHJtHtOzv7Xm8caD9ZW7FImHH6H2+1AQXPP6plNkvLxxY
        HmqkrI9LdBqz2qtuiZ+R+7hl/0S00c7ecB5RdrEDog==
X-Google-Smtp-Source: APXvYqxl5GkBqMjNC90JmwEeb9pD40zC2ItB1RWzTPQ+lugcAlUFyKw80umu1NV/YdeRuvJuOfNPuyeqATkAbPTNHhY=
X-Received: by 2002:ab0:60ae:: with SMTP id f14mr11069841uam.124.1567558028925;
 Tue, 03 Sep 2019 17:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW4d=x51EwwyZ-FhxHgLJNZM5sHLd19mUOuacFrhT_CQwQ@mail.gmail.com>
 <CAL21Bmkadiv-wkdUZ7zsZckz2eHK3po22y2Ry5X+MnEWKAuSZg@mail.gmail.com>
In-Reply-To: <CAL21Bmkadiv-wkdUZ7zsZckz2eHK3po22y2Ry5X+MnEWKAuSZg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 3 Sep 2019 21:46:57 -0300
Message-ID: <CAHd-oW6a+FjhCpH8j2uzZT9vJ5FXbswOcw_tF_mB1aVWPMzCfQ@mail.gmail.com>
Subject: Re: [RFC] Post/tutorial for newcomers
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 3, 2019 at 4:49 AM Olga Telezhnaya <olyatelezhnaya@gmail.com> w=
rote:
>
> =D0=B2=D1=82, 3 =D1=81=D0=B5=D0=BD=D1=82. 2019 =D0=B3. =D0=B2 05:32, Math=
eus Tavares Bernardino
> <matheus.bernardino@usp.br>:
> >
> > Here is the end result:
> > https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git
> > If you have any comments or suggestions for it, please, let me know :)
>
> This is amazing! Thank you for such painstaking work. I wish I had
> this doc before doing my first steps at Git :)

Thank you, Olga. I'm glad to hear that :)

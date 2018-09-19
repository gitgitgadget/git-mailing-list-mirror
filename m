Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 862B61F453
	for <e@80x24.org>; Wed, 19 Sep 2018 15:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbeISVRz (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 17:17:55 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:35070 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732164AbeISVRz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 17:17:55 -0400
Received: by mail-vs1-f51.google.com with SMTP id m26-v6so1937016vso.2
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mb8R/DY+UYGEPnvWtWRqhhfSdKfjlvJzb1nzKDgGhlc=;
        b=RbttF/M+HJo/muD44D8B0S5Re1OxGZRXJf0LVWLWbAR4SALC1Uo+zKfAlOGbokkCIf
         XFJ5farUHRJHWtmf4jWgob91qE9JKrXZxNKuH2owYEDrCjkZq61mz2MOf5LjBpQaAXz4
         qeVJ361DoAolVDzf/9CEcForKeHnOrZF4OYGwu3uDeyGx9DBx5IxztUZTwFxJcv0V+aC
         Rt/44AFfyCQ+kmPhXkuyOdnUme/10LtblBiOusneZZhXnDaxfuPfRKDW2KpWRUwuJY/5
         DyjTHHNhrRTCqx+tyYQmAtF6ovpmYuy5MVyaPKIi3+iK5GEIhTGunt0mighVbMA+H6BF
         88gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mb8R/DY+UYGEPnvWtWRqhhfSdKfjlvJzb1nzKDgGhlc=;
        b=kTADrBKZ2UY8w+CPdYCuPgjBta5M53T29sfma87ZmrtMXiaoFyKqJWcxXBdcl0T55O
         5ekWmqf4QUIiPcEQcqCzLV7egx+n/jfj6j+2twdBDUaK7h6FfAhlHc85heao7btXL/1N
         ZE6hdK787PYdQtzptozRenyZktpsemrjxljwvvcnI8ah0W6SfiUEUHdQwkN3m044E9/9
         ECzYOWwm1IvZtRa9ovCAMML9FhWlFwp90mVH3uUvZ9cvOKx5CNOErp0JMOQKxyXj05QB
         /QZvog9vOOsGujsd4tVCC3fT/N8t7zb36K1rQwGeHTtg3Eeh0oUjEaOwTw1IyXAt8VDe
         omRw==
X-Gm-Message-State: APzg51C9Qqxz15jKrIMOYUZJvwEJ0tHIIwmjSwiofT9UPVIqyaFiU0/r
        qORFIaJ+EWdZCfx6YC7U0RFG4MJZ6DJUwXKbmE4=
X-Google-Smtp-Source: ANB0VdboAtezhxFo1oyfY6cRapiCv2LhZnVTJPY5n9lKMt9orX79kQdIgtB9yP1OLy0o++45eRHGpMweJJA0qrsbkCE=
X-Received: by 2002:a67:cfcc:: with SMTP id h12-v6mr10079580vsm.118.1537371565199;
 Wed, 19 Sep 2018 08:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <1B4739BD-812E-43E7-B7E6-D6B9CD0D0B3A@icloud.com>
In-Reply-To: <1B4739BD-812E-43E7-B7E6-D6B9CD0D0B3A@icloud.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 Sep 2018 08:39:14 -0700
Message-ID: <CABPp-BHQ8Xa24rpxW8CTqkvkh-hFFtb-WLuGZjvZoHP6Cr2WDg@mail.gmail.com>
Subject: Re: Git 2.19 ignores default system language in Mac (2.18 or earlier
 did not)
To:     vasily.korytov@icloud.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 7:24 AM Vasily Korytov
<vasily.korytov@icloud.com> wrote:
>
> Hi,
>
> $ locale
> LANG=3D
> LC_COLLATE=3D"C"
> LC_CTYPE=3D"UTF-8"
> LC_MESSAGES=3D"C"
> LC_MONETARY=3D"C"
> LC_NUMERIC=3D"C"
> LC_TIME=3D"C"
> LC_ALL=3D
> $ uname -mrs
> Darwin 16.7.0 x86_64
> $ git --version
> git version 2.19.0
>
> In Mac=E2=80=99s system preferences I have three languages: English (defa=
ult), Russian, Ukrainian.
>
> After update to Git 2.19 Git=E2=80=99s output suddenly appeared in Russia=
n.
> I can use `export LANG=3Den_US.UTF-8` to switch it to English back, but i=
t=E2=80=99s very weird.
>
> Did not find any related things in changelog, so assuming this is a bug.

According to the thread at
https://public-inbox.org/git/CAPig+cQWW9kibWYKu5oRDgo_Pt4wVmzkqzbTG=3DYGvwq=
RCXcNXw@mail.gmail.com/,
this appears to be a bug in how brew changed its builds of git, and
also affects packages besides git.

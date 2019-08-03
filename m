Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7763C1F731
	for <e@80x24.org>; Sat,  3 Aug 2019 21:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfHCVXT (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 17:23:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52621 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfHCVXT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 17:23:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so71278311wms.2
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=c+QLgqws+4AsFXPm35NJv4vM2h3MDBA8gk1gfeWQinA=;
        b=Cq6hj3xzHMlh6ezuOJh8myajG4RiuqYdk7erWUsQR3hyooZbzCbJallhSm9YstZh9m
         cmXnVYeml57TuXgrveYZTbLe9/u7MITQ1S3K5uuoJvtzMp864aMBMnCjIfGb7Rv431FE
         HBIbDdphAKa98vJAQUQoWQaQM4tFpOdDsqxGUx7/S8BWcuTvrZjp+JH1+TbZUzw7mDGO
         S8/KmUPOLh/vZf+tHaFhkzd2K4diNLpYgCzGC+E64TXJf/YDUYQAs+6dAZ2baP1pideK
         ZmS5FEBBlSZgIP+yD1fdK6bzaF0HBrIs32K+OpRe7dSGhFE0WoJlEfXB/LBLxLPh1Idt
         7rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=c+QLgqws+4AsFXPm35NJv4vM2h3MDBA8gk1gfeWQinA=;
        b=hCvF/gkGTPmchYpZnqxf65zXNqLaIGHno2wjWYFXdQT45XFR088s0Pds4UwIUGnUST
         YvalOGZI9fAX5SQlivp9e8ElwNWI/2/4kHCyaCiK9bmwePxO85C/akXNNxo0PErbbfRA
         59TQ+HbF+BIAOA/J245fXKSZgQ8hYPN35kvrFTiHS9uEk9vDRnTV0anpA0GcPTLKnih/
         mnS6p1IXcnQgyLxIL/Jx5LRCJ5wbfFmRYXTGOvSh7ODTcov8UQPlTWdUiL28g4ZqeVsj
         /RY6JsQdGzGvqXZHWHzuDulV7d4Kvo4WwXvGZKcgpI9AkFRP3Ns3CLS6Tm+ZwYbdM3ma
         qU/Q==
X-Gm-Message-State: APjAAAWnJwa5v/wzESrZpH2JQrlGYlO39wbZcTupdH0q3vX9+SIeFxey
        QFrM4FRJlmEGzEHva4WCiO68bk1unAAOrqdmjkI=
X-Google-Smtp-Source: APXvYqwq0Ab+qm+Yt05eswjgJ68zE/LeZw1VuHX34fvZT7jYv7XOjb9zmUqv0JvFeeFLrHuOMEfY25cXUxLXkY2wkR0=
X-Received: by 2002:a1c:4d6:: with SMTP id 205mr9562273wme.148.1564867396964;
 Sat, 03 Aug 2019 14:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190803193436.13158-1-liambeguin@gmail.com> <20190803211152.GA118825@genre.crustytoothpaste.net>
In-Reply-To: <20190803211152.GA118825@genre.crustytoothpaste.net>
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Sat, 3 Aug 2019 17:23:01 -0400
Message-ID: <CAKm4OoWj6_D_aaq4mrAKHP3mieARjAAVmg2ea9axU2DE7My5VQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] commit: add signoff config variable
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Liam Beguin <liambeguin@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for sending this without checking the archives before...
I understand why this would not be such a good idea given the legal
meaning attached to it.
Thanks,

Liam

On Sat, Aug 3, 2019 at 5:12 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2019-08-03 at 19:34:36, Liam Beguin wrote:
> > Add a configuration variable, based on format.signoff, to automatically
> > signoff commit messages.
> >
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
>
> This has been proposed several times. It may be interesting to look
> through the history of the list and examine why it hasn't been accepted
> as a feature. A few attempts are chronicled here:
> https://public-inbox.org/git/?q=commit.signoff
>
> This is, however, achievable with a commit-msg hook or using "git
> interpret-trailers" if you are certain this is what you want to do.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

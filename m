Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4921F424
	for <e@80x24.org>; Mon, 23 Apr 2018 03:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbeDWDcf (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 23:32:35 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35924 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753929AbeDWDcf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 23:32:35 -0400
Received: by mail-wr0-f171.google.com with SMTP id u18-v6so9808335wrg.3
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 20:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NBkKLCWbbYpbgicQlyEYuqlGa4N0jnQHlgTr2ssgFBg=;
        b=fBNNsv9FiPYFF2IYgdntisl7S6qMpfWw24F9amc5EyTVOPgB2sgAvDH95ToTdDF8ey
         bZNMKwf/zUndjkDPbm5HvVNgz/Ru9J1wC4b6o9uxXLnYBzLUhyTkLaEZ33IiclcfuFuf
         HDQu2l3HMaCpRMwSqclXJ9QsW2yy3K+S+Q853J+N+WBrZMoX22LaBFyEN0MSOwKbZ2dO
         afH2N2BeMLUiBGA8aomMQhLi2VCoGAD4A02ytO/IHHPHq6nYr8G06xYLxLlrILqDH61N
         e4yODa77VX+ET542Rhf4gRtRWY/F87oa92dgsvBD2tQG4++H3shtZZoEZSV3dygzU5I7
         RSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NBkKLCWbbYpbgicQlyEYuqlGa4N0jnQHlgTr2ssgFBg=;
        b=DxEwQT9BO5NVoFeEN4ipgg3oTFIqBpDg2FnKOoZkjP3KsUPNikfN206C6cRaSxc83D
         oexGqZ9GZAEZw818xOEEoIqJaEkwfM6ons4Wyw++89JH72H8J1KkMI0++NZszSL1lUWu
         6WxtHgUDwfUq1RxP2Iv16+YkrRSYUv3X3Xc/OIOQoRMJSDf5nQWvQrXHmVldULfu4Kd4
         RFvj8IvBjiKoX8yxP4Uc6G4PYnxhhuuirOGrnaScj0M/vf8KZ/wgJcRt8AVmUrCrUewB
         WuIrc46U9OgEuKsd6xxIFdbvWMsJ6JXTaGoD6PiRzo1H9ApSdtZAtGIINm0lmnqWTtGy
         0d+A==
X-Gm-Message-State: ALQs6tCgQa+yH7171imEyiIz7XjzUKcqbGTVzGIvr5JYxRBS1UAF+4l6
        lUu+HNHGAHIUAOgXRxDiheIGfXY94RJE0luOVL/6lQ==
X-Google-Smtp-Source: AIpwx49w0QDnQUX7AD3QDPs0LAbol7gVZvzkMA9vKEw2HkAed6PyiajcocjbYlE/d8QHHNTIy7ipsPfFbm7IjZiJiCU=
X-Received: by 10.80.141.131 with SMTP id r3mr26106285edh.236.1524454353992;
 Sun, 22 Apr 2018 20:32:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Sun, 22 Apr 2018 20:32:13 -0700 (PDT)
In-Reply-To: <3BCD276C-BC6B-47BD-A27C-05D7C0C07280@schemaczar.com>
References: <585A3A2E-7DA6-4718-BF85-2D17AAAF3EF5@schemaczar.com>
 <20180422180912.GK14631@genre.crustytoothpaste.net> <1FCE6958-FC75-4A9B-88A3-05AE991815E4@schemaczar.com>
 <20180422195923.GA10082@alpha> <3BCD276C-BC6B-47BD-A27C-05D7C0C07280@schemaczar.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 22 Apr 2018 20:32:13 -0700
Message-ID: <CA+P7+xr99UyLVOrRYxRV=s8o5eJXzvOxZy5w51_FY_BYOue=VA@mail.gmail.com>
Subject: Re: Git enhancement request - checkout (clone) set modified dates to
 commit date
To:     Andrew Wolfe <andrew@schemaczar.com>
Cc:     Kevin Daudt <me@ikke.info>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 5:23 PM, Andrew Wolfe <andrew@schemaczar.com> wrote=
:
> Kevin, thanks for your feedback.
>
> You have a reasonable point, because usually you don't put the outputs of=
 a build into version control, but the build script checks them for being c=
urrent.
>
> On the other hand, when you change branches, your existing output directo=
ries are worthless problems anyway =E2=80=94 even if you have all the inter=
dependencies correct.  Because of this, I'm inclined to consider this use c=
ase as intrinsically hazardous.  When I do a checkout, I always want to pur=
ge all the intermediate and end targets regardless.

Not every build has this problem, and certainly I think some of the
most common build software would not (Make). It's fairly easy to fix
this by using a git hook to update files post checkout (you can look
up the timestamp of each file's commit time, or any other time and use
touch to do this yourself).

Thanks,
Jake

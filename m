Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700951F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeADWXY (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:23:24 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:45140 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeADWXX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:23:23 -0500
Received: by mail-qk0-f180.google.com with SMTP id o126so3814018qke.12
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B4sh8AI+KPpYlJuRsskPRuP8hxb76VjUhxwyGsUNc4M=;
        b=anz9SQd/GmroSt/T3BNjmMu7/LIhnvNWdtkE3hE7N+8ycYOcSjU7NxOPrpkWS4G3hh
         mANb6EwsUA8JpzKES+dqgk+4U1eejmZDzM2nvSyiAxhxdZyzeLeL5NEVOcY8okQuUK2j
         NfTBopr3xjRjjzacy5Ld27TzJaaDsp0280LBT3eZfg8uZZKMcCsNq7XXqR4cFLAIVWRA
         zCpikMsj6xBakZHrT7PAe3O8Kd0bVldFRCvw+P+HzV6X/MDg/O55+IfgaYFsoEry6awT
         ywhQT2DmR5GfuNNUV5N9BlCeRaRiM2rB53nZOIL13wQblXvC/ElymPTF/dMcL6AogmyA
         Wm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B4sh8AI+KPpYlJuRsskPRuP8hxb76VjUhxwyGsUNc4M=;
        b=CSVtNm897tFOtnCu7CrOlRrXyIoFYM8h0XZyCEfwOt7sWjfmy4Wn7Hr6c5pm5IDAQN
         kq//WAgoNoCFO9m2KiTSs4QrL9q9rULarHaL1YhG3Qmet3XVn0tCG9KSwMTooFiaNmx1
         AH3V3ioWDzwiOsmyGe7bixxjs6thaH1bkqAszsROa8lEqXHJRS4l+zK/0KAqcGiv8jJ4
         sgUgJOXC/q+poVgmt/XlYscYCCBvMsCVTVLWJoDYA7C/r4aj6a92HBsG9fGSSNu9V0Df
         oDRKCes+We1kQhUvH3NTArL1msryoX1rBMUlqtH9dB/oPqk9dZokD37I8NoMx20cpSzA
         YUVA==
X-Gm-Message-State: AKwxytcGmkCgjz8EAHyl6Jq7xQG/XqcZ3If9JjWPUYtHiQyfGj6RqU7t
        X/jPzPibRRxvi6u6Y9lLKujhNc3QjHXL3PUCP8Cg1WXX
X-Google-Smtp-Source: ACJfBosKmWTa0lr4xXhqGAXErLUAQARlxGL5j6QL42BKsgJXeJSiYnSOwNdHTtsOCUeI39vmFkPcYza7eXFq8OSIegg=
X-Received: by 10.55.76.205 with SMTP id z196mr1466217qka.296.1515104602567;
 Thu, 04 Jan 2018 14:23:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Thu, 4 Jan 2018 14:23:22 -0800 (PST)
In-Reply-To: <CAL21BmkcDK+VRc2CBTKnV5eubLh8u37THYjXhuTgFKR4Z=VtTA@mail.gmail.com>
References: <CAL21BmnycG4=Wm_e1S85QVPfs3vV_Q=TAjTAG-sv+f2mK6wbBQ@mail.gmail.com>
 <20171229132237.GA12561@sigill.intra.peff.net> <CAL21BmkcDK+VRc2CBTKnV5eubLh8u37THYjXhuTgFKR4Z=VtTA@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 5 Jan 2018 01:23:22 +0300
Message-ID: <CAL21BmkMrpEoijmMJ=2Y330shxABerc4tCBRpM2d4h0DypbYqA@mail.gmail.com>
Subject: Re: Rewrite cat-file.c : need help to find a bug
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-12-29 17:04 GMT+03:00 =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=
=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com>:
> 2017-12-29 16:22 GMT+03:00 Jeff King <peff@peff.net>:
>> On Fri, Dec 29, 2017 at 01:05:50PM +0300, =D0=9E=D0=BB=D1=8F =D0=A2=D0=
=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F wrote:
>>
>>> Hi everyone,
>>> I am trying to reuse formatting logic from ref-filter in cat-file
>>> command. Now cat-file uses its own formatting code.
>>> I am trying to achieve that step-by-step,

Happy to say that my previous bug is fixed, and I am struggling with
the next one.
Now I want to get rid of using expand_data structure (I took it from
cat-file.c to simplify migrating process and now it's time to delete
it).

>>> My code is here.
>>> https://github.com/telezhnaya/git/commits/catfile
>>> All commits that starts from "cat-file: " are successfully passing all =
tests.

So for now 2 of my last commits fail, and I am tired of searching for the e=
rror.
I was also trying to leave cat_file_info variable and fill in both new
and old variables and then compare resulting values by printing them
into file. Everything is OK, but I find it dudpicious that the
resulting file is too small (fprintf was invoked only 3 times, it was
here: https://github.com/telezhnaya/git/commit/54a5b5a0167ad634c26e4fd7df23=
4a46286ede0a#diff-2846189963e8aec1bcb559b69b7f20d0R1489)

I have left few comments in github to simplify your understanding what
I was trying to achieve. Feel free to ask any questions if you find
the code strange, unclear or suspicious.
Thanks!

Olga

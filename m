Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB661F404
	for <e@80x24.org>; Sat, 14 Apr 2018 22:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeDNWjD (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 18:39:03 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:39791 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeDNWjC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 18:39:02 -0400
Received: by mail-vk0-f47.google.com with SMTP id n124so7406265vkd.6
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 15:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ETwjvFA3MrJ3WEc3e9N0q0s4jPvd5fSxAe19rCWUspY=;
        b=TLw26i/0k3Gcq+ltJWAvurhCiMu0murTKjsZc9KFTagFX8/DDJi85gH/c8nhy0zne8
         LHV9b6/hL+wTEM9Z0hZTqzrQq+UyCgYVcOJM647iAmSJEws1AlCh8Y7213pVnIZxreOy
         bPZifAKj/Fs7yIakNqk4PS2RC/JxvOatGK70h/Cj3nqpv5ReE3PPTwI45drvP0NSBCmQ
         mJcv1ZgKnUCDIGxIAZrZXn1KGpFSUPXTCea+TDCmpDwaFVNI/eBgcwUEM6Gj0WvMXUSz
         K+pltxdtZ8+wjpMKLy7B0ueCh1fiWahLiae/kvF6fVkFRr4SAZIzRKvHPD45bzAAki8C
         hyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ETwjvFA3MrJ3WEc3e9N0q0s4jPvd5fSxAe19rCWUspY=;
        b=so28FYRU2zor1ihs+naSYyv7cwhdhHO2Iion4JViaxL8g7m7pBRL2LZ6uQxzLpdVd3
         17wbsDe44SnyZlRo5gOj+tOvKPi9xfLqlX4HRi/3w/hBaKrQq0iHyT1GW55LXRuDo4UY
         uaWviDcDfDrw48NMi2mhIgAujbX2AVlVNBqtV1p3w+1/A1CVvEM/ZrjlwO9CGiaGfazu
         H0QHBG2UB65BKuw96T2Uks+0Eo1dlvAFfbAAr7bKninvjNGtNIKeEU77nVNffNL3CroZ
         vxLW69FFYG+CGuqYZKMG5EbViaxqHGknkiOT+w4XFBPFpUMXGIjF8bI78sPt8B60y6VH
         oieQ==
X-Gm-Message-State: ALQs6tBtnqlQVEOD/7mF/up4Ze19zN7k+r09NiAbr89rbitu7Ya0IRdL
        ucwtvTBUmNg/80tVR7DusVfE2bmj4snVxkRqPDU=
X-Google-Smtp-Source: AIpwx488J9B3fa6qWcDC0WXeO4fOGvIzyX6RZFuc5co/ZY2/reIwv7izx663VsN8iHEIcXXuAMyLWJC96ZbLbQgmMQ4=
X-Received: by 10.31.178.200 with SMTP id b191mr7398254vkf.145.1523745541757;
 Sat, 14 Apr 2018 15:39:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.114.143 with HTTP; Sat, 14 Apr 2018 15:38:41 -0700 (PDT)
In-Reply-To: <878t9pfu4f.fsf@evledraar.gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com> <878t9pfu4f.fsf@evledraar.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sun, 15 Apr 2018 07:38:41 +0900
X-Google-Sender-Auth: 7y4QpqhXUeQGKjw4pRUDNZ9Agqg
Message-ID: <CAPc5daXHJCbuxv2NE1KUt3pYtP1p1RQhOT5ceb0++spEJZ5dTQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] nd/repack-keep-pack update
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 15, 2018 at 4:47 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The only (trivial) issue I found in the patches themselves was that
> between 4/5 and 5/7 you're adding an empty line to config.txt in 4/7
> just to erase it in 5/7, better not to add it to begin with, but
> hopefully Junio can fix that up (if he cares).

I do care but I'd wish I do not have to waste time and concentration to spe=
nd
on doing so, even though I would be fully capable of skipping this round an=
d
remembering to queue a rerolled one.

I've seen mentions like the above one a few times on the list recently, so =
let
me make it clear. Some things are easier to tweak locally than others, and
I'd rather not to waste my time on cleaning other people's mess. A simple
typofix that does not cascade through to later steps in a series is one thi=
ng.
A tweak that changes number of lines in a hunk that forces a later step to
compensate is more involved.

Don't expect your traffic cop to wash your care while you're stopping at a
red signal.

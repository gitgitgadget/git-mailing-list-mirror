Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3595620188
	for <e@80x24.org>; Wed, 10 May 2017 19:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbdEJTs2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 15:48:28 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35949 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753586AbdEJTs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 15:48:27 -0400
Received: by mail-it0-f53.google.com with SMTP id o5so31719082ith.1
        for <git@vger.kernel.org>; Wed, 10 May 2017 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UM1h6qi2XTPyEHms/ld3+NR79kDkFgbFhlT9820whrw=;
        b=BQrG3yrjbBaD+7Gvn15siG8FZWaoLdi2K7tKOTzvNhzOcIfNkV3dNNdzkKa1keyyzO
         OrNtPUGmjzOChGA4FH/pKrss8zrB4Aw6+jGv2cGNT32BnkZV85o4aYlx75kBThpkaHBb
         JLo5FF+HU7hqRPoPJgiWlnCDpCaot1AdR5cgtfSRIceDweG3pN4KteMwsvXZmQjQzEmf
         0ITPurQ01anY+/53VqevHj4QtFp15pO0JRd2jO8+b4aRXC4CZMNe+NM4vc3iHIh88Jrm
         eHKWpaNP2We/Y2zdPy5Csg23MA6/zmnMB7RaRna9cNIf8igYOFx6mvnbUBXy5o7vuA2H
         YXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UM1h6qi2XTPyEHms/ld3+NR79kDkFgbFhlT9820whrw=;
        b=V9bRTX2KqvRxTZ0OY+UMpoivjQDwlcsPvG2li+z21iD4TTzHuf0kc2CHQw9ChyUOuh
         xmR3f2w/6lwqt8i75LFNBeW9KZdr7oghLl3ayss/rr00GcbA5LoClqmyB9r1a9nIeAbP
         jr2f5ajMbEjpCqCYlwhrncrKIOMbEJN9q7WqY4YRkJ5b4w7xGpv84m2Fv2cWXrOVfyWz
         cxKIw5g09JorJ/qEuRRvoxBo6zh0A5BzFTiJxtszxbu6B1AAXaciKzC89Pgs1F9lsLax
         qUDzkuyiSv9ic2QBvRJq/w61+fMqJvDsd/QF+BkdbPUcORieXh575JNfhzFH2AsYsERy
         Hd8Q==
X-Gm-Message-State: AODbwcCayl5zgJNqSey2aNe6lD93goQxUpJphR4FBx+OpxFonhBPzM3R
        ljTtwkk0F7czjHY6zYamExoTnLuZs3QjZag=
X-Received: by 10.36.83.144 with SMTP id n138mr7013312itb.71.1494445706570;
 Wed, 10 May 2017 12:48:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 10 May 2017 12:48:05 -0700 (PDT)
In-Reply-To: <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com> <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 10 May 2017 21:48:05 +0200
Message-ID: <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes
To:     Sebastian Schuberth <sschuberth@gmail.com>, raphael.stolt@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 8:58 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On 2017-05-10 19:00, raphael.stolt@gmail.com wrote:
>
>> Current configuration which finds the conditional configuration.
>>
>> ~/.gitconfig
>> [includeIf "gitdir:~/Work/git-repos/oss/"]
>>    path = ~/Work/git-repos/oss/.oss-gitconfig
>>
>> Expected configuration which doesn't find the conditional configuration:
>>
>> ~/.gitconfig
>> [includeIf "gitdir:~/Work/git-repos/oss/"]
>>    path = .oss-gitconfig
>
>
> My guess is, because includeIf might contain other conditionals than
> "gitdir", the generic convention is to always use an absolute path for
> "path".

[CC'd OP Raphael Stolt, please reply-all]

In both cases the conditional is the same, but the path is relative
v.s. absolute.

Raphael: Does the config get included if you cd to
~/Work/git-repos/oss/? From git-config(1):

---cut---
The included file is expanded immediately, as if its contents had been
found at the location of the include directive. If the value of the
`include.path` variable is a relative path, the path is considered to
be relative to the configuration file in which the include directive
was found.  See below for examples.
---cut---

The commit that added IncludeIf (3efd0bedc6) does something with
relative path (just skimming, need to get to other things), but unlike
[Include] the docs don't explicitly mention what it's supposed to do
with that, and all the examples show absolute paths.

So whether this is a bug in the code or not it seems to definitely be
a doc bug, whatever it does with relative files should be in the docs.

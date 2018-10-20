Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2F11F453
	for <e@80x24.org>; Sat, 20 Oct 2018 06:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeJTOM4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 10:12:56 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54584 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeJTOM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 10:12:56 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so6675165ita.4
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 23:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGba9m9z1tjDsoqMhopO2a/9BV/TNTeDbbZ6bFWr/8U=;
        b=l3/PT+9m91jUX2IzEsmlROsYK7yFBq/Ow9LI6oNJj2vayeV+0SVtho0bSGhsxofKt5
         ZbjM2Yqkt8CyTrENZU6riaUlW1gk0usHKkBJ+RZY/DMgQp0pPe7qYdIZpUyuXgB7M/TI
         sv02YSMvPF3wK3kC8kXfIpTDTFv6SdqXLGTyz60R5842ZkBzqd64zQPvngMn2f8j2cZT
         WhHTWP9PQyYNza/fd/vr94AfEngTiQfVxFB8AiBZi/WcLa1dGIiazrdmm2LsE9zTiK/C
         anrj27cMkWC3OxZkhmpFj6Y7fA3fn7/Qc8yu4NFpohU68dZpQT22ZgCDgw3/sZl4qvnH
         V/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGba9m9z1tjDsoqMhopO2a/9BV/TNTeDbbZ6bFWr/8U=;
        b=YRMXQYezLx6+ZwYvPMkOKqACK+7YfjeyVstHBBQueycsdbC7UDnUKMS3BZFCIy89dE
         PoNeEz9G/p197neHmR/xMmgmjIMwgLlGfMOlvrDHVZPlXNBWvtMpotfxBp+ndgEOLS76
         afFqdXso2RKv7Llc94JUrFlnPceagAOEmkBJUIKjXNQH9lR5p3d8a0c6JkSS+eHHeQkC
         90TfFBRFd0HEsSSY5q78eMq16DPf3hYKvUUl9GllliwMYQUIcklAu8eNA4I2hcTOGg8i
         Sk7AbdtHNR7X/mMu+w7d2MfYcruCuwjeEfwrDCI3x+6ma4WQWQmJ7UsYTAQbRGOZcipo
         k2CQ==
X-Gm-Message-State: ABuFfogVZ4poOK+LlhSuKax7t/sfHeTwEBLrtKYTYcMRvdp5KzgspcSt
        km6QXEF1FJ1amuiCaYm91Pmnc8Oj5IsgplwHUfyFNQ==
X-Google-Smtp-Source: ACcGV63BydPW7H/zpDY0HkYB/Fx4ez+ub8R/H1JpP9I4SDiW1rOWntVIScEBn7Oc3Fml/61NkZlRY2vX0UxRLBChXh0=
X-Received: by 2002:a02:a613:: with SMTP id c19-v6mr15492120jam.30.1540015419388;
 Fri, 19 Oct 2018 23:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is> <20181020052624.GA31433@duynguyen.home>
 <AFFFEB92-0CFE-45BA-8BE3-105E8963A121@dana.is>
In-Reply-To: <AFFFEB92-0CFE-45BA-8BE3-105E8963A121@dana.is>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 20 Oct 2018 08:03:13 +0200
Message-ID: <CACsJy8CMSQZ7guGAyDqU_xdJrt7BiEDwdtePdfmgagnvSb2p=Q@mail.gmail.com>
Subject: Re: [BUG] gitignore documentation inconsistent with actual behaviour
To:     dana geier <dana@dana.is>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, jamslam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 7:53 AM dana <dana@dana.is> wrote:
>
> On 20 Oct 2018, at 00:26, Duy Nguyen <pclouds@gmail.com> wrote:
> >Which way should we go? I'm leaning towards the second one...
>
> Not sure how much my opinion is worth, but the second option does feel more
> friendly (from a usage perspective) as well as more straight-forward (from a
> re-implementation perspective).

Yeah. And not having to describe all the corner cases is a plus. Too
many corner cases are a sign of bad implementation anyway. I'll wait
some more time for the others to speak up before I cook a proper
patch.

> There's a third option too, though, right? The 'rsync' behaviour mentioned
> earlier? It wouldn't matter either way in any of the examples i listed, but is
> there ever a conceivable use case for something like `foo**bar`, where the `**`
> matches across slashes? (I can't think of any reason i'd need that personally,
> but then again i don't understand why these people are using `**` the way they
> are in the first place.)

foo**bar would match foobar as well as foo/bar, foo/x/bar and
foo/x/y/bar... Its behavior is error prone in my opinion. There's also
some concerns in early iterations of this "**" support that we would
need to revisit if we want 'rsync' behavior. I'm not very excited
about doing that.
-- 
Duy

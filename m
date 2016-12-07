Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F251FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 09:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbcLGJXJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 04:23:09 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:35641 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbcLGJXI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 04:23:08 -0500
Received: by mail-io0-f171.google.com with SMTP id a124so701234713ioe.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 01:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zs2EVZx8tBDm1AvzUYR9FiO+JDQTSx6D9Jq5lfZhJqE=;
        b=Ad3XNu+25CaIfONQ/4vgMaN3eB/q2qhnQM+OCuwNGj4BP10h88WPCLfW2kwnKZX7S0
         93N9erCx/vluSyEEYm17wHtfpWy+20q1Xav5pSrz5c6s96ejtMDOYhrGf/HFhJjKyVu+
         U0xWDqYh84MkUH7bd493en2Y0ZJBz6ZfHUaF9bX5odwY0EXoXAO2jGUJUZHOkWNsUo68
         wadGc0CjnjuEsTWqFMsbPUT5g2Xlkqdz+ShtlW3zrqe9wDpRoNyNleaYSDav2YY6rczW
         dqpkZ5f+nTmF96u3Dx5r8DiNLgFTopyFuoT6wUFqzHVnK2HaZJSPEOR4kRi5DegPIvpq
         izCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zs2EVZx8tBDm1AvzUYR9FiO+JDQTSx6D9Jq5lfZhJqE=;
        b=Ydtju2sLCihe4fjCcDCRNARIFCGB3OF24yybcZTIobfVsQnRENhYxprb57NluxFWWw
         OsEGwsA93c+LvT1yIYTXEdQlmRTLkViXsOFe1lZHFJBseA5SEeIs+F3TeMoOl6HDQ3aT
         PdbOEhLAXY44pWQu0TWsDKq0fmfdqvzZu+qHsClCkR4865RhnkQakGyo9HibkAifCdaS
         JFW4u4IQ9e54gSMvLwSFBytQSU27yUW7tz5yx8jDO0IxjQXIv7ir50zuXdyU414fnc3A
         ytX+GnnbaVMwZNwyi/kucEDIlgCezzYn15+uA+BK5FT+mC0V06lwnlxi6slDkdCZPVAV
         X9Qg==
X-Gm-Message-State: AKaTC02Gr9iw1R9bH35P6lcQQxb/mtF3ThGi8b2q2LAZUyzGEnhyQOcrCl30WiGPhT3izFFc+YAdjnoNbTvFdQ==
X-Received: by 10.107.132.74 with SMTP id g71mr58918388iod.19.1481102587303;
 Wed, 07 Dec 2016 01:23:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 01:22:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 16:22:36 +0700
Message-ID: <CACsJy8A_YMyEUgX--1tEfJC4aaYfDbFFL8WEs6CHp4a4=mHRjw@mail.gmail.com>
Subject: Re: git add -p with new file
To:     Ariel <asgit@dsgml.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 8:18 AM, Ariel <asgit@dsgml.com> wrote:
>
> If you do git add -p new_file it says:
>
> No changes.
>
> Which is a rather confusing message. I would expect it to show me the
> content of the file in patch form, in the normal way that -p works, let me
> edit it, etc.

We could improve it a bit, suggesting the user to do git add -N. But
is there a point of using -p on a new file? It will be one big chunk,
you can't split anything. Perhaps maybe you want to use 'e' to edit
what's added?

> (Note: I am aware I can do -N first, but when I specifically enter the name
> of a new file I feel it should figure out what I mean.)
-- 
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A82D1FAE2
	for <e@80x24.org>; Fri,  9 Mar 2018 09:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750966AbeCIJyi (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 04:54:38 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36848 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeCIJyh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 04:54:37 -0500
Received: by mail-oi0-f49.google.com with SMTP id u73so6562127oie.3
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r//85C7wPDT32KlAQWTgc2rvc9psyOSvKT1Wam2BKA4=;
        b=BHzbqvRaZ9a+NOMWRzhJraFvxH0UENKYFBuHhTOuNMjgE4bal6VPOSJFnj9hVnmo2s
         cvdoJtGDELqisI21aCmOdVL6zE4dNrkyonrTwjGYuJuptxK4juDCJCQZKJPF/9HzSx3s
         /chzzFGifDVH4JEiLbzyCUBl0n2DtgiJz9CUnlXwMmo1n1SdLLwa6jfk+5mM85zplzz7
         W1m6ecpU6zZh7TG3JLd/CUZXOda2dukxvaU894fS+2+gQHhy5eKjFxEh2ziOYEvhWI7n
         QrBQokTRBA2krN9exgKBZbrm9hXSWs6ctXtMy1O7WBRsp/44nBecuitshM3aUmhpfy2A
         J4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r//85C7wPDT32KlAQWTgc2rvc9psyOSvKT1Wam2BKA4=;
        b=QwySPCx6ETEyEhJyD3ac/M14ThimsOZuEvgfrJEFgIii+X5/AJrr7VBGr29TeUnMuP
         FOe8LBeURoiCyBUO0/bWwLszbiUEy+upxAwk/37G2rw85CzcvJcjFMKxUwNgNk331wr7
         GvXiAMPqo7SFCl+D7/LH6422x1x93bL4tYow22kSj7M7t1YuIK6lxK/1uUXm7t2AsZe9
         QwZORuwQ3jlj8pZmxkk38kh8BsPIOvvH6jt/K70Qq7sslVihsDly7ydTJJerPxS2v/Q5
         pe+yaV7tE3XjMO2TGHZmeea9oSaNxXSQyh4jgGwONoN3s1wqsJc47vNaVcTQ0TK/wXHT
         OF5A==
X-Gm-Message-State: AElRT7FEMcchCDXA2XhadVh/oZn0DoHyG/QX8sWJE4+GrDWg4Qllp0hh
        VWijZM70BzAJuefNjeNl25374kYby9Z+s1dKyXM=
X-Google-Smtp-Source: AG47ELvQi9mcQx+0uBQa0NI4/5y/ejNm1hgjaTCmyd1pb926sohRM4t9ktL02ZU3QrIzclOAGRd+I7W5BTJAoQfXY5s=
X-Received: by 10.202.83.129 with SMTP id h123mr19084550oib.228.1520589276659;
 Fri, 09 Mar 2018 01:54:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 9 Mar 2018 01:54:05 -0800 (PST)
In-Reply-To: <CAN0heSoKOoEikn8z799Xptje2Q2SE4BeAcvvXecPMNDCjBJ0+Q@mail.gmail.com>
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com> <CAN0heSoKOoEikn8z799Xptje2Q2SE4BeAcvvXecPMNDCjBJ0+Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Mar 2018 16:54:05 +0700
Message-ID: <CACsJy8B921X4GRT35vwHWNF=CKJRGhc+-hFeYyQ3Zc84aoSvfA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #02; Tue, 6)
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 9, 2018 at 1:15 PM, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
> On 7 March 2018 at 00:34, Junio C Hamano <gitster@pobox.com> wrote:
>
>> * ma/config-page-only-in-list-mode (2018-02-21) 3 commits
>>  - config: change default of `pager.config` to "on"
>>  - config: respect `pager.config` in list/get-mode only
>>  - t7006: add tests for how git config paginates
>>
>>  In a way similar to how "git tag" learned to honor the pager
>>  setting only in the list mode, "git config" learned to ignore the
>>  pager setting when it is used for setting values (i.e. when the
>>  purpose of the operation is not to "show").
>>
>>  Is this ready for 'next'?
>
> I am not aware of any open questions or issues. You thought out loud
> about how the series was structured, in particular about introducing a
> successful test, then redefining it, as opposed to introducing it as a
> failing test, then making it succeed. I hope I managed to motivate my
> choice better in v2 (which is what you have picked up).
>
> Duy wondered if it was sane to use a pager when we know that we are
> "--get"-ing at most one config item. In v2, I addressed this by turning
> on paging for a more careful selection of "--get"-ters.

Yeah I got busy with stuff and didn't look at it. I've just checked
what's in 'pu'. Looks good to me.
--=20
Duy

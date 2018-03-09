Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805A11F404
	for <e@80x24.org>; Fri,  9 Mar 2018 06:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbeCIGPy (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 01:15:54 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:45770 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeCIGPy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 01:15:54 -0500
Received: by mail-pf0-f179.google.com with SMTP id h19so924443pfd.12
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 22:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6VON4iAvM3AUeajIuQhtzgvZVPQsqQlh5iZtR2PcYto=;
        b=FPEJeGYW+JXY2hXcPzwtooeLtmdNPTcVli+9HO725iFV3MPsWDMpKjdEZRVifEY0Ha
         p0bNU0SfDQvfKQeviwzWcEmF9eooGXntoTIMKx3sx7hglw9yPB6G8x30QzlBF/SuMPL3
         FNNDfX6+scidCaQO4/jljQy9w9D7UyJeW8Vu65yTP9IHHIM1od2MYwPC0kIMSG3IXL2s
         qZyyhFv/IYX+le30iyx/vS279Be5JfBQNDiCpNm+vY2slJN8JOqHGM5Jy9PPhsn/g5kS
         M3DptNWH7GZEEd8b8c53oNT761843h1yjGwHvVfHndSacgWf+6TVRtCoIZxC92ig+P8L
         tsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6VON4iAvM3AUeajIuQhtzgvZVPQsqQlh5iZtR2PcYto=;
        b=JsMca6VihRj/uq747lJO98KYNLWij4egCqyBoDiDI21JcuKRfLcVX0HEtHuhe0ENYx
         osMX7hMJMdsQyGfUjghcqPGOuBGsXpCngmvgajmkrLxjivz4KsUfIrIRDou8Cx/rDGJh
         i+t/Ux2lT3xdFWzQunX6QRECb56Ff+B6RZbGxno2gH6Lr3bM78KbFoi6EHY38cti12Rq
         qz0OBdP3HcsK3/5r5MAg5Q3kA3PifDh3iWrYKFN0ZGIXrtFuJlGC+py5Nx42Aj18Klql
         zCPsC9YNMxxWn7FuImg780+91QzLX3M0iWUBr+usO/KxYhgjyZO1yiI2R8HRgWHu93Pd
         49sQ==
X-Gm-Message-State: APf1xPCzZGXKDC11u34Py74gYBOA83z/JpA8U2h1Ws80VZtxHktyOLth
        /4DAkkrvMGgtrisTEKwHIKTbtYAdT0lmJbMT3PQ=
X-Google-Smtp-Source: AG47ELuH0rmBd9ZwXQh2TZA84wXZJ44FAG+jN+yA7NIS3jkg4gMgFek2DtBIyEl6Nv4L+LtePnqK3B+fJ6F+dzFXd/8=
X-Received: by 10.99.103.133 with SMTP id b127mr23051903pgc.155.1520576153569;
 Thu, 08 Mar 2018 22:15:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Thu, 8 Mar 2018 22:15:52 -0800 (PST)
In-Reply-To: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com>
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 9 Mar 2018 07:15:52 +0100
Message-ID: <CAN0heSoKOoEikn8z799Xptje2Q2SE4BeAcvvXecPMNDCjBJ0+Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #02; Tue, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 March 2018 at 00:34, Junio C Hamano <gitster@pobox.com> wrote:

> * ma/config-page-only-in-list-mode (2018-02-21) 3 commits
>  - config: change default of `pager.config` to "on"
>  - config: respect `pager.config` in list/get-mode only
>  - t7006: add tests for how git config paginates
>
>  In a way similar to how "git tag" learned to honor the pager
>  setting only in the list mode, "git config" learned to ignore the
>  pager setting when it is used for setting values (i.e. when the
>  purpose of the operation is not to "show").
>
>  Is this ready for 'next'?

I am not aware of any open questions or issues. You thought out loud
about how the series was structured, in particular about introducing a
successful test, then redefining it, as opposed to introducing it as a
failing test, then making it succeed. I hope I managed to motivate my
choice better in v2 (which is what you have picked up).

Duy wondered if it was sane to use a pager when we know that we are
"--get"-ing at most one config item. In v2, I addressed this by turning
on paging for a more careful selection of "--get"-ters.

Martin

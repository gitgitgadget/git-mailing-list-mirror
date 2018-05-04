Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E16200B9
	for <e@80x24.org>; Fri,  4 May 2018 18:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeEDSEJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 14:04:09 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:44221 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeEDSEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 14:04:09 -0400
Received: by mail-vk0-f49.google.com with SMTP id x66-v6so9354939vka.11
        for <git@vger.kernel.org>; Fri, 04 May 2018 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J7qXwKkc6bBmzgiFahSXdcjI2b8BDpKozEqGrwRgb/E=;
        b=Ldraz6ZMrmgiVzFebG2CnOtfTGeTI27aEKb273rAHPFC30YRF527a/1NhptY3OvFIK
         TqzztXnQTOFcha/vLpaodQFHUGe2/j5zLDdNB0yhQzsWoNu6PeuDZoRAptsXZM2cWAwN
         TTrEriOd1Z6/uo9dvUMet9q+7dr2EWfZPYiyFTr5Y/I/bTmBjnU2ZPFQ9cG0yOhMb4o1
         8bkfUMGgEZCwwariagsi41oLeH1imLKK2FdEZU4pXT8FK/nG/AXkZyQGQl2j4upN/uUp
         kcRloJVKOa6qxaJjkJPegKpTEbib1mreOx9IJ8pPalsyGZYy5VVxa5p20Rk7L0JhbFfi
         QubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J7qXwKkc6bBmzgiFahSXdcjI2b8BDpKozEqGrwRgb/E=;
        b=ep8OMBn2qyAqZRFlQUrRnJocrsXZR1trJZN1ro1LsagujbH+t9jJRZMjFn6gIKC+N+
         pW//lRrFgMeXN3AOa83yuFgttqylTtL5ZbK5OPG97xySdpAen5mghirIG2/krUWQiINv
         l+Buokv7bA3tOicvqOYZljRDcNvj/zJjIGGpAVP707sG8rqQagIlrqt42ay8yYzOXD7o
         aXpuk+TAev1vl2+ZqFFc/fZ2GX+ocLxS3DP9sDGF3Acgs2X7cPJfD99ojxepVJ/z8a6a
         cKWxpURdSXIJEJK0KArNdNQsAYyk1ahNFTqj5qpNpCY8dQ4J0LAz/olpgdgO9q3zDmOf
         QzyA==
X-Gm-Message-State: ALQs6tDdvetJTEhCZGfcBG91uUTqzHAtCqBrNYmaWLenB9OPWXdz9ko0
        xiDJXYA5Ont7RHvLAS2Yd4jN/fVc5if76eiDjvc=
X-Google-Smtp-Source: AB8JxZqw22hQuk+JKrhLAHkt/ySH7MlvPr6OPol0uujEGlmRCrXpFtLxabO2WRXgXlmrLiu1nb430z/CumOyCHoIlX8=
X-Received: by 2002:a1f:b752:: with SMTP id h79-v6mr8437889vkf.187.1525457048044;
 Fri, 04 May 2018 11:04:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 4 May 2018 11:04:07 -0700 (PDT)
In-Reply-To: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 May 2018 11:04:07 -0700
Message-ID: <CABPp-BEL2xnU11jg838k4LGy-4iSJGPk=uQpJLaip-7rSP2KFw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #04; Mon, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, Apr 29, 2018 at 8:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * en/rename-directory-detection-reboot (2018-04-25) 36 commits
<snip>
>
>  Reboot of an attempt to detect wholesale directory renames and use
>  it while merging.
>
>  Will merge to 'next'.

Usually you have a mini-release-note in your "What's cooking" emails
next to the series, so I'm assuming from the text here that you might
just be intending to re-use the release note you used with the
original series.  For the rebooted series, it is probably worth adding
something to the release notes about how it also fixes the
unnecessary-update issue reported by Linus
(https://public-inbox.org/git/CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com/),
a bug that's been with us for several years.

Elijah

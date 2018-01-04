Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0B91F404
	for <e@80x24.org>; Thu,  4 Jan 2018 15:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeADPyQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 10:54:16 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:35976 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeADPyP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 10:54:15 -0500
Received: by mail-it0-f44.google.com with SMTP id d16so2866972itj.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 07:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NwvBQoOFXBSgzpr+PcTarRtutrGwZgHg9Ug84EcdBU0=;
        b=RRt3iPV4ctwBzpSMdUL9C97NCkWBd5oFN5s5SqDbr/G1YTxn8rSPbeSTIblMInOMXO
         vLseQ/CrHPBAj+4AnkkAvMPsRvnrTIz+RCA0pG0I54Jn36HYm+5ptofS+7d7qfNfHxjL
         pfePOi1L3QWxx3pUra7leAiH5cKtu2LpvIDnKyUZr2pj5paQUbMbZBQG/XKlM7qMqIkr
         RH+XvEiVVrkV1wE5iwjhEw0aTYtMpdrV7NLji7H8t3oUYFO7Hwf+R/S92OsontTevKYH
         FK89sb4DhKtWjqD5eTiC7IgCjKaQ3cBenEEXysj3P1VuUey8vOFPcH+gGlTG4RjcsOoy
         abTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NwvBQoOFXBSgzpr+PcTarRtutrGwZgHg9Ug84EcdBU0=;
        b=reMsR8Qil4yFdrQJed7hqpu7k55uGVRr5uhT4+O80EthF+wKhGQ/hBJdAAq3Kk9HTM
         ny+OTbuPfcyfdxkq8Y5gfesyyizgsMQOFUE2LGEFqJGuV8QPhz9OzRABHzDXmVHOLD6X
         YNlRL+LSe9JtuVj/CuETdSLh3NTdIxE2KCkwNT61gFQg7EPgl9fco/EGJwoShVNiHOLg
         odl8GqgF84sFBuH4Pbpi40EffHD5CDuScTrlSVtha5PNAp4p9EWqKQJ8ENJ0r18NEgkK
         aAqzq7ujDSve33OFkbMc4nsj2e74QMR1lGkQ6v63+ylviXFGWtkebS2WMAbgpJ1afbAA
         uyOg==
X-Gm-Message-State: AKGB3mJLNxm4+o+axZATprTycdDOcjf7fW26vRTI1jOu3IYxtHg683Ef
        LH7ymu4lGktL+kr4mCb7RxXFAMtfPqwMAr/kmcSikQ==
X-Google-Smtp-Source: ACJfBovMvys7JbVXevxLTafjEYKBP55YES/80ojY4oU2W/CFliWcvQmDF+rVkcNpvSG3/M3yIVaMYsE3dLD3C24gnNQ=
X-Received: by 10.36.0.209 with SMTP id 200mr6389146ita.55.1515081254454; Thu,
 04 Jan 2018 07:54:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.62.3 with HTTP; Thu, 4 Jan 2018 07:53:53 -0800 (PST)
In-Reply-To: <xmqqvagifqj8.fsf@gitster.mtv.corp.google.com>
References: <CAJzZBAT--X8GXg_knege_pZ8A=_Qk9nyMCLaoRMvjhUFGQYsZA@mail.gmail.com>
 <xmqqvagifqj8.fsf@gitster.mtv.corp.google.com>
From:   John Cheng <johnlicheng@gmail.com>
Date:   Thu, 4 Jan 2018 07:53:53 -0800
Message-ID: <CAJzZBAQ_T3JDqsxy=s7gbrRQjDsdZODB8XsBb4TUCs1K1Bmnjw@mail.gmail.com>
Subject: Re: Misleading documentation for git-diff-files (diff-filter)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be clear, I don't mean to imply that diff-files should include
files that are not the index. I was trying to say that as a user, the
documentation gave me a different impression.

For background, my intent was to have a script to look for local git
repos that with unstaged changes. After some trial and error, I found
that git-ls-files gave me what I needed. However, I wanted to point
out why I initially believed git-diff-files with show "added files".
Think of this more as user feedback.

On Wed, Jan 3, 2018 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Cheng <johnlicheng@gmail.com> writes:
>
>> I wanted to know if git diff-files shows files that are not in the
>> index but are in the working tree.
>
> At least in the original design of Git, that would fundamentally be
> impossible, as Git _only_ cares about paths that are in the index,
> so a new file won't be in the picture until it is added.  Because a
> change is shown as "A"dded by the diff family of commands only when
> the old side lacks a path that appears in the new side, there is no
> way "diff-files" that compares the index and the working tree would
> see a path that is missing from the old (i.e. the index) side.



-- 
---
John L Cheng

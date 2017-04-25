Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 063BF207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 02:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979880AbdDYCAI (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:00:08 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36726 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755624AbdDYCAG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:00:06 -0400
Received: by mail-qt0-f170.google.com with SMTP id g60so129427718qtd.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 19:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=68Gh6aVxN+rtPik22uQc0Wzcu9DrW+VVLX6SoIBMotE=;
        b=opeJcn4OBiFvf0ovuZPXYynAju5powo0o/eb8eerFkTWRQ0WXPDcwUnZbb88h4jLf7
         Bf+1dbvWVdK/y07gcee1Y0qdsBXrj0axXP+8txcVa/TsqLSRf1b55uYt6XEtYMxoaul/
         PaU2WcXbPRInjyzwpfNEUTD3Z7wJYkEMU+lsnQ0PIPnFiPuOcQZwcTu4FWzPi9WNe2dS
         uagA9u1DGzwmdAGKEi/O+QvfbbJZplIPHuMv66+LENBWd3b9FX2KXvEduWmMg+hZmWB8
         5ApiBjx2KAJ4sptTHYBQfYLLdfUF5zMgJgmTg9iSvOXJGoj0kwOdGe8q9DhbH9ysu8Js
         1afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=68Gh6aVxN+rtPik22uQc0Wzcu9DrW+VVLX6SoIBMotE=;
        b=pBjDHxFCy070Rh+3wrlVnoCzMebiHx5f446hnU5o4G6IzaASOzUUsip7AcUEQrIVwk
         nR9+oxxOx8r129kXBM4quFV9W3enqJNS/0BpIuC7ObVX/3E3qNlurvhi1zRUTNI84sBv
         1LZ2o4lwUdeYJ6HSfFAxyRLh0W/FYF5bSRjNgltCkXI2R+pKIy6tm+bhsrBTvV1n937h
         VD7csvNJyrW4pxjhzxVdLgIS4bjkBimJ7armSZpXwrZ/ofB4QmzDBE2ZyCzWhfvTeXrS
         4HrrdIUf7siNBPIkYVRHs/gTsn+mKrY360d75J6jgFreU3ZMKS5jPkYKtjtE40mW7n9W
         YS2A==
X-Gm-Message-State: AN3rC/7S0FE0ZW0enItFhjFmle8QqxJ0tRx58Q26xKC0EiAzF1SqeEiW
        jpFBtUAsBabyMuC173AMl0QF2JSAyQ==
X-Received: by 10.200.4.147 with SMTP id s19mr28356876qtg.226.1493085605821;
 Mon, 24 Apr 2017 19:00:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.96.65 with HTTP; Mon, 24 Apr 2017 19:00:05 -0700 (PDT)
In-Reply-To: <a9685abc-50ad-3ee6-3384-0e043d205612@kdbg.org>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
 <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704211135430.3480@virtualbox>
 <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com> <a9685abc-50ad-3ee6-3384-0e043d205612@kdbg.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 25 Apr 2017 04:00:05 +0200
Message-ID: <CAP8UFD1r9TFE9ns5pobDOpugF8MBiJAYgrRALCqGVmgWud=QjQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2017 at 3:37 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 21.04.2017 um 14:29 schrieb Christian Couder:
>>
>> First bisect should ask you to test merge bases only if there are
>> "good" commits that are not ancestors of the "bad" commit.
>
>
> That's a tangent, but I have never understood why this needs to be so.
> Consider this:
>
>     o--o--o--o--o--o--o--o--B
>    /           /
>  -o--o--o--o--g--o--o--o--o--G
>
> When I mark B as bad and G as good, why would g have to be tested first?

It is because g could be bad if the bug has been fixed between g and G.
If this happens and we don't test g, we would give a wrong result.

> This is exactly what I do when I bisect in Git history: I mark the latest
> commits on git-gui and gitk sub-histories as good, because I know they can't
> possibly be bad. (In my setup, these two histories are ahead of pu and
> next.)

Yeah, it is safe to do that in this case as we test the merge bases.

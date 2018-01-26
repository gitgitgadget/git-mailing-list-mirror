Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33401F404
	for <e@80x24.org>; Fri, 26 Jan 2018 20:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeAZU0k (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 15:26:40 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33253 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeAZU0k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 15:26:40 -0500
Received: by mail-ua0-f169.google.com with SMTP id p12so1088431uad.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tDquSSAfNDR9eLd+QjoRhiMCDCglkna06zdIP/k8lVg=;
        b=ba8lojUFVGz38/EefU9/Gvq+Nnm3P2XD2A7sBaHO0AoSpbIPWOlgKh2+OMX+6/s5Zm
         Mp7V6GA5LnyNzRsys1T28yb7IaBKNwUVKMEqk8fEktV+7t/hVClG17R8zaPGLR5WeDC7
         I+P7d2PGPyl1xmguajoBm/qXnXT9YtqwMcqqg65uMSW49rC8hS0BilC5zkTxTtID1X+Q
         2GcLyvySGgYykaoLLLTKroc5RZsbgGvKsCionEv0R38LBE98TJWXuHhPtVVFVUJlWbtf
         q1qZSPVVjB9S+hTQ1aS++Q5hY6CsLuU9ItDdDieyrAqybG0pCEX9cLGvf0eUasSa7hCc
         bOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tDquSSAfNDR9eLd+QjoRhiMCDCglkna06zdIP/k8lVg=;
        b=VCQrYkq6yTHOddsYDZ6iMCXXOuyTfVungZ2XAYDVyJCHTXYhT53QtqDb7DLFSJ6ER5
         wVlg0LLMU1gq6v6VhTsJZQnWyaMxPiivl5DALYVH4YPihjdfMBEZtFrTGRYwdeF0dbZf
         2MFKKCmcbBQbmXkv4P/B4104KMnXSdPPZNJ2kKMlR0+ZJJpHqMovG4kD/bOOxinnem0o
         S0xN4lU/ktvKuFX0CqA01I3y2yrnFXEQIbfe32BbS1o24vYJk0txLm24Nm29I+fKMMxn
         9aq0mIvFYwCwy8SuUGI0uYtq4HvvLhO7JgaagXzjrlTLyG90kHVgeMnAyfQKDy07HCTN
         yWGQ==
X-Gm-Message-State: AKwxytemMeE2F0PCnKs1AWkY//zM4qTOhJzDxM79N4jxm0pxVbSKd6PL
        Zduf5AjwY9tHqCRISwaBnjOsHg8yZ22OxAwiHs8=
X-Google-Smtp-Source: AH8x226/epYXO+BmmYz3clP+I2TovAIofelYtSnAhzV3Gs9LmRjhH2H1dFj506xxjTTe38NQuj2iXk4yxNxrqd6g0AE=
X-Received: by 10.176.25.67 with SMTP id u3mr11523149uag.44.1516998399486;
 Fri, 26 Jan 2018 12:26:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Fri, 26 Jan 2018 12:26:38 -0800 (PST)
In-Reply-To: <20180126192532.GA29438@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com> <20180126123708.21722-11-szeder.dev@gmail.com>
 <20180126185007.GG27618@sigill.intra.peff.net> <CAM0VKj=Qsbkog+rj94bZOk=G-XBsXAqQnRUo4eCXQq2LKjre-w@mail.gmail.com>
 <20180126192532.GA29438@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 26 Jan 2018 21:26:38 +0100
Message-ID: <CAM0VKjkXKcwjt1J+KwHYwcaTpb5COXX9ojBWJ4b4b+PRS=AsZQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] t: make 'test_i18ngrep' more informative on failure
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 8:25 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 26, 2018 at 08:23:24PM +0100, SZEDER G=C3=A1bor wrote:
>
>> On Fri, Jan 26, 2018 at 7:50 PM, Jeff King <peff@peff.net> wrote:

>> > You can also use "-x" to get a better
>> > sense of exactly which command failed,
>>
>> Yeah, I know...  but I have some issues with running tests with '-x'; I
>> suspect PEBKAC, but haven't yet got around to investigate.
>
> Some tests absolutely fail with "-x", due to them caring about the
> stderr output of shell functions. But with the BASH_XTRACEFD stuff, if
> you run suite under bash it should al Just Work (and I recently added
> TEST_SHELL_PATH to use bash just for the test suite without building all
> of the scripts with it).

Yeah, I knew about TEST_SHELL_PATH, but still:

  $ make -j4 TEST_SHELL_PATH=3D/bin/bash
  <...>
  $ cd t/
  $ for t in t[0-9][0-9][0-9][0-9]-*.sh ; do "./$t" -x ; done >/dev/null 2>=
&1
  $ grep '^failed [^0]$' test-results/*.counts |wc -l
  44

The worst offender is t0008-ignores with 208 tests failing with '-x'...
I suspect a setup test fails for some reason, and (most of) the other
failed tests are just fallout; haven't dared to look yet :)

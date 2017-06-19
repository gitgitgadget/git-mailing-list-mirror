Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042C21FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 20:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbdFSU5e (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 16:57:34 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34617 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbdFSU5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 16:57:33 -0400
Received: by mail-pf0-f174.google.com with SMTP id s66so59163099pfs.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f9BX9laXom3Vs3VLp2vlbZbq5F8sXEGF6hMkp0Onvx8=;
        b=K4ik1eGDgvW+1n8pUfHIByXmA4M+10KDLesOCHwE1i/PRtPl6gABYGhyNTl76Pb49/
         dSY/l7W/2WlS7rc++o3o4Zlkr8p/pSdw1DURwGCgScJZ1SNCdvFS1xugy7upgrqhD6se
         zeiKHnGXz2V8VWqBXx1KvWRW+Wm1jk8naVAUm+oWaDaEOSZPhZ5a1WDqqcPmj1RKuDsP
         TB/I4IOMhG8iCsu7zVLIt4sMnlRKfWqAdIU15/go23+PEDPT+5//SXYwjS9ekaSIW2dC
         vzAdqFdi+uE/pEEwIHNrbcv8HEQYaPMgMwhRG/I0vg635NZAM8YbcLCKRYoieGlhlDXX
         n1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f9BX9laXom3Vs3VLp2vlbZbq5F8sXEGF6hMkp0Onvx8=;
        b=sLBiNDeoqm/WqORzWzQ/04QIkkvHnnC7SeLRRe1aEVA2MIwnIfBB4xOei9c1JxzwPb
         BYFfeyPTuvf8gKSE5SkQCukV1/oPUr2CJoCjsJnS4f3Qdbih573PKRKwO4bgcKlbcMa+
         NwmUbI6T8J5WWmxqi3S1JUVUbj9VrgrFfZBl8p5m9r178wvhBV9RNdMKtLgNDTE1SmD2
         bR5TFq/I3sxs/XAW7i/vKDkinNB4F+EZ6969cSebm1icLhVoXQuC9UAHjkuSJLxyy5Fr
         KH8OKDeIQOGj4LMeiFfXjdbbVRuOY6hOPmBfNQXW23cRk0OuIKoQBdNaDmtkoy6XuIDA
         1SSQ==
X-Gm-Message-State: AKS2vOxQrvA7R5CNcqqSXFNRIRkBppDoLtr+G6rx5EmSJ3e6ULi39Vgc
        5i/2GR9QDqjICXxGJV+Q4qjLHmUw6Tj6
X-Received: by 10.101.85.69 with SMTP id t5mr28048720pgr.201.1497905852588;
 Mon, 19 Jun 2017 13:57:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 13:57:32 -0700 (PDT)
In-Reply-To: <xmqqh8zbspm7.fsf@gitster.mtv.corp.google.com>
References: <xmqqh8zbspm7.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 13:57:32 -0700
Message-ID: <CAGZ79kaVfX-M5R3KJHQLE+vT=15X5-sYV_oi++pNbhfaiqPTLw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #05; Mon, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sb/submodule-doc (2017-06-13) 1 commit
>  - submodules: overhaul documentation
>
>  Doc update.
>
>  Waiting for discussion to settle.

Please hold back, this definitely needs
another version.

> * sb/diff-color-move (2017-06-01) 17 commits
>  - diff.c: color moved lines differently
> ...
>  "git diff" has been taught to optionally paint new lines that are
>  the same as deleted lines elsewhere differently from genuinely new
>  lines.
>
>  Is any more update coming?

Yes.

I do have a series locally that replaces "diff_line" with
"emitted_string" (but the same structure) and also
changed the algorithm to have 8 colors configurable.

But then I got dragged away in "doing it right", which will be
presented shortly with a different approach for the
first patches and how they are refactored.

So the refactoring of that is done and I need to apply the
patches that bring in the new functionality on top.

Thanks,
Stefan

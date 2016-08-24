Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39711F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754485AbcHXQK6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:10:58 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33089 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbcHXQK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:10:57 -0400
Received: by mail-ua0-f193.google.com with SMTP id u13so1600865uau.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/LklGATm6okV4Nl8ffaDtXb5t3k2ADeDSYnVQSeIJAQ=;
        b=CTeUX86cdSCkYg4JR/78fxaFY8584dUrTQsiMe63RxXMltKqjBJZEffpxsdpxlxcNb
         fcv6mRo23b/CA0Y8vznmlsSafNLXmIi9g5EgT8XNllkHvbqsC7P/Ifg4Y71BPS7BZVZX
         XXGf/OFD4emVFHWhdNTtmbRwwyUFRjDXtwg99jgB4iJjjBnCVbHAZvs2VRNBidc9krqA
         CFOLOkg7TTTMucEr2L8Fh0vWUhF/UyZydHKYdMp8k8fmBA8AVXvKaNSpHzzqDd/IAZR4
         D1czQnEy3pBruA4ohD+1fwgWsg0IqnlsLY8PsgxeVhHSFVXl62IMZ26C340Sft2p6kfd
         GWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/LklGATm6okV4Nl8ffaDtXb5t3k2ADeDSYnVQSeIJAQ=;
        b=D/CapAL/kQ879oKdwZk7OoOkYxBtN1Zi8YOfUqo52trMds4BTjlWk3UQ8JGQKeZox5
         4LTSiCrwMNB5wmmt55mw3fGJ8veCTAllGlscGOyViFK9HCM7NH/BG1zsxgY9MkaAzK6R
         2R/0i4Gb+xeSA/0miPiIy2UCP6In6qzI21KA6c+zQmcKf2g1R+lPGfnVYLam6qp2WJmm
         e5GaY0JPHo/2vihRBKIjO5CUPa4nSPlQt1mf/zLYIlDJRAh+OVnJaarYryVbC2Z3dYLL
         XSDBSxN645KPG3agQ/9F86zBtva1obTJrncIfeuDUquIwGk43DjWnbtSXcB5BlZzlYwR
         VT1g==
X-Gm-Message-State: AEkoouuE8/7oD8Os92VpaGqFNqxKsKlbNp19QppXbxSCKUl/z1uCxWsHsN7z+/AP6IkySbKrf3JP5N86WU86XQ==
X-Received: by 10.31.33.8 with SMTP id h8mr2243397vkh.59.1472055056949; Wed,
 24 Aug 2016 09:10:56 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.4.230 with HTTP; Wed, 24 Aug 2016 09:10:56 -0700 (PDT)
In-Reply-To: <9efbdfbb-4c82-1355-1f89-5edca7135179@drmicha.warpmail.net>
References: <CAHd499DL2WiTgnk5A--qihUh-jF9m7aXDzHAQuW=bLRVW4Bniw@mail.gmail.com>
 <9efbdfbb-4c82-1355-1f89-5edca7135179@drmicha.warpmail.net>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 24 Aug 2016 11:10:56 -0500
X-Google-Sender-Auth: 8wjudEKne_Je5X5Rj4buEG5gLAw
Message-ID: <CAHd499DTkxAmLhEyGc4t+g1gFBnJpVRwgS5dhRRE=E+pUU5WDg@mail.gmail.com>
Subject: Re: diff <commit> using 3-dot behavior
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 11:00 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> The 3-dot notation means:
>
> Show the difference between the merge-base of master and topic, and topic.
>
> I'm not completely sure, but I guess what you want is:
>
> Show the difference between the merge-base of master and topic, and the
> worktree.
>
> You can accomplish this with:
>
> git diff $(git merge-base master topic)
>
> I guess a shorter notation for that could come in handy. OTOH, I usually
> diff against HEAD in a situation like that.

Great solution. I feel silly now, the answer ended up being rather
obvious. I can create an alias for that. But I can't diff against HEAD
because then I am not seeing a diff of changes already committed.
Thanks for your help.

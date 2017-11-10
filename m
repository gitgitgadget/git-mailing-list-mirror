Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC3F1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 18:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbdKJSMl (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:12:41 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:54669 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdKJSMl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 13:12:41 -0500
Received: by mail-qt0-f174.google.com with SMTP id c36so6665167qtc.11
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 10:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zo//nKfd7NmTLEN9OpVX5TgpLISWNOrCEEsk1rvwS7E=;
        b=TLHjfIZd67yYniX6bfHqqHQnM/kaAwJVpT03rJw0jVhBLoHAZoEU/HWTHDFo3LmLBk
         Uiab6rir8lwXEu0S3/W6FqPiYnL5ahE6A0aOPeIXQIyxOGgRGnQP3Grs0kEXhJCS8KC3
         dvYHo1DQ3Wj1AWJ1mz6cQzwtIAIzWEKHwFu2al89vaxCk1NqOFaZ+7axHdpf8vc/9aQ4
         s8MIshA1oavOSCRDLnCzk8E8JBd91ZvBlaQPMnB9J7yUOFCZiJGhEtMKymW7P2kn1rB1
         xygrIg8qtg3D6oBy0ioUt0Sl2NVLlC65QziE+NKly9yg3Zt6MSIY+Vst6vHgwc5Hi2wo
         mcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zo//nKfd7NmTLEN9OpVX5TgpLISWNOrCEEsk1rvwS7E=;
        b=MN/qoUXzBANUQdUeHOhJBE3paEV+nFiRE7tMFrf7bW78FRFBGZL2Vh9q/QJDofzcIW
         E9xZtatS/sTTkqYtHRkLNdaMGJaM8q7Ajheh7E8brt+nd5AbSJAZu4tedftgq+1Y34Qt
         BgKzI4GX27gQsY3Rd3HEpbgksZ08v8ePAh9JAtgbAzf5ilvtFlh3Efl2qNDE8PwBgfFZ
         3zmMddUwtWghrTKTZHiqZ6gRBgWL2LFAmdLnYcUx3/lhenreDh7K/7zEOCc2rmoH9osu
         scduZjGcK49yO/4rksS+EP+0OSpYB51qQRmC5PfqwcNx+elBq21rCWA3GS1b65wtM1As
         Zthw==
X-Gm-Message-State: AJaThX7NUC4+85yDbANQ9EvExRc/DOq8eFqXzLq+aj67kme7Qkh8Qnqi
        cvRkFjnuITAmMNMKCs6a2CaizoRRLQzZZAYd+ff+aAJz
X-Google-Smtp-Source: AGs4zMbzoDqss+EC+jPOAxf8woIQAT9oRd52ThvKsh72OZQdfk+nA7LFu1bqv+HTyfC3vBoxhbXoX5O9kT1vu0z3L3o=
X-Received: by 10.200.40.146 with SMTP id i18mr2001557qti.79.1510337560222;
 Fri, 10 Nov 2017 10:12:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 10 Nov 2017 10:12:39 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711100855140.3617@DESKTOP-1GPMCEJ>
References: <alpine.LFD.2.21.1711100855140.3617@DESKTOP-1GPMCEJ>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Nov 2017 10:12:39 -0800
Message-ID: <CAGZ79kavxFA_wBzcSbR8LT4uZGkdv4c07ZMfE4TK0tkooMGg6Q@mail.gmail.com>
Subject: Re: is there a stylistic preference for a trailing "--" on a command?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 5:57 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   just noticed these examples in "man git-bisect":
>
> EXAMPLES
>   $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
>   ...
>   $ git bisect start HEAD origin --    # HEAD is bad, origin is good
>   ...
>   $ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
>
> is there some rationale or stylistic significance to those trailing
> "--" on those commands? i assume they have no effect, just curious as
> to why they're there.

By having the -- there, it is clear that the strings are ref specs and not files
of such a name. (Who would want to store a file named HEAD~10 in their
repo?)

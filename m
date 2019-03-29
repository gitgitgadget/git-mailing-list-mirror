Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10AA20248
	for <e@80x24.org>; Fri, 29 Mar 2019 23:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfC2Xtj (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 19:49:39 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:35974 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbfC2Xtj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 19:49:39 -0400
Received: by mail-it1-f181.google.com with SMTP id y10so4638623itc.1
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 16:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Ggn/9GiePeWNiAgPqQYad4tqw1rwDm2G6QlR/T/DTB0=;
        b=pVnBVvo+8vGIKlQZp/2WuHQWjSJxyix6md77sxDRlSL6xdvagSXC4O8Xc3ovbPrlNx
         QX8XKsvk2TqlEJJSEXxn8CJoFi9X6AUYQtrvJfLNitfo+jN2W/10hbBP8JBernosEMBJ
         ZzRqaUdwqYD/IDD9xIGyl8sCWbOn8T9azEco3uhtS8X01kwd9IzKpmbW51+Uqs5Zbw0z
         Fu47xNd9ApXRmPSclhf14nYzQBUaA0zkDqObgc0a6RnEmrmMnXwtEEbDHcf/kt28VMAh
         6JdCR7NYyoLej6lrWwdqnLUiW7WuaMQ9Xd356cwSaNlywUDc3Tx9lGi6CeMzQPiuMED8
         jMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ggn/9GiePeWNiAgPqQYad4tqw1rwDm2G6QlR/T/DTB0=;
        b=KOkifa0e9cZk/Hcg8MvQ/jUoY9PXuilcwfjniis4ahku/vynpW2PYl7N987px9LIpW
         iBUzb4YkDVMQlOjfohLSQbRc5uxZ0L2F1HO62hriPcFkDcLxB5hSIDkepOr7faU8KXyo
         0wRbwZT9zPsNDOlH5CcDD+JZRv7G147hI9DyBHVRApIXK3b1roWuoSqjcZFR9l/UNOYP
         AoQV6WZjcmcwqrA0FqNSZuc10n98YFHq3DvNqsXsewVmJjp3sZgm0Xsk8Z1IDg/eQC5u
         2m97Vw46Z6ptOcV09piv1c7LDnX7Pt/Ho+pwo7ImzqKmOqJ3DI1cRGyeLtfpx4mGtLpz
         BEyA==
X-Gm-Message-State: APjAAAVB2ImFGtA366zF2zxN8PHOr+FREda8QVIpjKLwZOKwz3ebqyKX
        GkZ482CSEecd7LbtPNOX/M8U8UkzmgfvtMHTLMjcoQ==
X-Google-Smtp-Source: APXvYqzMo0kSIkb7pd59wk4mLFgKXaO016HMlHJvylBbFyYrw/571CCN54Ok5o9w+aaugT2dNfncTZvM5YZmSpDn2oE=
X-Received: by 2002:a24:57c1:: with SMTP id u184mr6749767ita.38.1553903377942;
 Fri, 29 Mar 2019 16:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1903061512330.41@tvgsbejvaqbjf.bet> <20190306213033.6vadunuwrj372dzf@glandium.org>
In-Reply-To: <20190306213033.6vadunuwrj372dzf@glandium.org>
From:   David <bouncingcats@gmail.com>
Date:   Sat, 30 Mar 2019 10:49:26 +1100
Message-ID: <CAMPXz=qa5GA6zynpPWTDpKeh0J=p2y31xA7gwk5Y7swF2z1OHQ@mail.gmail.com>
Subject: Re: "Give me a break"... well, you gave me one
To:     git list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 7 Mar 2019 at 09:00, Mike Hommey <mh@glandium.org> wrote:
> On Wed, Mar 06, 2019 at 03:14:11PM +0100, Johannes Schindelin wrote:
> >
> > just wanted to express my gratitude for your idea to introduce the `break`
> > command in `git rebase -i`'s todo list. I use it *all* the time now.
>
> +1. Before that, I was using `x bash`, and ended up doing `git rebase
> --continue` in that shell in many cases, which didn't end up so well

'x bash' will start another shell, that seems an odd thing to do.

I have been using 'x false' to generate an error exit status to interrupt
the rebase and drop into the current shell. Then 'git rebase --continue'
to resume.

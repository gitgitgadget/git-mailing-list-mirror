Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C691C20450
	for <e@80x24.org>; Thu, 28 Jul 2016 18:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbcG1SWH (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 14:22:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35060 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbcG1SWF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 14:22:05 -0400
Received: by mail-it0-f66.google.com with SMTP id f6so5384298ith.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 11:22:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cSvNV+kLfNbMsx0aV9A2d98/lTHJ0003kCSJwLgh93M=;
        b=iSWcY7O9sKn/K+neuRyHpervVHwVGqmQ0YvMazijvBPrpFji9LbMw3DaOjReXnXH8v
         IBlYwy+c8YzNT6j2hjnqQ7CGZgwez5LovPzAvGPFvWNH8n9b9FNKn3vP+jjmr/mDR7+/
         CtwMw1bT5jWGfp0Bfc0D0a/In6M19wmrI4wOekf5erZLj5xslfWO9CxP7rj14EJG1JjA
         TOtOHrdiDN6AzYMeXm2/fQSnYJ/wLO5rzkIwJR1g3gf9t+GPc5/jx+s9DtZKdaY3NzOT
         eHufCi0FFWnLNwOm4q8HYB1y26Kksu+B3M8UKbogAxrBQKIEYTTmBuQv+15A+61JrTgt
         +pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cSvNV+kLfNbMsx0aV9A2d98/lTHJ0003kCSJwLgh93M=;
        b=GXBRbO432afJ65jssCc9n5JNx/3znr0n0e/vKZzAJi+WSUYiMo0/Cy+zQ5nYVdJOtk
         NQd/yR/ncHPnHDEO/znbbguzDsYmm+KE7fPYQggEuiUcG/8YjN0IIXdSjOnQbHNw9W4q
         Bh0ls8l5tZ3aPGpHI7fMjrJU2VZR8+j3natbBO2U21UnuYa2qS3lZCVwQV/jOqw8PKyp
         dYp2zG7l1eJJ1BgR4FicodSIE8J8RDy1WGhFgDuQhzhADlfz6D9sYicrs61uG6/GBPdP
         MK9/p7CX2d0Cm6BYbSxZnJKObk3buFWvRuTmx1+H+t9+y/8xCSczcFei9fVxSbNSiBCi
         2KDg==
X-Gm-Message-State: AEkoouvWTn20AaaXMV2+YJ8uKa86g4hTmPjwJkIT529bfgkrNH6nIMkeEoocsRdScmWNMEYXzcNWGty0Ix5CdA==
X-Received: by 10.36.54.135 with SMTP id l129mr41231571itl.73.1469730123532;
 Thu, 28 Jul 2016 11:22:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.7 with HTTP; Thu, 28 Jul 2016 11:22:03 -0700 (PDT)
In-Reply-To: <fa512576-487e-9b9c-3ada-7f0d9b135e4b@kdbg.org>
References: <fa512576-487e-9b9c-3ada-7f0d9b135e4b@kdbg.org>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Thu, 28 Jul 2016 14:22:03 -0400
X-Google-Sender-Auth: j9AYJSDQZaTL-A72AiukikgXIeo
Message-ID: <CAPig+cSBZ_Vey2BW8S4D+7ufG1U3a-N402s4zZZJ2OE=xH1+tQ@mail.gmail.com>
Subject: Re: [PATCH va/i18n-even-more] rebase-interactive: trim leading
 whitespace from progress count
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 1:47 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Interactive rebase uses 'wc -l' to write the current patch number
> in a progress report. Some implementations of 'wc -l' produce spaces
> before the number, leading to ugly output such as
>
>   Rebasing (     3/8)
>
> Remove the spaces using a trivial arithmetic evaluation.
>
> Before 9588c52 (i18n: rebase-interactive: mark strings for
> translation) this was not a problem because printf was used to
> generate the text. Since that commit, the count is interpolated
> directly from a shell variable into the text, where the spaces
> remain. The total number of patches does not have this problem
> even though it is interpolated from a shell variable in the same
> manner, because the variable is set by an arithmetic evaluation.
>
> Later in the script, there is a virtually identical case where
> leading spaces are trimmed, but it uses a pattern substitution:
>
> todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
> todocount=${todocount##* }
>
> I did not choose this idiom because it adds a line of code, and
> there is already an arithmetic evaluation in the vicinity of the
> line that is changed here.

On the other hand, to a newcomer (not familiar with this patch),
${foo##* } is an obvious and intentional stripping of whitespace,
whereas taking advantage of a side-effect of arithmetic evaluation to
achieve the same is quite subtle and likely to be interpreted as
pointless, thus forces the reader to consult 'blame' to understand why
the code is the way it is.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> @@ -121,7 +121,7 @@ mark_action_done () {
>         sed -e 1q < "$todo" >> "$done"
>         sed -e 1d < "$todo" >> "$todo".new
>         mv -f "$todo".new "$todo"
> -       new_count=$(git stripspace --strip-comments <"$done" | wc -l)
> +       new_count=$(( $(git stripspace --strip-comments <"$done" | wc -l) ))
>         echo $new_count >"$msgnum"
>         total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
>         echo $total >"$end"

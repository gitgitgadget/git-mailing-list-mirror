Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D44EB20966
	for <e@80x24.org>; Fri, 31 Mar 2017 00:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934596AbdCaAj2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 20:39:28 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36766 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933345AbdCaAj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 20:39:27 -0400
Received: by mail-io0-f170.google.com with SMTP id l7so30504783ioe.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 17:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=retailnext.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o7D5eHtUxsw80Nr3H5eYTRuOK72fhU1UyKizuM5/YkY=;
        b=nbduAKIlpHOFWzZSWIkMZsKyk5SshQTrN+rg1Lnf3rTpqc2Edy/FLOx2UfgWcjPWZs
         cQdgEqsPCapnJkQPMbAx5IFUtkd5aJpPWT7X6uh01o5PoUpu6kJ748Suy44ffoI7Jc5q
         l12z9UKc9iesYNBSkifOOFQDMGdlz8tjbOYeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o7D5eHtUxsw80Nr3H5eYTRuOK72fhU1UyKizuM5/YkY=;
        b=tVqv/cF6SeAV7YfSuaW4LUmLHki+aFTHGTWXj39RgS+Mbcn+N4taH45QEtinDwvrwM
         G31UWfbiIgrzhZ1tYylV/MNyYlR1h2JQAn/FPw/ZYudcEuzIhVcm4WvFMQz4+d9rW4ek
         XYQZPW8GcEIYuz0IdS2/hFhjY01cQb5waOXryCOjMNICO2+izj95/+2fUGUVr3XcExGE
         eHlTXY3EeWOkQrz43eKqU/H0W+3VCIbti5X2pMgH3y2gefrrPxSaNLjLMvnhIY69ATo0
         kVI3hWy3nhE1s0D+MNW9Cq+MDTcatCvg5gbK+UzSCGbO5ndGG5qyctkAwyVORdKARW2i
         D2AQ==
X-Gm-Message-State: AFeK/H1E6FrTlWQlP4agulX0ted0Mg31LuubFVWwnrqy+A65BsNq14qnUmBbZzHy4bh4IcHOoNaz/BmmFH5QjPNe
X-Received: by 10.107.27.207 with SMTP id b198mr360559iob.218.1490920765359;
 Thu, 30 Mar 2017 17:39:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.230 with HTTP; Thu, 30 Mar 2017 17:39:24 -0700 (PDT)
In-Reply-To: <20170330233228.dfv5mxnwlppghmua@sigill.intra.peff.net>
References: <CAJF7t-dqSa7tmQqNEWmg_VZ=+832nsZ-3JmSGA03qK6aY5eNTQ@mail.gmail.com>
 <xmqqo9wi1ifw.fsf@gitster.mtv.corp.google.com> <CAJF7t-cAtR9yp2184pUsw+w3mf-SSMW4FUY27N8+f=6u7qjx3g@mail.gmail.com>
 <20170330233228.dfv5mxnwlppghmua@sigill.intra.peff.net>
From:   Nate Mueller <nate@retailnext.net>
Date:   Thu, 30 Mar 2017 17:39:24 -0700
Message-ID: <CAJF7t-cvCN1wMN1FzNPTG5zOC-d1g0GNxL-necZF7BOfUyrKog@mail.gmail.com>
Subject: Re: Issue with 2.11.0 and GIT_EXEC_PATH with multiple entries
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Got it.  Thanks!

On Thu, Mar 30, 2017 at 4:32 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 30, 2017 at 04:00:41PM -0700, Nate Mueller wrote:
>
>> Really?  My config has been set this way for years and it's never
>> caused problems before.  I have subcommands in both of those
>> directories and all work.
>
> Really. It did happen to work most of the time before (because most uses
> involved just appending it to $PATH). But it was never intended to work
> with multiple paths. The:
>
>   . "$(git --exec-path)/git-sh-whatever"
>
> advice has been advertised in the documentation for years. E.g., see
> bd870878f (Documentation: don't assume git-sh-setup and git-parse-remote
> are in PATH, 2008-06-29). So even if we wanted to relax the rules in our
> scripts, it seems like a potential hazard for 3rd party scripts.
>
> The recommended way is to just put your ~/.git-exec into your $PATH.
>
> -Peff



-- 
Nate Mueller - Head of Engineering - RetailNext - 406-356-6283

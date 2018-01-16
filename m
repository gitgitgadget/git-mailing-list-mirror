Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A173B1F404
	for <e@80x24.org>; Tue, 16 Jan 2018 20:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeAPUIi (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 15:08:38 -0500
Received: from mail-yb0-f176.google.com ([209.85.213.176]:46294 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeAPUIh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 15:08:37 -0500
Received: by mail-yb0-f176.google.com with SMTP id y77so3761243ybe.13
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 12:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iQjix8DtAETN/6C6rqjeqMGmWG5d0WhIbzdjxp7mmZc=;
        b=ak47lo9RDAxlE9N6UYYyi7j4094JY6R6yAycppMOW9rqxF/DALZ37dFyr4+rj5N0ir
         RyeC7Oft9K2JkNLzuKuS/vY1K3q/tt/GSXuDBB0WdZrT/7bUpcKbnScW2jObBY23+9y9
         fQtmQJFRIK9iS5rKvYnc+Nu2t4ORGLSWe0itvdVk7WISBlayhDpchxaRMnn0FzCpsKmf
         FQNb+DAtsZw4iCRA3gUjHGemIJkUui+yUxagmVXocPJLC4pYxzrHHt/eajckT7l+j1o/
         FYAhvPufc+A/Dw9jWpg4qjFJxODDI1XDbHhponigrYjBZ/sx14uqIFWa1TibmjDXZRgk
         stEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iQjix8DtAETN/6C6rqjeqMGmWG5d0WhIbzdjxp7mmZc=;
        b=nEmY7349LBJYGK1TF5e/LlGcDWqgpImqqtpUhk87+hhStvzYIeTsEllpaqKoe0eGLG
         3jfEwdBsmjAIilvunKhdu6hI3/QAUkYS5S4HiieEpn+2RoIqLGz3QyX79ln/jZjVbOEl
         q6X4dfrVSjx8ZJbuqQP3CDTVwPjre6+49uL2s0neX2q/Bn10AhNmlnlVX4pVjIxeTCxy
         Y1/qi1HVvv4BPdIzPqLyjOgZRCcSakpPCCaiKKqEoyLdawzBLxWwaOubgPHJegDYqtH3
         +2AcMab48P82VSwiuOizefpBxRHL4zjRCQ0kFX2UoFSa6OugsEHNngbapp9cuZ0KzHGK
         SGJg==
X-Gm-Message-State: AKwxytd9UuOIpq98RbFs3UubYJllp+YNsbilzX1El6P06sE6hC7DDj1W
        8OkaE9gGEwMrmvdhhwAovQUCwhqYlxpoHkiFWUKWzw==
X-Google-Smtp-Source: ACJfBosJmX1SExCqDkdTzceihuJU6isv6b93jnea7ZHgEyMBfGs0NVggtG11z5m0t7LScm4QDAv1uTg1W0r/7yG6mtA=
X-Received: by 10.37.34.8 with SMTP id i8mr15844749ybi.114.1516133316520; Tue,
 16 Jan 2018 12:08:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.134.197 with HTTP; Tue, 16 Jan 2018 12:08:35 -0800 (PST)
In-Reply-To: <q7h9lghcob2s.fsf@orange.lip.ens-lyon.fr>
References: <q7h9lghcob2s.fsf@orange.lip.ens-lyon.fr>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 16 Jan 2018 12:08:35 -0800
Message-ID: <CAGZ79kax5Hip1wP3U60im__Dm0GvH8nNd+ByxG5OxMXrRkRvdQ@mail.gmail.com>
Subject: Re: GSoC 2018 Org applications. Deadline = January 23, 2018 at 18:00 (CET)
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 5, 2018 at 2:26 AM, Matthieu Moy <git@matthieu-moy.fr> wrote:
> Hi,
>
> The Google Summer of Code Organization application is open. The deadline
> is rather soon (23/1).
>
> Like last year, I won't have much time to dedicate to it. I can try to
> help, but don't expect much from me.
>
> The first obvious question is: does the Git organization want to
> participate? If so, the application process itself is relatively easy,
> and anyone can do it (no need to be officially part of the legal
> entities behind Git or whatever): just create an accont on
> https://summerofcode.withgoogle.com/.
>
> If we go for it, we need:
>
> * Admins
>
> * Potential mentors
>
> * List of microproject and project ideas
>   (https://git.github.io/SoC-2017-Ideas/ and
>   https://git.github.io/SoC-2017-Microprojects/ are good starting
>   points)
>
> * Fill-in the application. Essentially update and copy-paste text from
>   https://git.github.io/SoC-2017-Org-Application/
>
> Regards,

I'll be fine as a co-mentor this year.

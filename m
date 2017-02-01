Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC301F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 20:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbdBAUhc (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 15:37:32 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:36516 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdBAUhb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 15:37:31 -0500
Received: by mail-it0-f45.google.com with SMTP id c7so25474766itd.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 12:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=esDAmIaNUwKs1U0kYrB33ZnP1CtetvYIDMr+QxpJoLs=;
        b=YvcXHrs+C+L/cx64cRUlD/EWA33mN3C7KPeXPrG5FWxzaSuR36CsZzwFddKUkrNSQh
         GfqpKOz/Clu3hd2rdwtoz9vtmiF9i6mRsfgaDFOYOI6UTeJH5arxnd49EGalD+sZ/+Z7
         ZgyAgndSfS0jolIP9rXkwjFHwmR72XO6hb/QYpjf4upv8c42J6OnCP41oeQDQYbgaSd+
         IbVyW5IflkzpzvR8aZtrvLCusPLjscPve3Vze8/ay97ndlE5bjcEwowiViJ9FF5XqX9D
         bLXjb3knh/pg4BvoGcHf5wkOwztIHSMHMlg0ba+jjyTep8EtZWwHjIZbBJbHZn8KtlCQ
         2ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=esDAmIaNUwKs1U0kYrB33ZnP1CtetvYIDMr+QxpJoLs=;
        b=BV02IOiEI5smhOaAvD8mZ9VwOkNqxJ5VPdMLPVwHjA4PX2isO/LVnmwsTHdmxghMmm
         5LNDfgkz7/N7AG7p2b2WU1WW8bnXBrPDBAKdjxW7f5fEoQTKtbGOvTAW+RYQ9VD/m5Ut
         ZdbI44L0mGU3QTb8a4gl+9Zfuc/val/B0nwZiEeBD+4OSi1G6r5OyFNbghN7nJbQnfca
         mgKrRhnNM/1geEoSWVrRyL+oINhxmjZTJS4w+lZUtOZ3hschZAxNXJY6EgR2cnx1DVZj
         ZeLAoGKJUvtjcfS4CJ870rd/4oqnomv11DajTQ4uAACsvCL5RkGsFU5deIaKCPJyVXjp
         c9Xw==
X-Gm-Message-State: AIkVDXK2jlVDFnLayRsL/3SzIllnOivcSQA8hhZt9bNseMHgs8c+Vzo4Y23ww/KCc+8w08/0hk4lLRwH0b+Z4CGA
X-Received: by 10.36.65.4 with SMTP id x4mr25836426ita.69.1485981450391; Wed,
 01 Feb 2017 12:37:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 1 Feb 2017 12:37:29 -0800 (PST)
In-Reply-To: <20170131004804.p5sule4rh2xrgtwe@sigill.intra.peff.net>
References: <20170131004804.p5sule4rh2xrgtwe@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Feb 2017 12:37:29 -0800
Message-ID: <CAGZ79kZyHyhaBSgP+jt+SRNx51t5XVQB7H0=RSS31wqAcQCptQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Merge Contributor Summit topic planning
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 30, 2017 at 4:48 PM, Jeff King <peff@peff.net> wrote:
> The Contributor Summit is only a few days away; I'd like to work out a
> few bits of logistics ahead of time.
>
> We're up to 26 attendees. The room layout will probably be three big
> round-tables, with a central projector. We should be able to have
> everybody pay attention to a single speaker, or break into 3 separate
> conversations.
>
> The list of topics is totally open. If you're coming and have something
> you'd like to present or discuss, then propose it here. If you're _not_
> coming, you may still chime in with input on topics, but please don't
> suggest a topic unless somebody who is there will agree to lead the
> discussion.

submodules and X (How do submodules and worktrees interact,
should they?, Which functions need support for submodules, e.g. checkout,
branch,  grep, etc...? Are we interested in keeping a submodule its own
logical unit? Do we want to have dedicated plumbing commands for
submodules?)

... would be my line of talk,

Stefan

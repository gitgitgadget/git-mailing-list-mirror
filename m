Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3090D1F89C
	for <e@80x24.org>; Mon, 16 Jan 2017 06:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750907AbdAPGAh (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 01:00:37 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36560 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdAPGAg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 01:00:36 -0500
Received: by mail-lf0-f51.google.com with SMTP id z134so70339563lff.3
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 22:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7zN4b54vP1lKJ2wDPa4Qdh8kucFG9m+AsXWo6XUo9tM=;
        b=CA+ZfBZTHZ9PFW2mJEyGkSdqZv024yMrTT+O+wrMGfqZU+BcsXkxbBEARewLliwTnT
         2TQzotziIjVODJTGsZ1J3hwV2N03bW+JRYI3/8H/GOd+JTNnTnKAxnHXr2cS9mRa7wLa
         V8HKk7W9CF4W3G7U0pGdv4BlgCNV0W/QjMYWUZBSO5ISI0mbBYZY7gEQNtfxYhMg5BVK
         k2XdaQjsQSpeVLTW3IkztuJc2pgfM83Uff5o53zffjA5RossqTmlKGArQl+z5hc5I2g7
         HRZTO2cAtSOtULS+SeuUGKoZ1GPXIbkeGWdGsBSX1a/n11jHcENLhc3S177AFKUsu3A3
         +46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7zN4b54vP1lKJ2wDPa4Qdh8kucFG9m+AsXWo6XUo9tM=;
        b=nVQHO9q3lxe5ps2lfR7eG/EKFq4K/mRZpO+vwMazDVkE5ImbV/og0tH/6u3EGxjSdL
         tzbti8npW5PlLLFsFN6gT07Phx4GQK9cd+xXnf4fMuTh8cSqtGL8jYhH0rvUrQDeQfSy
         g1+hzU5wQivVORPn3nq6/Xa6d3eKZp3tBpu0jDS5mWPOTEa4foCtdTzUp4/3ezIwj+l0
         GiIbZFgS0Pp51HEdOteCRepGFMvDaaeUwXJa56xD/ppA7BhDWgyNMe9taqjQMqpXxfrg
         TDeLnDQQ43AYVS5iSq7A1MGnXG11glbblNeM/dVSxJi6N+WPgG6f+rNEfAQnGqKPZKg6
         poIQ==
X-Gm-Message-State: AIkVDXKOd21uD0PIzqYnnDO1VrIcxQD8T7MTyVlEIfu1QCGHyxukenqAfeyxooFsiGnYOuy3DMi6sFy8PFW6zg==
X-Received: by 10.25.141.147 with SMTP id p141mr11815470lfd.147.1484546434703;
 Sun, 15 Jan 2017 22:00:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sun, 15 Jan 2017 22:00:13 -0800 (PST)
In-Reply-To: <CAP6f5MkOoDUqHCvLNQ+xJGWTbrdecet9W_JK5y7JeAnBpGeAaw@mail.gmail.com>
References: <CAP6f5MkOoDUqHCvLNQ+xJGWTbrdecet9W_JK5y7JeAnBpGeAaw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 15 Jan 2017 22:00:13 -0800
Message-ID: <CA+P7+xqcU96siyNrjNF8Tze4Nbf3k-oJBZ2g8xeYLU92AX-0rQ@mail.gmail.com>
Subject: Re: Different merges from translation perspective
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2017 at 8:41 PM, Alexander Shopov <ash@kambanaria.org> wrote:
> Hi all,
> What is the difference between simple, fast forward, automatic and
> trivial merge?
> I am updating the translation and the only thing I am sure about is
> that these four are not octopus merges,
> Fast forward is when current state is ancestor of tip, automatic merge
> is when the merge algorithm is decided by git rather than developer.
> What about simple (git-merge-octopus.sh) and trivial
> (builtin/merge.c)?
> Kind regards:
> al_shopov

Hi,

I'm not sure exactly what the documentation says regarding all of these things.

I know for sure that a fast-forward merge isn't "really" a merge in
the sense that no merge-commit is generated. Instead, the current
branch is simply fast-forwarded to the new result (since it's a direct
ancestor of the new tip.

I don't really have any answers for the others.

Thanks,
Jake

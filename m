Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9981F404
	for <e@80x24.org>; Fri, 24 Aug 2018 22:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeHYCaZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 22:30:25 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:51695 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeHYCaY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 22:30:24 -0400
Received: by mail-it0-f43.google.com with SMTP id e14-v6so4219278itf.1
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 15:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iS04hnDePmreWyEbdjRSgiy2MxRfKWGQjrTc/wsLWs8=;
        b=afRv8OpJcSSDIJPh0PXmmxqsra78dcqM5GhC7OKUbf72PkuevHY7KkdHbd+atJhNWs
         74ApYFb5reQ0LknsEgStF9b3z/GboAQrpZ/2BeLNYkKni37ODHF3F9mwIDYZhAykNujf
         CneUVj4u08MN1aTdaf7dxXazvJL0ZHJY3S1yAZjcA6nlBAA1ndXMjfu8NlQO0h5YlAQ/
         W1+rZex8syA18npQIfh6Wj85IGPWe7A02yEavHVLv7r7hXe3JYSO197nHqAAC+uThkJr
         pRonAySR91I2woUWq66B+SXmwrDJCEaBlePIKNeAhOZgFH1KoJKWoCz1RuBzxT2aR9KH
         COVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iS04hnDePmreWyEbdjRSgiy2MxRfKWGQjrTc/wsLWs8=;
        b=nPnmjiJW5eNOUxmPEaFp0DTK7rJssYBYthoVHnx4OF3a9PtboK0bzWnvt2P5jeb1t3
         HayxbsWY8RBb+4SaQwg5FaRPNF5NCMer6O383CmqvzGh3YMLinHZdsI9TM/hKhdkW9zf
         rxm/YLF8jfMP0JzQZsLtZwnz755uI7rDMv35BIiIekRTnPPiqewpRQ0O77SPPXmEumkd
         /xLdQ9Sjv/0KCqhPEw5/uPZDCwJca8UKreaAlvaabar+nZhts4s4brqGmvyRo7sphjGe
         QEljjRq77bq8IrdR43uZ4oNmEpMRzQehr+48+OTPsboqLdwweA/GGXkWrZxoyt52PDAh
         1R8Q==
X-Gm-Message-State: APzg51BVjqM6pFyc/5UgaZ/xY58mv2ly8RSKVSqw6LrU2+LHTE7W7/YO
        xVKAyKsVaNUMdCA1/AU4aO1nq9vX4GqZ9ppW1aHhCg==
X-Google-Smtp-Source: ANB0VdZOm1lnA+OpEskbM4TOiYx23pUoj5Xa11+iLzMCjCh8vxvWEcNroNqdFgCItlpzt1cedXlX8xJXfTUY+DEJUiI=
X-Received: by 2002:a24:764d:: with SMTP id z74-v6mr2876215itb.34.1535151225851;
 Fri, 24 Aug 2018 15:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1808241320540.73@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808241320540.73@tvgsbejvaqbjf.bet>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 24 Aug 2018 15:53:34 -0700
Message-ID: <CAGyf7-FB6oBpKHTBLoqviu=Ymk0Ksi_EHrxM6-Z4YK44w0kpYg@mail.gmail.com>
Subject: Re: Request for testing v2.19.0-rc0 *with builtin stash/rebase*
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 5:14 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> For that reason, I was delighted to see that our Google Summer of Code
> pushed pretty hard in that direction. And I could not help myself so I had
> to test how much faster things got. Here is the result of my first, really
> quick and dirty test:
>
>                 without builtin stash/rebase    with builtin stash/rebase
> t3400 (rebase)          1m27s                           32s
> t3404 (rebase -i)       13m15s                          3m59s
> t3903 (stash)           8m37s                           1m18s
>
> What can I say? Even if the numbers are off by as much as 10%, these are
> impressive improvements: keep in mind that there is a lot of churn going
> on in the test suite because it is itself implemented in Unix shell
> scripts (and hence I won't even bother to try more correct performance
> benchmarking because that is simply not possible when Unix shell scripts
> are in the equation). So the speed improvements of the stash/rebase
> commands are *even higher* than this.

Thanks for taking the time to make these pre-releases available. I
appreciate the effort. And the same to Junio, for always posting
release candidates. We rely on them heavily to find changes that might
cause issues before admins start upgrading in the wild and find them
for us.

I downloaded both the rc0.1 and rc0.2 builds, as well as 2.18.0, and
ran them all through Bitbucket Server's test suite a few times (to
ensure warm disk for comparable numbers). I added support for some
"simple" rebase cases a few releases ago, so we have a set of tests
that verify the rebase behaviors we use. (We don't use git stash, so
we don't have any tests in our suite for that.)

Running our entire Git test suite (~1,600 tests) against Git for
Windows 2.18.0 takes ~5 minutes, and 2.19.0-rc0.1 produced an almost
identical duration. Running our tests against rc0.2 cut the duration
down to 4 minutes. There were no test failures on either pre-release
build.

To try and get a better sense of the rebase performance improvement
specifically, I filtered down to a set of 14 specific tests which use
it and ran those. On Git 2.18, those 14 tests take just over 19
seconds. On 2.19.0-rc0.2, they take just over 8 seconds.

When they do ship, whether it's in 2.19 (by default or optional) or
later, the changes definitely offer some significant performance wins.

Thanks again, to everyone involved, for all the effort that went into
designing, implementing, reviewing and releasing these improvements.
As someone who develops under Windows most of the time, they make a
big difference in my day to day work. And that's not to mention all
the Bitbucket Server and Bitbucket Data Center users who will enjoy a
snappier experience as these changes make their way out into the wild.

Best regards,
Bryan Turner

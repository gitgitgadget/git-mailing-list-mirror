Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF81E1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 10:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfBFKZi (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 05:25:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34865 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfBFKZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 05:25:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id z18so6146417wrh.2
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 02:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yqaugAvQamQUXPmIDtMVqWZ1yJBHrnH8nmlimsJOxEw=;
        b=BiJ3ibCYE09GmPqq+3iaBcWPMtFs0AwgN6ARZXGlV+OrcAoADpcuSCRSOuHTOS0S7J
         wljsKtdpakh2DgXppYR7zSids1lo4HCaSA6IU7V3BWSHOPclxpcegBh/gQZjmEJjNJ3K
         FW/IRoOKxeojFnhZ3IKK4mdvdm1wMTq4/BbGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yqaugAvQamQUXPmIDtMVqWZ1yJBHrnH8nmlimsJOxEw=;
        b=kbQNW7MDzwwQk3tBvj2MA+Od2yGqxsePwLSBqCl+BK5XAYvBqZAzIO+MfQK2mhzJ1A
         dreMZ0tzlPrli9fqnl8SmFlpnfen1HS9evwt4j/GQ1ZqD/Q6ZEQPO4lp4EmGFgoD7XQa
         ocJcF1UUkG+saHNHJddG0hil7/unH0N/D/DstABEjAtTPpaS9C0L/OKA71A8gC+lLI28
         SlvL5vmOSnUA6C1BivR78dYycJYdudW4uUit1KHCaA3QOh6h2Y3j4mV6vFFvZXuDWNer
         9+5ud4U+yggO8RtFWpV4TC9qTXufzsUFLRcAe3aR5ssclV7Fw16YYsrJ3tLKoYgw0Wgm
         NFcg==
X-Gm-Message-State: AHQUAuZXQQrObWqOKP/O00dNQ2xe0q/do4h40MlujbYqeAgvqmdTWLg5
        I7defDa6fpCkL7CeRhX8ap2MLVqyJWJCwyVaV/DWGVwM/KlvEg==
X-Google-Smtp-Source: AHgI3IYIUGIBlX32t3g3NzWvVINCmItXt/L6E3K0H7VRAQv+cQduPEZEXXHhKlbKh5MUqEY+IxmtgdzWV6C7EK0h2fA=
X-Received: by 2002:a5d:5443:: with SMTP id w3mr6879460wrv.4.1549448736241;
 Wed, 06 Feb 2019 02:25:36 -0800 (PST)
MIME-Version: 1.0
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 6 Feb 2019 10:25:25 +0000
Message-ID: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
Subject: could not freshen shared index ..../sharedindex.0000000000000000000000000000000000000000'
To:     Git Users <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've recently started seeing a lot of this message when doing a rebase:

   warning: could not freshen shared index
'/home/ldiamand/git/dev_full/.git/worktrees/gcc8-take-2/sharedindex.0000000000000000000000000000000000000000'

(There's a repo called dev_full, and I've got a worktree where I'm
working on my 3rd attempt to make it work with gcc8).

That file doesn't actually exist but there are a bunch of
sharedindex.XXX files in there with more convincing looking names.

2.20.1.611.gfbb209baf1

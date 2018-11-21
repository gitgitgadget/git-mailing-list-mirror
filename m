Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A5E1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 15:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbeKVCN1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 21:13:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45914 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeKVCN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 21:13:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so5212511ljd.12
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 07:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fch5f0YoDDXs5lg981hv96wYWMHJ1EKYtGJjI7/8tG8=;
        b=VzuGMUSXit+uNtu0IvXHx5uxM5X02PSBTknbgvr+nD+3V2N73zjNvnotlwSzGIcV/h
         oPciPBA+6vnaIZrSupFNPa9M6+x5gHEwCh4Bf8wVZ7COaTOpjb/104kJM3LKyA2gIMsb
         HZfsokocystUEDQ9IinrMzALN7M8gHhS9mP/iuX68Qyh4UWT27/tdjsKMnpz+KyEraC0
         qqJ9SLmaWQcl+X7rK4jQ0ojPeQRBJ/fMjIKlas5onBEFilkRGZEeyT+9gJrQEz/CJ79W
         WnAAAzFooiSsNzB373hBFI/5fqcgMX43Z1Wir5dlDVev6FHr+K9fEyxd4ZBn58PhvZL0
         vMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fch5f0YoDDXs5lg981hv96wYWMHJ1EKYtGJjI7/8tG8=;
        b=jLIj9VJlDfY48R5puSj7djxh7CWKMe4xuzRNAWU6yDfAAcZQxEDxJUCJ1MuJvYoMvc
         1s+ys5GxXf8AurhCDV6b12qKmsbYeuQm4N2YYMLzy2F1MjyktAS8bvdYAbUxJk/NBymI
         +LhYfvUxPUJmtrGUErTxq85+Z8AtenrLZ3WVzq91qcGqQ9DNc4A9S/6LemipmrvC1izn
         tJdGMt+psf29rKi61UBhr4u1UMW7NCLKq3QTNjfL9vAnBQKjBxoHhUiEjOySJUwjkaxI
         ZF49fjh6tDTOBm4Z+3cs0XI/QQdooUac/5/Lp1MFU+xnxYdc+nIvgvPMBlkfhcLMnBFM
         vbLw==
X-Gm-Message-State: AGRZ1gK4Vjd9heeVTTTclxiDFft5akIAXhYmueDtyEZ41ySekLMS5D97
        nzqbhHOjUnmHE2Ac6xvmV646bwxQ65myGxnsJjj18mMY
X-Google-Smtp-Source: AFSGD/VChEnT1LhPfaRStGH7IIvZN5mwbRAW6GLdUcExjJ0i/Oz2vfpNLpOdSgJ494lqlulhu54HREDVvuNzPJWtMqo=
X-Received: by 2002:a2e:117:: with SMTP id 23-v6mr4260676ljb.131.1542814710049;
 Wed, 21 Nov 2018 07:38:30 -0800 (PST)
MIME-Version: 1.0
References: <CA+onWPcgHMCffjfNO3wxMwVD2bOJzWmwtYtrj9QakDUEA=OXqQ@mail.gmail.com>
 <CA+onWPe9hmr36xvc9F58KwW5fyby-wn6F2hiJy9ce__sA1mSjw@mail.gmail.com> <20181121144453.gnqcn5ugvd2yo5jl@tigra>
In-Reply-To: <20181121144453.gnqcn5ugvd2yo5jl@tigra>
From:   Jamie Jackson <jamiejaxon@gmail.com>
Date:   Wed, 21 Nov 2018 10:38:18 -0500
Message-ID: <CA+onWPf71VU9r9S6MxqEAxxCF+9gqMLoPdmOb83NK+MJDUAM8w@mail.gmail.com>
Subject: Re: Fwd: "show-ignore" problem after svn-git clone
To:     kostix@bswap.ru
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ICF2008571:eclipse-workspace jjackson$ git svn clone \
>   -r 95115:HEAD https://mydomain.com/svn/HUD/onecpd \
>   -T trunk \
>   --no-metadata \
>   -A ~/eclipse-workspace/scraps/git_migration/users.txt \
>   hudx-git-migration
ICF2008571:eclipse-workspace jjackson$ cd hudx-git-migration/

ICF2008571:hudx-git-migration jjackson$ git svn show-ignore
fatal: bad revision 'HEAD'
rev-list --first-parent --pretty=medium HEAD --: command returned error: 128

ICF2008571:hudx-git-migration jjackson$ git svn show-ignore --id=origin/trunk
fatal: bad revision 'HEAD'
rev-list --first-parent --pretty=medium HEAD --: command returned error: 128

ICF2008571:hudx-git-migration jjackson$ cat .git/config
[core]
repositoryformatversion = 0
filemode = true
bare = false
logallrefupdates = true
ignorecase = true
precomposeunicode = true
[svn-remote "svn"]
noMetadata = 1
url = https://mydomain.com/svn/HUD
fetch = onecpd/trunk:refs/remotes/origin/trunk
[svn]
authorsfile = /Users/jjackson/eclipse-workspace/scraps/git_migration/users.txt

On Wed, Nov 21, 2018 at 9:44 AM Konstantin Khomoutov <kostix@bswap.ru> wrote:
>
> On Wed, Nov 21, 2018 at 08:37:03AM -0500, Jamie Jackson wrote:
>
> > I'm brand new to svn-git and I'm having a problem right out of the
> > gate. I suspect I need a different ID, but I have no clue how to get
> > it.
> >
> > Here's the failed attempt:
> > https://gist.github.com/jamiejackson/57e90302802f4990b36dfe28c3c71d13
>
> Please post the content supposedly available at that link in your mail
> message, inline.  Otherwise it's impossibly to sensibly comment on it.
>

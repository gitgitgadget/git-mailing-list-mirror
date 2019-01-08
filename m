Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE1E1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 15:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfAHPpi (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 10:45:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35663 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfAHPph (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 10:45:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so4543155wrb.2
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 07:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=TjwS8l5T9c/tE9HaGIUaktPYp/r6+9LounUjZ3HE1oI=;
        b=T+oUODhaOL6fNEm7EcrmnQBT1p0PJ9ECgvI2WMCAQ2j9QX08Gb29dJJORcos1eLokj
         ZXk1rm4uxuSIu9GGGt5apLbzWj0KsNkGpFVrTPnwqCda72s4vgOkK7UL763y1MVFKReH
         /x8a65h58jlSBOsr0smMd+1zyR5doEwkzRh5G93lBBf55oZ872cU5WsTUidIxgCFzsuE
         PHK+FMjz/QU6IvFnn9T/cN5ILwXcyqio1YqtcLhdnG/SGNaul80nw2w5M6NshsA2Xd7j
         lYZRbcMk8pyYRQXrwlVmVYcPNUEygLtt1JiD4ZYfGd1rdENgmFMze7zWpPMIUrPYs/79
         z+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=TjwS8l5T9c/tE9HaGIUaktPYp/r6+9LounUjZ3HE1oI=;
        b=Z7khKrsCAZ46U0sps16I+Riu2GK38pZtA69utQW8GWD+BloSVa1cQRuGNmdVl2TcBd
         K8PxZygGPzt4OmLAE94csHsYqXUP3mmXhC7fl5cDFKo/KcC68Vfs683oNM8WOTdJQcAq
         bomy1GYohUEkXTw4PUVwWpYQmjKtjGv8thelcqlzRC8g/8mGwz6jzVVTySqdZvzXezgR
         TY31V6cTAfvWAV8lNGJuKNKdXBCXnJECTjxLPkfQ8GmZSM+pyUdSH8DdDZGdEAzrz+0N
         VzTmlZG0rtByBIcn1Egr0zosXKZveHEh5CgV7QhsJcnO7JnBJLWpJN4xDBwja+qFNXR5
         OoJQ==
X-Gm-Message-State: AJcUukdTq5DmG1GHMtnH1ngeSJKeEj1lm9ahObmKqQtYdNfBvgwD9NQ+
        EIgIV7Z2Wtc0OdxPCkg5mj6pjUAe
X-Google-Smtp-Source: ALg8bN6yJow5DzKc4CQLCSp9ZzaCYx8g2lZnAT/Or1HNtqd1GffA3U9TAfxrFND/1AxCBcr1YsdAtw==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr1818415wro.35.1546962336041;
        Tue, 08 Jan 2019 07:45:36 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id v6sm43878664wro.57.2019.01.08.07.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 07:45:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Harald Dunkel <harald.dunkel@aixigo.de>
Cc:     git@vger.kernel.org
Subject: Re: git-lfs integration?
References: <79fd2b4e-243c-a9f5-3485-2954fb0f50ef@aixigo.de>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <79fd2b4e-243c-a9f5-3485-2954fb0f50ef@aixigo.de>
Date:   Tue, 08 Jan 2019 16:45:35 +0100
Message-ID: <87k1jf6tls.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 08 2019, Harald Dunkel wrote:

> I wonder why git-lfs is needed to efficiently handle large files
> in git. Would it be reasonable to integrate this functionality
> into the native git?
>
> Please excuse me asking. I read some pretty scary articles about
> rewriting history, asking everybody to clone existing repositories
> again, and strange errors if git-lfs is *not* installed. Apparently
> this is a one-way street, so I didn't dare to install git-lfs yet.

It depends on what "integrate this" means.

I think it's unlikely that git-lfs would be integrated as-is. There's
various clean/smudge filters like it that do remote downloads (also
git-annex). Everyone's probably better off if git itself maintains the
infra needed for that ecosystem, and users can vote by their usage which
one(s) they like.

But in more general terms the problem of making git natively friendlier
to "large files" is being worked on on multiple fronts.

For one, Microsoft has been upstreaming parts of their GVFS fork, if you
search for "partial clone" in release notes since 2.16.0 (including in
2.20.0) you'll see some of that work relevant to that. I.e. one part of
this is the general ability to have partially available local history,
whether it's skipping (big) blobs, some trees etc.

Another effort has been the introduction of the v2 protocol to Git,
which has happened recently, and is only now starting to get rolled out
at various hosting providers. That in and of itself hasn't helped with
this, but allows for future extensions to the protocol, such as "this is
not the full data, you can find the rest at xyz".

Then there's the "odb" effort, see e.g. here:
https://public-inbox.org/git/20180802061505.2983-1-chriscool@tuxfamily.org/

I think that long-term (5-20yrs) those effors will probably completely
supplant the approach git-lfs is taking. It's a very useful tool, but
ultimately a bit of a hacky workaround in lieu of addressing fixable
issues in git itself, i.e. native support for partially downloaded
history. But getting to that point will take time & effort.

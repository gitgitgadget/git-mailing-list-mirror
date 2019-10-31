Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71F561F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 18:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfJaSTZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 14:19:25 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:39869 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbfJaSTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 14:19:25 -0400
Received: by mail-pf1-f182.google.com with SMTP id x28so1698868pfo.6
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mcik4lcIZ1y28TCf3ymbadTNay8dyte5vodS6dDO4ok=;
        b=XeNAYaIkmZ37iXgAbZBaKk3YLztaZDacrRkppiiKXDlGhof5drhYU70o0oQUbR/7BC
         C2EG2DkI8Rw1GtsGr63Ahq+0xHz81ai+9Tv8dexZ9IYDCWehxFVE1vQmbUDJ5+uUbIiu
         51MHq0MRAn0v+bNjfI2orjxDnxJSPWcxD289xKf50bBFuVLQbwiV0WcspQIvv82kuLjZ
         xI9dE7XDuTZqyDX8NwvAcjK/P2T4kD8wFuSPop0Zg0eVb+kRO8rS4bS8xR7dvdrbNT8t
         JFX4dML5iHQY2YqUI3/OBPHkHV5j8aGwDfAtJcSDAZwlrGVt/Ao58ZiD0RZPVi0ZH7zC
         EPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mcik4lcIZ1y28TCf3ymbadTNay8dyte5vodS6dDO4ok=;
        b=m4y6VG4c3+GWcitxO0Asy1h09jkRF/mW13u5A21JWfshMnnb1iBwLu50XeHlUep1pd
         6IJX67oHDPM/OyJhc7B+Yg0yCs4oWqdKpXXEvLaCq4rig3+hmNmJuZMgTGywsV5Hyb5G
         Y/d8r3xWtJBB3D5vI01eaNHayu+GPWXBzszG06VAVm0PWMU809EtXd/uE6/hC1XFxNy+
         s066e9uwX89G1uPeu7Y8Ydhr8hxHtYqU8rLSigu3tfiG0CgZka/495XzX7saEzU2TF9N
         55mam4yFzws31UpbsZJAA7A+gz6SDU0XIP4TH1JzhmVkYJjX3PCTMyUuv6IMrMKejuU4
         gWaQ==
X-Gm-Message-State: APjAAAX56wRP8beJANsrJuJp0Lwh+iIcNCzcZgLn8s8txYoHlVoQzWh1
        Wp4eWVhckMLINmMv/1nhhYQ=
X-Google-Smtp-Source: APXvYqyZ904QPcoOBUhe0xRm/XP6kU2yV2UF+ILg3/x1q6+5G0kFHoEZUqHQLBDUu7FgKOMZh0z4Zw==
X-Received: by 2002:a17:90a:6d64:: with SMTP id z91mr9358101pjj.44.1572545964061;
        Thu, 31 Oct 2019 11:19:24 -0700 (PDT)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id d16sm4713017pfo.75.2019.10.31.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:19:23 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:19:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
Message-ID: <20191031181920.GB70819@generichostname>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Oct 31, 2019 at 11:22:16AM +0100, Johannes Schindelin wrote:
> Hi Peff,
> 
> On Thu, 31 Oct 2019, Jeff King wrote:
> 
> > On Wed, Oct 30, 2019 at 03:43:28PM -0700, Denton Liu wrote:
> >
> > > On Wed, Oct 30, 2019 at 04:28:35PM -0400, Jeff King wrote:
> > > Dscho brought up in the GGG thread[1] that perhaps we want to treat
> > > branch descriptions like notes and have them all under something like
> > > `refs/notes/branches`. This would certainly solve my problem of
> > > having versioned descriptions and it would probably do it in a much more
> > > general way than having a versioned included config.
> > >
> > > Anyone see any potential problems with this approach?
> >
> > I don't think it would be `refs/notes/`, as that is assumed to contain
> > mappings of object ids (and if I understand correctly, this would be a
> > mapping of branch names to data.
> >
> > You could just have "refs/meta/descriptions/foo" pointing to a blob
> > which contains the description of "refs/heads/foo". That makes it easy
> > to edit descriptions, even if you don't like using "git branch
> > --edit-description".
> 
> The only problem with this is that it's not really versioned, as it
> would be hard to go back to previous versions and/or share the history
> via pushing to a remote repository.
> 
> But I guess that a very simple pseudo branch would do it, where
> `refs/meta/<branch-name>` would point to a commit that has a tree
> with a single file in it: `description.txt`.

So how would you envision the workflow for this? Would it be something
like,

	$ git checkout feature-1

	$ git branch --edit-description=ref # instead of =config
	# editor opens up, :wq

	# is it find to have an autogenerated commit message?
	$ git show refs/meta/feature-1
	commit 80dfea1dc4492aaabc80d23fbaffe86da55ee098 (refs/meta/feature-1)
	Author: Denton Liu <liu.denton@gmail.com>
	Date:   42 seconds ago

	    Update ref description

	diff --git a/description.txt b/description.txt
	new file mode 100644
	index 0000000..ed03a4b
	--- /dev/null
	+++ b/description.txt
	@@ -0,0 +1 @@
	+this is a description

I have some open questions about this, though:

* Since we're planning on sharing these descriptions with the outside
  world, how would the ref layout look like? If we're not using the
  refs/remotes namespace will it make fetching and merging notes harder?
  I know that collaborating with notes is a pain so how do we avoid
  making the same mistake?

* On the above point, what if local descriptions are at
  refs/meta/heads/feature-1 while remote descriptions are at
  refs/meta/remotes/*/feature-1?

* What would a merge workflow look like? Would we have wrapper commands
  for it or do users just have to checkout the description branch
  themselves?

Thanks,

Denton

> 
> I now like that idea a lot better than my original notes idea.
> 
> Ciao,
> Dscho

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2497F1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 01:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeHED2q (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 23:28:46 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:42307 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeHED2p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 23:28:45 -0400
Received: by mail-pg1-f179.google.com with SMTP id y4-v6so4579948pgp.9
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 18:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D/HA/bnXiIInZyESgO6qkg4Cd2l7thGTw+adGr1rEmM=;
        b=HplRC5X29nexAC7gZd65LAuPCqUY5sA8ATi6QdXTd0wXL8LDt4rLYR3GlcNLySMLNd
         IN4gEQ498wCi/XC2MKHYlb8XQZ9nYyiCeKKmRRpQslvYca9p9LSUwmrdJ+Db+Elf7h5N
         nAeOI2hqfK0vQnV1i3CAPdCdYMi/u6blq0EsSl3itYe8Ez+LDU+bBmtOsBfHmJgiEPDK
         /1bXwVIjovs9dV4nUCWo7ULMZSRUZEu3IXtH5E07BGG44e8aYAkAvwcxhTOaOZzgyB04
         1EIMDA2SNxJgFciWYS0NTD4/ghrlGvSANZFctee6tCOkhrz9yTLIP81/teNZQx4VyMWj
         vfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/HA/bnXiIInZyESgO6qkg4Cd2l7thGTw+adGr1rEmM=;
        b=TbUM8/cUdfDR+IsmdRbrXlZhZZgAkiYRilWllFH842i5oLWyn8OmOBZC7xKzPpVVSs
         uH/1nr7wfhyyNgdW+vUtiK28+++fvM8oBDMH072au2y+s/XiHfa6CN12gprZCKmnCefm
         NS9nP8Z6H82Te6tVzcBlSlKGC7M3tAyWyJrDnlhp533tjiA5lzNZpRG3WLtTQeX8JCA/
         3aHJr0UB+Zm/ZDnR+oO56sYKStuYQ+pXhFQfp1Yzm2UnuZheMfNYqQz1zeDBCZuM9KLl
         M/2pjX8Ju4PUb4eaCJZvFn7fuIZVv7icy/wW2x/m4ydtQCuO/MKUHcNXZCJBWifTND4f
         UPGQ==
X-Gm-Message-State: AOUpUlEWjiIkVrrDEgjGqjp9+GdIblAYZ/tD1X/q9EFgd5icR6mox/1I
        98bB0t7JEuhDMojlGXIuIXKAaVbk
X-Google-Smtp-Source: AAOMgpc8raPdkFCoClZuoYTueLyvOdOqAMn5HRjwPy8qgFfmX9y+u98pU1K8W3ul4nKYrlxowFFqGA==
X-Received: by 2002:a62:768f:: with SMTP id r137-v6mr1700989pfc.250.1533432364289;
        Sat, 04 Aug 2018 18:26:04 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j5-v6sm11094748pff.139.2018.08.04.18.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 18:26:03 -0700 (PDT)
Date:   Sat, 4 Aug 2018 18:26:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to push using SSH and pull using HTTPS for all repos on
 GitHub?
Message-ID: <20180805012602.GB258270@aiede.svl.corp.google.com>
References: <CAH8yC8mXaNDmLBpDmtVTP+6Yc8_fCz8YCadOL41fOvb2J6j=8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8mXaNDmLBpDmtVTP+6Yc8_fCz8YCadOL41fOvb2J6j=8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeffrey Walton wrote:

> I'm having trouble setting up my ~/.gitconfig to push using SSH and
> pull using HTTPS for all repos on GitHub. The idea is, no passwords on
> pulls and only use the password for push.
>
> I've got the first part of the equation using the following in my
> ~/.gitconfig (the ellipses are user info):
>
>    $ cat ~/.gitconfig
>    ...
>    # Enforce SSH
>    [url "ssh://git@github.com/"]
>        insteadOf = https://github.com/

Does putting pushInsteadOf here work?

Thanks and hope that helps,
Jonathan

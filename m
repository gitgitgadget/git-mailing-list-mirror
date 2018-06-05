Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540281F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeFEUk2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:40:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46389 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeFEUk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:40:26 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so2257626pld.13
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hpDHkSz6EjpifKM8e5e4YDW2g2btF9TrdeKkUnLHlTA=;
        b=tj8WL8MaQ046QZ/2UDWV3fM0kqYfo7bYZHZeFv+37O8czvOV26L+8NwigOvGFA7Uds
         mQH9LtfgFqcFs3XTYsWYO4fPUzexXu6/U8gT4VelTYf2SG1U0SlIfEKyt0vW6LkxkgRq
         iY6iRxQzLM6QwWhky3tP+PxGw2OMRAtqsiXbdY0UuhsM9cC5YnKqnfnqaZstjDgfzGpH
         q1fY1QhBlkVghIC5/6Mkt1j5J2FWUrg/M06A9nxlVkPorXDwWrpIy/CLuNksmjXZ6tgR
         3Wq+u9CPbJBSK8yZ+vpoVOJnzDQbCvwR7YDMU3F2J3Ud1b0PxABJtmKIuX1c8TZTojgy
         JRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hpDHkSz6EjpifKM8e5e4YDW2g2btF9TrdeKkUnLHlTA=;
        b=RZFE9ssFxUaV+Y5892mgU0nVQkX1nAnTiDlbJsGVte+5ey7qZeNoXM1/Nfrx0ucGJb
         2LGWMNRWvxFcMZ0vk3hUIHYFgx1Hsn5htnfQYhcmIptHisUbekTZBdRH3tSlE5OZHJ7/
         cV2vvjtgOjFBBux0Gaq6kW/AkqVv2Y8Y8ZxZtEwW+bar7JjSDFkinHiE1xZk5exS9/m2
         8iBryWN4mujaqCRn+83i3gYAV3MNNb4NEoUl6wxGocU4qul1unPVVCK/gHVve8tXlaWP
         r9/qrOLjdpckUoHQ0rEOa+JvPW1ddh9J2IITn91gqN7gSA+YkK0cubdhyyfqk4MwDJAR
         syjQ==
X-Gm-Message-State: APt69E2PK+2YfFpi58ug4UplwwVz6rccGxq4OsR0hg5ObM2z3vsGtroT
        4z3f58TCwBAXMSKBfFn4/Rpkiwnx+4I=
X-Google-Smtp-Source: ADUXVKLRL+yWdmdzHCXOWhb3aGrrzg7zPhIC/iEqs0JqT53sHH53yAbQB21/qkYF1AWpvw4pO+69Dg==
X-Received: by 2002:a17:902:bd8f:: with SMTP id q15-v6mr144389pls.161.1528231225874;
        Tue, 05 Jun 2018 13:40:25 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id l67-v6sm49813813pfj.66.2018.06.05.13.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:40:24 -0700 (PDT)
Date:   Tue, 5 Jun 2018 13:40:23 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: link to gitsubmodules
Message-ID: <20180605204023.GE158365@google.com>
References: <20180605202449.28810-1-bmwill@google.com>
 <20180605203704.GA9266@aiede.svl.corp.google.com>
 <20180605203953.GB9266@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605203953.GB9266@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
> 
> > --- i/Documentation/config.txt
> > +++ w/Documentation/config.txt
> > @@ -3327,13 +3327,13 @@ submodule.<name>.ignore::
> >  submodule.<name>.active::
> >  	Boolean value indicating if the submodule is of interest to git
> >  	commands.  This config option takes precedence over the
> > -	submodule.active config option. See linkgit:git-submodule[1] for
> > +	submodule.active config option. See linkgit:gitsubmodules[7] for
> >  	details.
> >  
> >  submodule.active::
> >  	A repeated field which contains a pathspec used to match against a
> >  	submodule's path to determine if the submodule is of interest to git
> > -	commands. See linkgit:git-submodule[1] for details.
> > +	commands. See linkgit:gitsubmodule[7] for details.
> 
> Gah, and I can't spell.  This one should have been
> linkgit:gitsubmodules[7].  Updated diff below.  Tested using
> 
> 	make -C Documentation/ git-config.html gitsubmodules.html
> 	w3m Documentation/git-config.html
> 
> Thanks and sorry for the noise,
> Jonathan
> 
> diff --git i/Documentation/config.txt w/Documentation/config.txt
> index 1277731aa4..340eb1f3c4 100644
> --- i/Documentation/config.txt
> +++ w/Documentation/config.txt
> @@ -3327,13 +3327,13 @@ submodule.<name>.ignore::
>  submodule.<name>.active::
>  	Boolean value indicating if the submodule is of interest to git
>  	commands.  This config option takes precedence over the
> -	submodule.active config option. See linkgit:git-submodule[1] for
> +	submodule.active config option. See linkgit:gitsubmodules[7] for
>  	details.
>  
>  submodule.active::
>  	A repeated field which contains a pathspec used to match against a
>  	submodule's path to determine if the submodule is of interest to git
> -	commands. See linkgit:git-submodule[1] for details.
> +	commands. See linkgit:gitsubmodules[7] for details.
>  
>  submodule.recurse::
>  	Specifies if commands recurse into submodules by default. This

Yep this is what I meant.

-- 
Brandon Williams

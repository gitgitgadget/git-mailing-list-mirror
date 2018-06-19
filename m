Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99A21F403
	for <e@80x24.org>; Tue, 19 Jun 2018 01:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937194AbeFSBHV (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 21:07:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33438 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937125AbeFSBHU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 21:07:20 -0400
Received: by mail-pg0-f65.google.com with SMTP id e11-v6so8349649pgq.0
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 18:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJseYP04KWsNphxs9N5JP2gkc63j9nqGdTUdOhzeADc=;
        b=AUu6tRrnYr4CCCjBxZ70H9DNq4TBvHaSSMLybue3TWPsw9cx+oJB8WcnACKGuje6Mt
         6HflmX2Fqbsw0Cs91oyqwXQSQl9oK2OYZL1XIEMB+20iE3vN2H+E2DCYT1KSKK6u4z37
         PBXhnqlJUm3431ZfHPGD3+dDImTsPJxmZ5NIA/3d0RtF+WzQtzB8gdD5rKodPyzNBzMb
         YKAOacQGys+4VNZ0f17pWslr3Bisnm2MwA/MyWZryC+27qgdJih6Qfg4WUJIfoJQnXfg
         4UoXu7gntyrOzfkR8qI54h6nrYt6L1SCCYLtzon9OULy9bWZ2BG4Eg8DHmg3aKt0W7Rq
         96hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJseYP04KWsNphxs9N5JP2gkc63j9nqGdTUdOhzeADc=;
        b=i0T5WZoRuo6+BjrBT7UoWKgZqB+WpCz4otD6/DBMbZqKnTP4y92Ax3pEUSIL0HQAEV
         H5hiSTO6CvQ7xydJmloyM8pKN85+dvEiL/nBZ7VEQquQJ5yV4VNOlMpGKIdoAd2IiWOB
         XDsf8mj5TzMShm33Z1S6iyoE7h26h+pT5qN8BLiBmXidFshaD5p4dwenaFKA+xWyEaGG
         wQent2XWxC9Is8Fg5iyn4E6gEHSwu+pPbueQdH2qRjhsx8dwSxghZ/ETQIH3i9H5Aue1
         paH15k0R3pKwipdC4qyU3QEqfWX40G2gpUZI7hRVjx4EsbO41u6CnByiYiNKMfHEOTvI
         hezw==
X-Gm-Message-State: APt69E2TkFCeM7CAqoTc5eNt4QuB9EyefoP14rIGw8Uzu5dK7k0Sx/3M
        W6al5k22Lv0Q6hwLDDENrW/j9Jnx
X-Google-Smtp-Source: ADUXVKKGwrTHOpO82R9jcnYjnHq9ETjyl10XC+PDkvNHs67pGQhGdDVzP4bzPvCLEIRXZJTTcTkT0Q==
X-Received: by 2002:a65:4b46:: with SMTP id k6-v6mr13071515pgt.113.1529370439480;
        Mon, 18 Jun 2018 18:07:19 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j8-v6sm11202975pfe.84.2018.06.18.18.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 18:07:18 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:06:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     git@vger.kernel.org
Subject: Re: want <reason> option to git-rebase
Message-ID: <20180619010655.GA173168@aiede.svl.corp.google.com>
References: <23335.52730.475955.861241@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23335.52730.475955.861241@chiark.greenend.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ian Jackson wrote[1]:

> git-rebase leaves entries like this in the reflog:
>
>   c15f4d5391 HEAD@{33}: rebase: checkout c15f4d5391ff07a718431aca68a73e672fe8870e
>
> It would be nice if there were an option to control this message.
> Particularly, when another tool invokes git-rebase, the other tool may
> specify an interesting --onto, and there is no way to record any
> information about that --onto commit.
>
> git-rebase already has a -m option, so I suggest
>   --reason=<reason>
>
> It doesn't matter much exactly how the provided string is used.
> Any of the following would be good IMO:
>   <reason>
>   rebase start: <reason>
>
> I think:
>   rebase: checkout c15f4d5391ff07a718431aca68a73e672fe8870e <reason>
> would be rather cumbersome.

From git(1):

 GIT_REFLOG_ACTION
	When a ref is updated, reflog entries are created to keep
	track of the reason why the ref was updated (which is
	typically the name of the high-level command that updated the
	ref), in addition to the old and new values of the ref. A
	scripted Porcelain command can use set_reflog_action helper
	function in git-sh-setup to set its name to this variable when
	it is invoked as the top level command by the end user, to be
	recorded in the body of the reflog.

"git rebase" sets this itself, so it doesn't solve your problem.

Can you say more about what your tool does?  I'm wondering if it would
make sense for it to use lower-level commands where GIT_REFLOG_ACTION
applies, instead of the more user-facing git rebase.

Thanks,
Jonathan

[1] https://bugs.debian.org/901805

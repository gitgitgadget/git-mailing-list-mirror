Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5CDA20248
	for <e@80x24.org>; Mon, 15 Apr 2019 21:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfDOVPX (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 17:15:23 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35464 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfDOVPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 17:15:23 -0400
Received: by mail-wr1-f52.google.com with SMTP id w1so23849942wrp.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u/FUOmX3vF5/PSRNzfyJpYeklqokk63epuz5g+zgTjk=;
        b=qILMrAkWrAXaGo8FMpekHdb4tLYFyWmKY9ava7pAPCdyQdUU3nnptjrh+s5sVF5pIp
         NrRqSbEjWxtR3pRcba6zLvMhgqiibZpMc6K/BqIzsZbNFu9aavm/K1PpdG3t/V9JJa47
         dXmRJ27PUkpJxTb6yxgsAg8ujUQE9UCpSeLHa99VMIRD2b5qY2t6mwyM6QNYK9UrTVDU
         GbUxUnxtKa+HC1O7gblPeWDhZerw5ZWTV5K+1WNewro31PlmTKN8+9NkiI4ESGdVnoAd
         lAHaUhcMkwTHEcl9QItZzOcUrkj3Nyo3v6hCCerps9eu97wcVewriQ6+/sNJxq4pot5o
         qCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u/FUOmX3vF5/PSRNzfyJpYeklqokk63epuz5g+zgTjk=;
        b=tsToKCUIo4mHr2KRdZNeqauNqC5BX34lFIJcR4jTVjbGtxBnSNXviVThl8DOFVHkNE
         KYwN6g4/H2sW59AmIkY26/hkj0tMlnXHd2036m1/weV9JthEfyCzE0MH5Vd0RewKQiIu
         0u0RmGvYS4RJvzOTQtC9FnmCFI4crFY91DIsRaC7MRQAnzNpF2Hx6XAZprIMBkIGY/SF
         s/8FSgGTdlcBrBuIQ4hBed0AzcUCtqBWIUdYl97bOOkSAtblNwtsxF7FOCkdgKF+cPbh
         vyBxg9k2cRHNQKm3wJPKpkF4Iks0BXgllySqMWoGZFval6WjugaIEPUbuCOteEZ/SDlp
         CWJA==
X-Gm-Message-State: APjAAAWvtw2Om087+BsGwPwI39kKhSUzOY8B3B71k+GUw17YbvRE/be9
        2VwHLvWkB+4ldPa2NwC1XZQ=
X-Google-Smtp-Source: APXvYqxfQGJ3w/sfEuEdpUN8pYM8e+ziLF3qZHRl4bJTD046xrUeNg5b4aQhRRB3HI8vjw4LHz4Vbw==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr45617836wrq.133.1555362921543;
        Mon, 15 Apr 2019 14:15:21 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id a187sm24180011wma.32.2019.04.15.14.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 14:15:20 -0700 (PDT)
Date:   Mon, 15 Apr 2019 22:15:19 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian =?iso-8859-1?Q?Gonz=E1lez?= 
        <christian.gonzalez@nerdocs.at>
Cc:     git@vger.kernel.org, Barret Rhoden <brho@google.com>
Subject: Re: feature request: .blameignore
Message-ID: <20190415211519.GG1704@hank.intra.tgummerer.com>
References: <130b0ffd-ed84-59ea-751b-cc59241cab1f@nerdocs.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <130b0ffd-ed84-59ea-751b-cc59241cab1f@nerdocs.at>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/15, Christian González wrote:
> Hello git community,
> 
> I'm completely new here, and maybe my request is dumb, has already a
> better solution, or I did not fully understand git. Please tell my if
> so. I stumbled upon this idea while following the django developers
> mailing list, people there discussing whether nor not to adopt *black*
> (https://github.com/ambv/black, a python code formatting tool) as
> enhancement in the development cycle. One of the main arguments against
> black was that it changes git history by masking git blame. Whenever a
> git commit with only a black formatting change is committed, you can't
> easily see using git blame WHO did actially write a line of code
> *before* that commit. It is possible to look further manually, and they
> said there are tools like git-hyper-blame that circumvent that problem,
> but I always asked myself since I use git, why isn't there a simple
> possibility how I can e.g. fix a whitespace code "error", or do a code
> reformatting WITHOUT taking away the original author's credits for that
> line.
> 
> I know, there are some counter arguments about that:  e.g. whitespace
> changes could lead to programming errors too, even to compiler errors,
> depending on the language, and how the compiler engine treats whitespace.
> 
> I don't suggest git to ignore whitespace (or whatever) changes in the
> blame history automatically.
> 
> What I suggest is: let git accept a file like .blameignore,
> .gitblameignore, .gitblame etc., you name it.
> In my simply suggest, I would see that file as one-hash-per-line that is
> ignored by git blame. And for the sake of convenience, add a git option
> to add that hash automatically:

This sounds roughly like what Barret Rhoden (added to Cc) has been
working on.  I haven't followed that patch series in detail, but you
can have a look at it atthe latest iteration at
https://public-inbox.org/git/20190410162409.117264-1-brho@google.com/.

>     git commit -m "fix whitespace" --blame-ignore
> 
> This would add this commit's hash to the .gitblameignore (or whatever) file:
> 
> 4070ddcdd3d3cc45ec7952e1b37ab374aed9083c # fix whitespace
> 
> and a "git blame any_file.txt" would ignore this one commit and show the
> last commit's author of changed lines.
> 
> Even better would it be to allow chunks to be excluded, because bad
> commit habits of whitespace AND real code changes at the same time are
> not possible to undo later - except there would be a .gitblameignore file.
> 
> It would even be possible to incorporate this into tht .gitignore file,
> with a section, or a certain prefix...
> 
> IMHO, this would allow better per-project maintainance of blame history
> which could be changed later in time and  re-fixed if done wrong - all
> within git history itself.
> 
> I'd love to hear what you think about that.
> 
> Yours,
> 
> Christian
> 
> 
> 
> -- 
> Dr. Christian González
> https://nerdocs.at
> +43 (0) 650 7644477 
> 

[-- Error: unable to create PGP subprocess! --]


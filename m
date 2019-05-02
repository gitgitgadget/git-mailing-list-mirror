Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4625E1F453
	for <e@80x24.org>; Thu,  2 May 2019 00:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfEBA6D (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 20:58:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35508 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfEBA6D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 20:58:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so271163pfh.2
        for <git@vger.kernel.org>; Wed, 01 May 2019 17:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YgPeEN1k0yifonVcqqUaAuTIuc6LFT7awNNZtcp5FhY=;
        b=JW5CmX/PrKzRjzjtRlE3xI9IruOM2h6RzzPexohpFJjqvlIoYwOglXvF2oJAsgmdgf
         kYZWtFFVuv3cRiEJ/GAbeI6tNwkJ7lvE4OD9NBapjflqPBWrvoSiS/peSeUqQohinDaV
         OPqXn5vVMt/rRWl55e3h2wOM/E3PIvK8uDsWyeBsc5vpbDNp7AiqfCLvcBhhBpxhJInj
         X0df1GLAb1TkVGomJ+Tack5zbV6w1tcLx2/juljyxcxv0PCZKQSEVr5HT7YWP9pugolQ
         F30UkOVanSdxgsKVM645ACXmePQSBTGils3Dn2BZFPKQ2hvye53UYMn4N+tPE1CD3nkU
         LTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YgPeEN1k0yifonVcqqUaAuTIuc6LFT7awNNZtcp5FhY=;
        b=kCc3kausEQhr55r+o/3l3dhmbwjJfBO1OFEuAZkx9OvcDGKuBeO908kvai6ViLsEli
         YFDik37Z6BtKoMRmmBgy6cSxLKuDoCrDdIwPFmSGDeZvrU+t7CYymXiDhlRF/+2DM1xz
         ZHHTihxxO2SahL5Sw1qnGIZCYPoTdYWeFVMuQdHm7+9qOUUcltQJUXCr34F5tSeGoZ4Y
         wEKIN51yM/8mI8w47zHxkrkk0rl3ofqG/GjooWuNZxK534qxMaOY4776lxgoebmKUTCJ
         /z0uTc7vzkqA49AyAIVb2rnw7M2lDrkNMmf/iLwsNdXgLYw/eq1Nc1HZJsqcazC7iCET
         tFnQ==
X-Gm-Message-State: APjAAAUTW7Ds63iCojeHAYC1tijgHn7D4y8KSI4JIGpUSgJlBTA0CPQO
        nal3/GvcWpIQvK9uMQ+3e2kk/uf70wEUDQ==
X-Google-Smtp-Source: APXvYqwLkM8EQ1LkMOaDTH+2r/ZQQpjbBPorRrZzw2Z72pN0CLupR5/d//7Dh/ynbhihNwTmSq56DQ==
X-Received: by 2002:aa7:9a99:: with SMTP id w25mr997098pfi.240.1556758682434;
        Wed, 01 May 2019 17:58:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id g63sm59849912pfc.127.2019.05.01.17.58.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 01 May 2019 17:58:01 -0700 (PDT)
Date:   Wed, 1 May 2019 17:57:57 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] documentation: add tutorial for first contribution
Message-ID: <20190502005757.GB99569@google.com>
References: <20190419165709.123502-1-emilyshaffer@google.com>
 <20190423193410.101803-1-emilyshaffer@google.com>
 <20190430185923.GA26779@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430185923.GA26779@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 11:59:23AM -0700, Josh Steadmon wrote:
> Just a couple typo fixes listed below:
> 

Thanks for the review, Josh.

I'll hold these fixes locally until I either get something more
significant to fix or Junio asks for them before a merge to next, to
reduce spam to the list.

- Emily
> 
> On 2019.04.23 12:34, Emily Shaffer wrote:
> [snip]
> > +=== Implementation
> > +
> > +It's probably useful to do at least something besides printing out a string.
> > +Let's start by having a look at everything we get.
> > +
> > +Modify your `cmd_psuh` implementation to dump the args you're passed:
> > +
> > +----
> > +	int i;
> > +
> > +	...
> > +
> > +	printf(Q_("Your args (there is %d):\n",
> > +		  "Your args (there are %d):\n",
> > +		  argc),
> > +	       argc);
> > +	for (i = 0; i < argc; i++) {
> > +		printf("%d: %s\n", i, argv[i]);
> > +	}
> > +	printf(_("Your current working directory:\n<top-level>%s%s\n"),
> > +	       prefix ? "/" : "", prefix ? prefix : "");
> > +
> > +----
> > +
> > +Build and try it. As you may expect, there's pretty much just whatever we give
> > +on the command line, including the name of our command. (If `prefix` is empty
> > +for you, try `cd Documentation/ && ../bin-wrappers/git/ psuh`). That's not so
> 
> Looks like you have an errant "/" after "git".

Right you are. Thanks.
> 
> 
> [snip]
> > +=== Adding documentation
> > +
> > +Awesome! You've got a fantastic new command that you're ready to share with the
> > +community. But hang on just a minute - this isn't very user-friendly. Run the
> > +following:
> > +
> > +----
> > +$ ./bin-wrappers/git help psuh
> > +----
> > +
> > +Your new command is undocumented! Let's fix that.
> > +
> > +Take a look at `Documentation/git-*.txt`. These are the manpages for the
> > +subcommands that Git knows about. You can open these up and take a look to get
> > +acquainted with the format, but then go ahead and make a new file
> > +`Documentation/git-psuh.txt`. Like with most of the documentation in the Git
> > +project, help pages are written with AsciiDoc (see CodingGuidelines, "Writing
> > +Documentation" section). Use the following template to fill out your own
> > +manpage:
> > +
> > +// Surprisingly difficult to embed AsciiDoc source within AsciiDoc.
> > +[listing]
> > +....
> > +git-psuh(1)
> > +===========
> > +
> > +NAME
> > +----
> > +git-psuh - Delight users' typo with a shy horse
> > +
> > +
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git-psuh'
> > +
> > +DESCRIPTION
> > +-----------
> > +...
> > +
> > +OPTIONS[[OPTIONS]]
> > +------------------
> > +...
> > +
> > +OUTPUT
> > +------
> > +...
> > +
> > +
> > +GIT
> > +---
> > +Part of the linkgit:git[1] suite
> > +....
> > +
> > +The most important pieces of this to note are the file header, underlined by =,
> > +the NAME section, and the SYNOPSIS, which would normally contain the grammar if
> > +your command took arguments. Try to use well-established manpage headers so your
> > +documentation is consistent with other Git and UNIX manpages; this makes life
> > +easier for your user, who can skip to the section they know contains the
> > +information they need.
> > +
> > +Now that you've written your manpage, you'll need to build it explicitly. We
> > +convert your AsciiDoc to troff which is man-readable like so:
> > +
> > +----
> > +$ make all doc
> > +$ man Documentation/git-psuh.1
> > +----
> > +
> > +or
> > +
> > +----
> > +$ make -C Documentation/git-psuh.1
> 
> Needs a space after "Documentation/".

Done. Thanks much.

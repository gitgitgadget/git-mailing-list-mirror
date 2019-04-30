Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD531F453
	for <e@80x24.org>; Tue, 30 Apr 2019 18:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfD3S7b (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 14:59:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42707 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfD3S7a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 14:59:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so7159782pln.9
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IIrWZTmm22zSRAEa+6pbv4U23ZihN6gTxIxGTVlxGTA=;
        b=D6/Khxhk4n6Kz30nqBi9YoRhAe/xRDXCPvazktsC16HcWGOM3RbT6wP441/2coot9y
         1gJLl6RoTrYE0LHm45/ER8Q8fInPWlpUAIslxjdP+axIJfCJkXT+l5FcKsQLxZZfauE4
         ZzyBdlHDrm24DacgP+XPz5aLXNSfRmNgJjnwaziJKUh/Tlz4agUJapzZ8y/s0P10L+PF
         JEG4SUUg0EvZhBXhDiAk9UNJ1G73LeWRCKSJVwnmKrzQeD1ewopiHGUR1MUIA8k5FLko
         byg7hzmTZsbGiv6lI75tWrVsihJ4ir4HvbEBzDyMvt/Ki3hs81gsYgYS6r59fmxgA49B
         fAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=IIrWZTmm22zSRAEa+6pbv4U23ZihN6gTxIxGTVlxGTA=;
        b=KW7FVjpKBFTrQwpmpk0c6E3wbHowk4WlWNJnWzWNIQTgM0VIMpuQVSO3kl+rZJNzRb
         N0mw0EBrGQG1daQMeLYA7a29peX+JZRl6w5NYwxgpQMqSQVdixXw40xJumm+z/su1l9T
         ZtSr3MNvxLPTdFBmXoGC3UcYDDoNdCwDR36YxyiufcPyO96TLw14RedzRVhUbDIV0hAH
         Egy05mUl1qtxiNbmlEdxtAE2I2/f/ojzsslYLSGAN/3iMc3aJsm3K7jYqdW3Hzi6uJey
         40ttEwahlU4OrqwKsyoYs279TNeE5W99lqR+/DjNTADi6XYEJu9WS7SoVIIVNtPVEcsJ
         41NA==
X-Gm-Message-State: APjAAAV3Y7ZTiK+glettaHWxrNwq5nPfkKcJ5ReceTt+o+38umfybZ4n
        8AIPBC8vfv3Vg1dYAhZQYcY0r5WsEwgJMQ==
X-Google-Smtp-Source: APXvYqzs03EerNEACtIAuU/LQ1R78V0vMTP31a69BYk6Y70h5cKCU1TiF/Dl/SPZri0Sw/c5QRmaDw==
X-Received: by 2002:a17:902:b68d:: with SMTP id c13mr7991704pls.10.1556650769322;
        Tue, 30 Apr 2019 11:59:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id m9sm3846538pfh.99.2019.04.30.11.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 11:59:28 -0700 (PDT)
Date:   Tue, 30 Apr 2019 11:59:23 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] documentation: add tutorial for first contribution
Message-ID: <20190430185923.GA26779@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20190419165709.123502-1-emilyshaffer@google.com>
 <20190423193410.101803-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423193410.101803-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a couple typo fixes listed below:


On 2019.04.23 12:34, Emily Shaffer wrote:
[snip]
> +=== Implementation
> +
> +It's probably useful to do at least something besides printing out a string.
> +Let's start by having a look at everything we get.
> +
> +Modify your `cmd_psuh` implementation to dump the args you're passed:
> +
> +----
> +	int i;
> +
> +	...
> +
> +	printf(Q_("Your args (there is %d):\n",
> +		  "Your args (there are %d):\n",
> +		  argc),
> +	       argc);
> +	for (i = 0; i < argc; i++) {
> +		printf("%d: %s\n", i, argv[i]);
> +	}
> +	printf(_("Your current working directory:\n<top-level>%s%s\n"),
> +	       prefix ? "/" : "", prefix ? prefix : "");
> +
> +----
> +
> +Build and try it. As you may expect, there's pretty much just whatever we give
> +on the command line, including the name of our command. (If `prefix` is empty
> +for you, try `cd Documentation/ && ../bin-wrappers/git/ psuh`). That's not so

Looks like you have an errant "/" after "git".


[snip]
> +=== Adding documentation
> +
> +Awesome! You've got a fantastic new command that you're ready to share with the
> +community. But hang on just a minute - this isn't very user-friendly. Run the
> +following:
> +
> +----
> +$ ./bin-wrappers/git help psuh
> +----
> +
> +Your new command is undocumented! Let's fix that.
> +
> +Take a look at `Documentation/git-*.txt`. These are the manpages for the
> +subcommands that Git knows about. You can open these up and take a look to get
> +acquainted with the format, but then go ahead and make a new file
> +`Documentation/git-psuh.txt`. Like with most of the documentation in the Git
> +project, help pages are written with AsciiDoc (see CodingGuidelines, "Writing
> +Documentation" section). Use the following template to fill out your own
> +manpage:
> +
> +// Surprisingly difficult to embed AsciiDoc source within AsciiDoc.
> +[listing]
> +....
> +git-psuh(1)
> +===========
> +
> +NAME
> +----
> +git-psuh - Delight users' typo with a shy horse
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git-psuh'
> +
> +DESCRIPTION
> +-----------
> +...
> +
> +OPTIONS[[OPTIONS]]
> +------------------
> +...
> +
> +OUTPUT
> +------
> +...
> +
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> +....
> +
> +The most important pieces of this to note are the file header, underlined by =,
> +the NAME section, and the SYNOPSIS, which would normally contain the grammar if
> +your command took arguments. Try to use well-established manpage headers so your
> +documentation is consistent with other Git and UNIX manpages; this makes life
> +easier for your user, who can skip to the section they know contains the
> +information they need.
> +
> +Now that you've written your manpage, you'll need to build it explicitly. We
> +convert your AsciiDoc to troff which is man-readable like so:
> +
> +----
> +$ make all doc
> +$ man Documentation/git-psuh.1
> +----
> +
> +or
> +
> +----
> +$ make -C Documentation/git-psuh.1

Needs a space after "Documentation/".

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D420C1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 01:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfJZBJA (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 21:09:00 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:35979 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfJZBJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 21:09:00 -0400
Received: by mail-pg1-f170.google.com with SMTP id 23so2712657pgk.3
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 18:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DvoWmM69R04J8jgxB2uocqgbzNqwSp8A1M6WuL/RppQ=;
        b=GK9aFA3v2tWYd+6wGgIMAOOeNNFypRKbU52A32xhTbKG1WS0ESBTrAPpJ6CBy4mE5E
         rEZ4H00Ki/JZyETrrIed0fxL9PWB6Pkcg0kA1g+8xmB0OEPMFq+jCxH3Zp17Ig+ppnmO
         cs0fvU7wKcBsYIY/Ayl45O6lDvH/c2LuJxU+ylKk1EmB58qmwVh6v65JlvdxTGHQoJsC
         XD7AmqHfUc7AtGqYjT76BHG/s/OLoLm6gUzQP28CXmgSoNgjjnwiQPZcCHWQPoZYxrjB
         LbneNxan6DJW0nk6q1vZ2yIbYDQU7Vm282tU+yu4VN6/ljIYkPiiYHk7wdg4r3yz65Us
         K8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DvoWmM69R04J8jgxB2uocqgbzNqwSp8A1M6WuL/RppQ=;
        b=HpxlRDYMnFP3omIqQyxXsRmN1yZDNkb11oZp0uZKriD/Tggol5Ij60q3bC+F2lAyrY
         2H0wxjn83jtF1MOBgy/lAiUlhecVuJmFihSuLxpSqUMXSPT3jrCEoZTHcQ//8U8Ifv29
         vZmSpJ+f/ymuQmu1kbPjRISZEG7wdYtIab68IfpySGpe6vWnkXgT30gykWLHcmoRvNWg
         NKderP9KapQZCSykE3AIEVOTYmHhVK2GAPJCfoUNd0T81z+Cwbm/RlfOyMbrP5gF6Rc6
         NX3ihV+6SHWTkwYsfWV5IbO6xv+KfMoGDCsN3aBDVzrnbw9CVju/a2Nb9hU5gsfnAcVV
         RZ+w==
X-Gm-Message-State: APjAAAXu/HDYaJNI2Bn0QtiSdOU1Nku927NNkUF3zOFkrOWwNEOKBJ36
        sU5nan67vYskZ0zhwMSDkio=
X-Google-Smtp-Source: APXvYqxsPDEsSJqMoASfVS9GRlx6f5CmV97cNasVY2qw7XkQXpAjnYYhVc6NU31xJfQzn6aJgXL9Jw==
X-Received: by 2002:a17:90a:3ac8:: with SMTP id b66mr7911319pjc.9.1572052139618;
        Fri, 25 Oct 2019 18:08:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id t21sm3569346pgi.87.2019.10.25.18.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 18:08:59 -0700 (PDT)
Date:   Fri, 25 Oct 2019 18:08:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] myfirstcontrib: add 'psuh' to command-list.txt
Message-ID: <20191026010857.GA39574@google.com>
References: <20191026005159.98405-1-emilyshaffer@google.com>
 <20191026005159.98405-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026005159.98405-2-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Emily Shaffer wrote:

> Users can discover commands and their brief usage by running 'git help
> git' or 'git help -a'; both of these pages list all available commands
> based on the contents of 'command-list.txt'. That means adding a new
> command there is an important part of the new command process, and
> therefore belongs in the new command tutorial.

Makes sense.

Not about this patch: is there a way to detect this automatically?
E.g. if a command in git.c::commands doesn't appear in
command-list.txt, could we make Git fail "make test"?

[...]
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -534,6 +534,28 @@ you want to pass as a parameter something which would usually be interpreted as
>  a flag.) `parse_options()` will terminate parsing when it reaches `--` and give
>  you the rest of the options afterwards, untouched.
>  
> +Now that you have a usage hint, you can teach Git how to show it in the general
> +command list shown by `git help git` or `git help -a`, which is generated from
> +`command-list.txt`. Find the line for 'git-pull' so you can add your 'git-psuh'
> +line above it in alphabetical order. Now, we can add some attributes about the
> +command which impacts where it shows up in the aforementioned help commands. The

nit: s/impacts/impact/, to agree with "attributes"

> +top of `command-list.txt` shares some information about what each attribute
> +means; in those help pages, the commands are sorted according to these
> +attributes. `git psuh` is user-facing, or porcelain - so we will mark it as
                                             ^^^^^^^^^

optional: This might be an unfamiliar term to people not thinking of the
plumbing fixture / chrome analogy.  Is there anything we should do to
help them understand what's going on?

E.g. "git help glossary" says

	Porcelains expose more of a SCM interface than the plumbing.

> +"mainporcelain". For "mainporcelain" commands, the comments at the top of
> +`command-list.txt` indicate we can also optionally add an attribute from another
> +list; since `git psuh` shows some information about the user's workspace but
> +doesn't modify anything, let's mark it as "info". Make sure to keep your
> +attributes in the same style as the rest of `command-list.txt` using spaces to
> +align and delineate them:
> +
> +----
> +git-prune-packed                        plumbingmanipulators
> +git-psuh                                mainporcelain		info

tabs snuck in.

> +git-pull                                mainporcelain           remote
> +git-push                                mainporcelain           remote
> +----
> +

The rest looks good.

Thanks,
Jonathan

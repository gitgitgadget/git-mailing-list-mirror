Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 113EC1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 08:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfJZIBE (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 04:01:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36960 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJZIBD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 04:01:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so4781732wrv.4
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aqrv7k8K7tmQCvleV1o9bekh3EbjTC/mfhTOmjHi44I=;
        b=i9FPImsqwiLO7cMtZONDZcmoWGinaScUyFBPJ1B9AXFYVeOakgq1JgjBUtPnOkugE0
         GADhLnTdlQTB47zklFeTTjPBTH9zPt251hJq1OvV5fXv7sMLyGe2Opm3nw9KhET3H2c8
         ofILNM+ULSzU7g97WLMd/xK5oeGt0WwgfQ74bWsMbgYheXwuBErcwsNRi1Crk9UvXC0M
         +HJ6is31pxdQfq6W/eAr9YsPau6ao9cJLrhS6oQpvT0MDbnJpuBiK+RHE3eHzEPzVW68
         5O11mH4B52DDbmWcxg0tBGnsiDuNYHDhv/UK0WNxPSkPqHjjg4jAsYxQziHC6mE/g7fS
         XGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aqrv7k8K7tmQCvleV1o9bekh3EbjTC/mfhTOmjHi44I=;
        b=DGdyUAUHc59kifdVabWJavOamh2B1FAaehrvlowNrIWdGkIWVM7ReDs7vpcUv+AcA8
         6jjybj3l4CyJIPvz3YKIAeoMHWnGmqSvU56axchWz4/H9iuQuVgym663/8DEKPSw0jFY
         VwDpW01UsnX4AiWCucz2hPFUOG0qiKNJ5hTjKwke9q5CyrEFYT9iPXjecII2GVlkLIyk
         eTZ4Hko3w8SuxqOmWVtjtua2scwHyDs6Txd1xo0hKuvP0HgG5fgoz+XcdsdG+u+MQHsq
         hG/XpbWCNimXYhfGIUWz8s6OXlTfUlEdTWO/NnMmXLC6ZLQiQVH3CWdQYZOZqGY5T9Dd
         rmnw==
X-Gm-Message-State: APjAAAXbyTyjQarrk9BgTX3FQCS2WVyXsJGnXL6jm3s0T3+A1g5Rqnvo
        GGpMn5a7inJ5LxqkGJR72l0=
X-Google-Smtp-Source: APXvYqzbmHviWGL7ev4ZALwpKWnkj7mhpvr5iB+d96EN4WY9rDvHa4i1cvuMpHVpuTThp3VZEpVSvg==
X-Received: by 2002:a5d:4aca:: with SMTP id y10mr6232698wrs.292.1572076860154;
        Sat, 26 Oct 2019 01:01:00 -0700 (PDT)
Received: from szeder.dev (x4d0c0749.dyn.telefonica.de. [77.12.7.73])
        by smtp.gmail.com with ESMTPSA id v9sm3842050wro.51.2019.10.26.01.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 01:00:59 -0700 (PDT)
Date:   Sat, 26 Oct 2019 10:00:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] myfirstcontrib: add 'psuh' to command-list.txt
Message-ID: <20191026080057.GP4348@szeder.dev>
References: <20191026005159.98405-1-emilyshaffer@google.com>
 <20191026005159.98405-2-emilyshaffer@google.com>
 <20191026010857.GA39574@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191026010857.GA39574@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 25, 2019 at 06:08:57PM -0700, Jonathan Nieder wrote:
> > Users can discover commands and their brief usage by running 'git help
> > git' or 'git help -a'; both of these pages list all available commands
> > based on the contents of 'command-list.txt'. That means adding a new
> > command there is an important part of the new command process, and
> > therefore belongs in the new command tutorial.
> 
> Makes sense.
> 
> Not about this patch: is there a way to detect this automatically?
> E.g. if a command in git.c::commands doesn't appear in
> command-list.txt, could we make Git fail "make test"?

We almost detect this already:

  $ sed -i -e '/^git-bisect/d' command-list.txt 
  $ make check-docs
  make -C Documentation lint-docs
  make[1]: Entering directory '/home/szeder/src/git/Documentation'
      GEN cmd-list.made
      GEN doc.dep
  make[2]: Entering directory '/home/szeder/src/git'
  make[2]: 'GIT-VERSION-FILE' is up to date.
  make[2]: Leaving directory '/home/szeder/src/git'
  make[2]: Entering directory '/home/szeder/src/git'
  make[2]: 'GIT-VERSION-FILE' is up to date.
  make[2]: Leaving directory '/home/szeder/src/git'
      LINT lint-docs
  make[1]: Leaving directory '/home/szeder/src/git/Documentation'
  no link: git-bisect
  $ echo $?
  0

See that last "no link: git-bisect" line?  That's what happened to
catch my eyes when Derrick forgot to add his new 'sparse-checkout'
builtin to 'command-list.txt'.  I still haven't looked up what that
'no link' is supposed to mean, but if it were an error, then we would
have surely detected the missing entry in 'command-list.txt' in out CI
builds.

Another possibility would be to auto-generate that long list of
'cmd_foo()' function declaration in 'builtin.h' from
'command-list.txt', by adding a 'builtin' attribute to mark builtin
commands.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E581F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbeGFVct (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:32:49 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:45335 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932546AbeGFVcr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:32:47 -0400
Received: by mail-io0-f180.google.com with SMTP id l25-v6so12029591ioh.12
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YS/4tHSJDLlBVzeD2Vlnqfn9SvWuSJOcD2MA2t4u9gA=;
        b=qmiKFDVtDhqgVwPa3mgn5YZvu0DpzPufdcWU9OSa7ZFAx4Vbo2KhhkmltT1frQujxk
         0wPJnArvIkAFTGSG+ckOGH80M569hQiUxew5JBR4sG34NppFfdxchE6IxlZvsHWsV8SO
         5AEoFvR8kXPDLbCunwX2tuMIUf9UPuEe2wogsbdy1Ffq8VYZd05Fm8XWzEQywSJi48yT
         /clrlAj0FKJkHsBsJbBP7U4yERG9amBTaLAN4xJNFrHzQMzJEFe90RYow5kP5X9c6xMm
         JbdKRBK2N/1xZPzv8Rpy68aHqgRHqMT37MILDugE3WNvPIwZTg7FNpuKpNO85yK/4xWi
         tH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YS/4tHSJDLlBVzeD2Vlnqfn9SvWuSJOcD2MA2t4u9gA=;
        b=HDfNv1t8Om3LTDSGWaQbOWSNoZ2OoJ2di3D0PiCNokbtpp/0NOpo1p1C3Xr8GLmWJx
         dMXLbkgwC1ZLnVN9EPeCQxw610+ASzFuQQO+YK7xUyYJrtq+IZJOMiS4PyTP5/jwp2/s
         rxIQU6KvKD2bjgKYprvrO6GIKC61P3qjOxmD8y34A/hQQNOSwtU8NY0Hfug3If7NpdN0
         L65HZyy+iixpqenydh31CbkJF5X+YOoUek5eSoAOMx7+EVIc7twy1szk0fqWURa6768a
         YzXSZdo3Nyav/kDWidNKbpNszgijL1eq/b+65lky9DNrKvSAxzJ+7S9fBf5+IoTFVwqB
         5QkQ==
X-Gm-Message-State: APt69E2L2iWaZwvxYUbcUO0T7aHrxh+xYhoAtd0ukqzr6s/txU1ZWz9W
        HehFJmxfmWPMmTKpxHSUN4o=
X-Google-Smtp-Source: AAOMgpeSGu2+xiZnWigur/6GsFGQsDgsEuzYOfjDEwU1v81mF1P51oVvd6FiiP3XXJFZH6zfAGc33Q==
X-Received: by 2002:a6b:bc83:: with SMTP id m125-v6mr10167009iof.80.1530912766135;
        Fri, 06 Jul 2018 14:32:46 -0700 (PDT)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k16-v6sm4509192iog.45.2018.07.06.14.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 14:32:45 -0700 (PDT)
Date:   Fri, 6 Jul 2018 17:32:39 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Frederick Eaton <frederik@ofb.net>, git@vger.kernel.org,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: de-alphabetizing the documentation
Message-ID: <20180706213239.GA867@flurp.local>
References: <20180706200423.GC6343@ofb.net>
 <20180706211600.GB6195@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706211600.GB6195@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 06, 2018 at 02:16:00PM -0700, Jonathan Nieder wrote:
> Frederick Eaton wrote:
> > I wonder if someone familiar with Git could list the commands in an
> > order which makes more sense for learning, for example in the order in
> > which they were invented by Git developers,
> 
> Alas, there are plenty of "Main porcelain commands", and I think that
> is where your question comes from.  It would be nicer to list just five
> to start, say.

"git help" makes some attempt at narrowing the list of porcelain
commands likely to be used on an everyday basis (and it categorizes
the list by general activity). Of the 21 commands listed, I use 14-16
in pretty much every development session, so "git help" might be a
good starting place for someone trying to figure out which commands to
study, or for someone wishing to help focus the documentation a bit
more for beginners.

--- >8 ---
$ git help
usage: git ...

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
--- >8 ---

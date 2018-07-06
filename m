Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE9781F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeGFVQE (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:16:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40571 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeGFVQD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:16:03 -0400
Received: by mail-pl0-f68.google.com with SMTP id t6-v6so3383971plo.7
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oAEdEvRqRolZdHD9deKogl4YCLqmXe2PDYrg//FnEQM=;
        b=DV3UHRUGtyJewnUOYoBsZxA+0JfZFVDZ15AL13W3BrdXKddyeAxlMoHs2t5xgk9XsS
         jTnMdvZ+1+mRCR1aIsOFgLa516f0Ik4UBZlrdTQl1I7xw4mI9kSnb2zN04MVuqft+dBR
         aA3s2Xu2X7FamP2zI0qmvpyTeMy9BC+GN0JtVDzkSJ5NrLeEwAtDRXr+SIHByaAW7q9I
         gojZRDtWQcjQVYPtLUtCg0G2qieN6MsZsgUIGgQrTLnheWdofOsDHBtmz5juhdBUR+Zx
         Vf1+xp/PLm3U2XKnWA4+Yk/EkITA53YyYUq2eYpQdaCMbWFUVdFLVLSD4cTeeB/9g8qr
         hrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oAEdEvRqRolZdHD9deKogl4YCLqmXe2PDYrg//FnEQM=;
        b=Hj/O+x99YAsgR+tFL5BpqpMxxmnaIbeURWU9xkafqDUPHqbHB3zcNyl3A1JusDfsvM
         I6/clgLXxssYENBTt1WtYslwghfgow/gnsibioUNtSbG0TegcAlzgdS9ECswX2LAG3Ya
         fVmxh7E+ULdAIt12NO7r4W4RF7HlNy+ot0FLBG4xy5uTV4ejYZaGu7IqWi0GkNlHhASo
         IToSAnv8cR1NTldFQqvc6P7oWl4ZtqQGfv6hyfda40FcBVsc1llYL12w6uMM72UIgFTU
         6qi5B+0a2GGUc1PZERoh3qS7aBYfc6ndyKMdeAw+2jetIF3PTfBw/WLGEKk3l9kFaPEs
         Tr9A==
X-Gm-Message-State: APt69E1AZT0kkllRS6F99DC/m4pjoLgKdyR4lrLUT0PApah+zX+RrYwt
        /L0kKgxCNfr3JSSlE91evNbQSCia
X-Google-Smtp-Source: AAOMgpd29zWu5HMfYJfr6OjPPQVvRkxot2ckqlftAK2krtGqV2Y1DPDRjmkK14pctGCw0P1E+u/jzw==
X-Received: by 2002:a17:902:64c2:: with SMTP id y2-v6mr11630959pli.53.1530911762866;
        Fri, 06 Jul 2018 14:16:02 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h16-v6sm20335896pfd.71.2018.07.06.14.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:16:02 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:16:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Frederick Eaton <frederik@ofb.net>
Cc:     git@vger.kernel.org, "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: de-alphabetizing the documentation
Message-ID: <20180706211600.GB6195@aiede.svl.corp.google.com>
References: <20180706200423.GC6343@ofb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706200423.GC6343@ofb.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Frederick,

Frederick Eaton wrote:

> I am trying to learn how to use Git but I've been put off by not
> knowing where to start. I would like to start with the 'git' man page,
> but it lists the Git subcommands in alphabetical order, rather than in
> an order which would be useful for learners. For example, I'm not sure
> how often 'git bisect' is used, but it is strange to see it listed
> before 'git init' and 'git clone'.
[...]
> I wonder if someone familiar with Git could list the commands in an
> order which makes more sense for learning, for example in the order in
> which they were invented by Git developers,

That doesn't seem like a useful order pedagogically, but

>                                             or in the reverse order of
> frequency of use by a typical Git user.

That does.

Currently the commands are already broken into a few categories:

  High-level commands
    Main porcelain commands
    Ancillary commands
    Interacting with others
  Low-level commands
    Manipulation commands
    Interrogation commands
    Synching repositories
    Internal helper commands

While it's alphabetical within each section, overall it is not
alphabetical at all!

Alas, there are plenty of "Main porcelain commands", and I think that
is where your question comes from.  It would be nicer to list just five
to start, say.

Some of the most thoughtful documentation that comes with Git is at
https://www.kernel.org/pub/software/scm/git/docs/user-manual.html.
It might be useful for inspiration.

Ideas?  If you start with a proposal, we're happy to help refine it.
People in the #git channel on irc.freenode.net (wechat.freenode.net)
might also be useful for inspiration in coming up with a proposal.

Each of us have our weaknesses for this kind of work: you're telling
me you're too new to have a sense of which commands are the first a
person would need to learn (and I have no reason to doubt you), while
many on this list would have the opposite problem of taking too much
for granted and not being able to put themselves in the mind of a
newcomer.  So we'll have to help each other.

tl/dr: if you come up with a proposed "first commands to learn"
category with some proposed commands to go in it, we'll be happy to
help you with the next steps.

[...]
> Finally, perhaps the same listing and/or reordering could be done for
> other important manual pages, like 'gitglossary'. Presumably
> 'gitglossary' should be sorted topologically, so that each term is
> defined prior to any terms depending on it.

Your help is welcome here as well.  Probably a similar kind of
categorization, with entries ordered either alphabetically or
according to some narrative in each section, would be the easiest to
maintain over time.

Thanks,
Jonathan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074981F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 20:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934200AbeGFUhm (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 16:37:42 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:39194 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932884AbeGFUhl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 16:37:41 -0400
X-Greylist: delayed 1933 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2018 16:37:41 EDT
Received: from [10.13.0.6] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1fbWyt-0001Fo-QR
        for git@vger.kernel.org; Fri, 06 Jul 2018 16:05:27 -0400
Received: from thutmose (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 954533EDF2;
        Fri,  6 Jul 2018 13:05:22 -0700 (PDT)
Received: from frederik by thutmose with local (Exim 4.91)
        (envelope-from <frederik@thutmose>)
        id 1fbWxr-0003hi-QC; Fri, 06 Jul 2018 13:04:23 -0700
Date:   Fri, 6 Jul 2018 13:04:23 -0700
From:   frederik@ofb.net
To:     git@vger.kernel.org
Subject: de-alphabetizing the documentation
Message-ID: <20180706200423.GC6343@ofb.net>
Reply-To: frederik@ofb.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Developers,

I am trying to learn how to use Git but I've been put off by not
knowing where to start. I would like to start with the 'git' man page,
but it lists the Git subcommands in alphabetical order, rather than in
an order which would be useful for learners. For example, I'm not sure
how often 'git bisect' is used, but it is strange to see it listed
before 'git init' and 'git clone'.

I know that 'gittutorial' exists, and I've indeed worked through it
and some other Git tutorials. However, these are more like lists of
examples that should come at the end of a typical manual page. I don't
think they are intended as canonical references for the program
functionality. At some point I would like to use the main 'git' manual
page as my primary source of documentation. This would be easier if it
were designed to be read straight through.

I wonder if someone familiar with Git could list the commands in an
order which makes more sense for learning, for example in the order in
which they were invented by Git developers, or in the reverse order of
frequency of use by a typical Git user. This could easily be derived
from the shell history of someone who is reading this.

    (cat ~/.bash_history; cut -d ";" -f 2 ~/.zsh_history) | grep '^git ' | cut -d ' ' -f 2 | sort | uniq -c | sort -nr

I would like to have this list for personal use, but once it is
created, perhaps someone could also add it to the main Git man page.
The list could be added at the top of the "GIT COMMANDS" section.
Alternatively, and I think preferably, the entries in that section
could be rearranged into this order.

Finally, perhaps the same listing and/or reordering could be done for
other important manual pages, like 'gitglossary'. Presumably
'gitglossary' should be sorted topologically, so that each term is
defined prior to any terms depending on it.

I'm not sure why alphabetical order was decided upon, but it seems
less than useful in the information age, when people can easily search
for text electronically. Maybe at some point someone decided to "clean
up" the presentation by alphabetizing the manual page. As a user who
is more concerned with substance, it is annoying to encounter such an
emphasis on the superficial, which seems unworthy of such an important
piece of software.

Thank you,

Frederick Eaton

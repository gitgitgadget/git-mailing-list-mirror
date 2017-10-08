Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679DB20372
	for <e@80x24.org>; Sun,  8 Oct 2017 08:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdJHImI (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 04:42:08 -0400
Received: from [195.159.176.226] ([195.159.176.226]:56912 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdJHImG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 04:42:06 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1e179o-0003iu-Py
        for git@vger.kernel.org; Sun, 08 Oct 2017 10:41:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
To:     git@vger.kernel.org
From:   Steinar Bang <sb@dod.no>
Subject: Re: is there a truly compelling rationale for .git/info/exclude?
Date:   Sun, 08 Oct 2017 10:41:54 +0200
Organization: Probably a good idea
Message-ID: <86efqe3ub1.fsf@dod.no>
References: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
Mail-Copies-To: never
Cancel-Lock: sha1:iahnGvv6KYbz/dmSfENj67L3hSs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>>> rpjday@crashcourse.ca:

>   but even that isn't a really compelling reason. so what's it for?

I use it to ignore stuff in my git-versioned home directory.

Every time I use a new program and it creates a config file or a config
directory, it shows up as clutter in magit in my git versioned home
directory.

I started with putting the stuff to be ignored in .gitignore, but since
I run different stuff on different machines and on different OSes,
.gitignore started to contain irrelevant stuff (ignoring a stuff from a
program that was run once and then never again, ignoring stuff on one
machine that maybe should not be ignored on a different machine), and
then I figured it was much simpler to just ignore stuff repo-locally in
.git/info/exclude




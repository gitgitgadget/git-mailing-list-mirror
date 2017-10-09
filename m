Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA92720372
	for <e@80x24.org>; Mon,  9 Oct 2017 19:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755063AbdJITr7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 15:47:59 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:58504 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754497AbdJITr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 15:47:59 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C0A474C6AE;
        Mon,  9 Oct 2017 21:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:mime-version:content-type:content-type
        :references:in-reply-to:date:date:from:from:subject:subject
        :message-id:received; s=mail20150812; t=1507578475; bh=OWWpaC+UJ
        7Eovq6y1z7atf6BmY7XFWhyZJtTPi403z8=; b=REtlN2gFhE1hJ918fXEzYRqrH
        kRJoV3o+DpwHj4siTifa498yPZKYS4j1Cop6gA6s6pM79Zj1PS2aEqduSwY6A+du
        9zjpW4dUNMTDjhq+J0FtBZEkZgi0rxzZxzrGil68Ad10p7fwG/or317Um+6UfryA
        hzi3qCGDFnprGrOz6moVeNLesSdB8hWdU8gOlfWcOAazEeL33znTYZzNV7UjxTFV
        ZMyZ8WOuksILR6YcWIDxvLa6XrLSmg5XiZBSJg5SfcRWcjQN6CDaGT81pCvOu+d/
        +92PVbtNWyUs2vhuuTObBV1jeGG8Bo2746ilxAtiu91cA4OIjbf344P2gHcVw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id SBQ1VjZg1Vou; Mon,  9 Oct 2017 21:47:55 +0200 (CEST)
Message-ID: <1507578474.2359.29.camel@mailbox.org>
Subject: Re: Auto adding changed files
From:   Sascha Manns <Sascha.Manns@mailbox.org>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Date:   Mon, 09 Oct 2017 21:47:54 +0200
In-Reply-To: <000201d34136$5e9f1640$1bdd42c0$@nexbridge.com>
References: <1507577714.2359.27.camel@mailbox.org>
         <000201d34136$5e9f1640$1bdd42c0$@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Randall,

Am Montag, den 09.10.2017, 15:39 -0400 schrieb Randall S. Becker:
> -----Original Message-----
> On October 9, 2017 3:35 PM Sascha Manns wrote:
> > if i'm in a git repo and change a file, it is listed in git status.
> > But i have to add this file manually and commit them.
> 
> $ git commit -a
> 
> From the git commit help:  by using the -a switch with the commit
> command to automatically
> "add" changes from all known files (i.e. all files that are already
> listed in the index) and to automatically "rm" files in the index
> that have been removed from the working tree, and then perform the
> actual commit;
Cool. Thank you very much.

Greetings
Sascha


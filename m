X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] git-fetch: do not use "*" for fetching multiple refs
Date: Wed, 06 Dec 2006 10:39:41 -0800
Message-ID: <7vac2050nm.fsf@assigned-by-dhcp.cox.net>
References: <1165261102.20055.9.camel@ibook.zvpunry.de>
	<el1tud$n07$2@sea.gmane.org>
	<1165422865.29714.13.camel@ibook.zvpunry.de>
	<el6sni$re3$1@sea.gmane.org>
	<1165429001.993.35.camel@ibook.zvpunry.de>
	<el71tj$edm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 18:39:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <el71tj$edm$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	06 Dec 2006 19:27:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33505>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs1gI-0002A0-BK for gcvg-git@gmane.org; Wed, 06 Dec
 2006 19:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937085AbWLFSjn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 13:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937086AbWLFSjn
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 13:39:43 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41001 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937085AbWLFSjm (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 13:39:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206183941.LFYL97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Wed, 6 Dec
 2006 13:39:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vWfr1V00c1kojtg0000000; Wed, 06 Dec 2006
 13:39:52 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> 3.) The one with shell-like (fnmatch / glob) globbing
>       Pull: refs/heads/*:refs/remotes/origin/*
>
> By the way, with globbing we really need some other way than
> first Pull: line to select remote head to merge on "git pull".
> For example "Merge:" line / remote.<name>.merge config var.

Why?

        URL: some-where
        Pull: refs/heads/master:refs/remotes/origin/master
        Pull: refs/heads/*:refs/remotes/origin/*

works just fine.

But we should encourage people to use config to define default
merge source per-branch.

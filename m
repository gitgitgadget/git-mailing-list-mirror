X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Git manuals
Date: Sun, 19 Nov 2006 14:36:09 -0500
Message-ID: <20061119193609.GA21866@fieldses.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117153246.GA20065@thunk.org> <20061117182157.GC11882@fieldses.org> <20061119175040.GB15608@fieldses.org> <20061119175952.GX7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 19:36:27 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, linux@horizon.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061119175952.GX7201@pasky.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31857>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlsSh-0005iA-Bi for gcvg-git@gmane.org; Sun, 19 Nov
 2006 20:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933071AbWKSTgP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 14:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933076AbWKSTgP
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 14:36:15 -0500
Received: from mail.fieldses.org ([66.93.2.214]:50665 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S933071AbWKSTgO (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 14:36:14 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GlsSX-0005kG-Av; Sun, 19 Nov 2006
 14:36:09 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On Sun, Nov 19, 2006 at 06:59:52PM +0100, Petr Baudis wrote:
> On Sun, Nov 19, 2006 at 06:50:40PM CET, J. Bruce Fields wrote:
> > In fact, I'm tempted to submit a patch that just assigns a chapter
> > number to everything under Documentation/, slaps a single table of
> > contents on the front, and calls the result "the git user's manual."
> > 
> > Of course, the moment people started trying to read the thing they'd
> > complain that it was a mess--some stuff referenced without being
> > introduced, other stuff introduced too many times.  But then over time
> > maybe that'd force us to mold it into some sort of logical sequence.
> 
> Sequencing isn't the only problem. A _manual_ is different from
> _reference documentation_ in that it does not usually describe command
> after command, but rather concept after concept. So instead of slamming
> git-*-pack commands together, you have a section "Handling Packs" where
> you try to coherently describe the commands together.
> 
> Your approach is fine for something you would call "Git Reference
> Manual", but it is something really different from "The Git Book" or
> "Git User's Manual".

Yeah, of course, but I wasn't actually thinking of the man pages so much
as:
	everyday.txt
	tutorial.txt
	tutorial-2.txt
	core-tutorial.txt
	howto/
	hooks.txt
	README
	glossary.txt

etc.


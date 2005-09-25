From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Sun, 25 Sep 2005 16:42:58 -0600
Message-ID: <87psqwzs3x.fsf@ualberta.net>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
 <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 00:44:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJfDk-0003CB-2q
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 00:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVIYWnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 18:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVIYWnl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 18:43:41 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:50011 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932353AbVIYWnk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 18:43:40 -0400
Received: from pd2mr2so.prod.shaw.ca
 (pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0INE00BWV9RLCE80@l-daemon> for git@vger.kernel.org; Sun,
 25 Sep 2005 16:42:57 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
 by pd2mr2so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0INE000AY9RL39C0@pd2mr2so.prod.shaw.ca> for
 git@vger.kernel.org; Sun, 25 Sep 2005 16:42:57 -0600 (MDT)
Received: from socrates (S0106000fea73ae52.ed.shawcable.net [68.148.44.80])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0INE0075D9RKPL@l-daemon> for git@vger.kernel.org; Sun,
 25 Sep 2005 16:42:57 -0600 (MDT)
Received: from socrates (localhost [127.0.0.1])	by socrates (8.13.4/8.13.4)
 with ESMTP id j8PMgwiM020352; Sun, 25 Sep 2005 16:42:58 -0600
Received: (from cougar@localhost)	by socrates (8.13.4/8.13.4/Submit)
 id j8PMgwCv020351; Sun, 25 Sep 2005 16:42:58 -0600
In-reply-to: <7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Authentication-warning: socrates: cougar set sender to
 tom.prince@ualberta.net using -f
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9292>

Junio C Hamano <junkio@cox.net> writes:

>
> When you already have a repository to track git.git, I would
> recommend to have something like this in .git/remote/origin:
>
>     URL: http://kernel.org/pub/scm/git/git.git
>     Pull: master:origin maint:maint +pu:pu
>

A warning when you do this. If you say 

  git pull origin

then your master will be updated with an octopus merge of the three heads.

  Tom

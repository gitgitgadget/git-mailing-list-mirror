From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC (take 2) Git User's Survey 2007
Date: Mon, 30 Jul 2007 20:32:51 -0400
Message-ID: <20070731003251.GW20052@spearce.org>
References: <200707250358.58637.jnareb@gmail.com> <200707302256.38251.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 02:33:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFffX-0000xg-Ei
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 02:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650AbXGaAc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 20:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756603AbXGaAc4
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 20:32:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37236 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911AbXGaAcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 20:32:55 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IFffH-0006o5-9D; Mon, 30 Jul 2007 20:32:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8167A20FBAE; Mon, 30 Jul 2007 20:32:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707302256.38251.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54296>

Jakub Narebski <jnareb@gmail.com> wrote:
> How you use GIT
> 
>     8. Which porcelains do you use?
>        (zero or more: multiple choice)
>     -  core-git, cogito, StGIT, pg, guilt, egit (Eclipse), other
>     9. Which git GUI do you use
>        (zero or more: multiple choice)
>     -  gitk, git-gui, qgit, gitview, giggle, tig, instaweb,
>        (h)gct, qct, KGit, other

I'll give you git-gui as a GUI here instead of a porcelain.

But I *seriously* object to calling egit a porcelain.  egit is a
complete reimplementation of git in Java.  Calling it a porcelain
is wrong.  Robin, David and myself have put a considerable amount
of effort into keeping egit 100% pure Java, so it is Write Once,
Test Everywhere.

The _only_ code that egit has borrowed from core Git has been the
packfile delta decompressor.  Everything else is a reimplementation.
Just not 100% blackbox, as the egit developers have looked at the
core Git source before.  Heck, we have even been known to contribute
a patch here or there to core Git.  :)

All of the other porcelains that you listed reuse the core Git
plumbing and are thus true porcelain.  But egit doesn't.

-- 
Shawn.

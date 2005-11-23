From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Wed, 23 Nov 2005 14:29:02 +1100
Message-ID: <17283.57854.256145.253465@cargo.ozlabs.ibm.com>
References: <20051117230723.GD26122@nowhere.earth>
	<Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051119140404.GD3393@nowhere.earth>
	<20051119141341.GE3393@nowhere.earth>
	<Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051119170929.GF3393@nowhere.earth>
	<pan.2005.11.19.17.23.17.920228@smurf.noris.de>
	<Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051120073244.GA7902@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 05:35:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EemLk-0007s6-0U
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 05:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVKWEfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 23:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVKWEfK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 23:35:10 -0500
Received: from ozlabs.org ([203.10.76.45]:58059 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932512AbVKWEfJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 23:35:09 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 44E2D687D9; Wed, 23 Nov 2005 15:35:08 +1100 (EST)
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20051120073244.GA7902@kiste.smurf.noris.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12603>

Matthias Urlichs writes:

> If we want (need, these days -- the history is so long that gitk draws
> spurious lines becase of 16-bit window coordinate overflow) to chop off

I have it on good authority that canvas coordinates in Tcl/Tk are
*not* limited to 16 bits.  The Tcl/Tk core developers acknowledged
that there might be a bug in the code that translates canvas
coordinates to X coordinates (which are 16 bit), and asked me for a
screenshot or repro-case to illustrate the problem.

However, I was unable to get current gitk to exhibit the problem, even
with Thomas Gleixner's enormous history.git repository.  Do you have a
specific example (repository and commit ID) where you see the problem
occur?

Paul.

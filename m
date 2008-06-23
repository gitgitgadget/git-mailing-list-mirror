From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: linux-x86-tip: pilot error?
Date: Mon, 23 Jun 2008 12:14:56 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806231208460.19665@iabervon.org>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com> <20080622132105.GD22569@linux.vnet.ibm.com> <20080623071441.GA28887@elte.hu> <20080623095732.GL22569@linux.vnet.ibm.com> <20080623102424.GA28192@elte.hu>
 <20080623111144.GP22569@linux.vnet.ibm.com> <20080623112233.GB7485@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 23 18:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAoiP-0008EN-CB
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 18:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbYFWQO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 12:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755790AbYFWQO6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 12:14:58 -0400
Received: from iabervon.org ([66.92.72.58]:37590 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755740AbYFWQO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 12:14:58 -0400
Received: (qmail 20908 invoked by uid 1000); 23 Jun 2008 16:14:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jun 2008 16:14:56 -0000
In-Reply-To: <20080623112233.GB7485@elte.hu>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85881>

On Mon, 23 Jun 2008, Ingo Molnar wrote:

> tags are mostly meant for release management - our use of tags to save 
> the "merge base" of topic branches in -tip can be considered mild abuse. 
> 
> ( But we did not want to pullute the already crowded branch space with 
>   extra technical branches. -tip has 127 branches at this moment, 89 of 
>   which are topic branches - creating a base branch for each topic would 
>   add another 89 branches and bring it all up to 216 branches. )

If these are only internal details, and not something you expect other 
people to use, you could get yourself a directory for refs that doesn't 
mean anything to the rest of git. If you use "refs/bases/<something>", git 
should (a) accept that as a name you can use for a commit; (b) preserve 
anything referenced by it; (c) copy it in a "git clone --mirror"; and 
pretty much ignore it otherwise.

	-Daniel
*This .sig left intentionally blank*

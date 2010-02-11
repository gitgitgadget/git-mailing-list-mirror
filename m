From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git rebase -i and the reflog
Date: Wed, 10 Feb 2010 22:35:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002102234490.1681@xanadu.home>
References: <fabb9a1e1002101419x40844a42s21108aaa849430c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 04:35:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfPqO-00072f-7D
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 04:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852Ab0BKDfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 22:35:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15937 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0BKDfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 22:35:50 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXN00I90RBPPV70@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 Feb 2010 22:35:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <fabb9a1e1002101419x40844a42s21108aaa849430c1@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139571>

On Wed, 10 Feb 2010, Sverre Rabbelier wrote:

> Heya,
> 
> I use "git rebase -i" a lot, and as a result the output from 'git log
> -g' and 'git reflog' is a tad messy. That is, it's (afaik) not
> possible to check that after my rebasing did not mess things up using
> something like 'git diff HEAD@{1}'. I could of course tag the old head
> or something, but that's not the only problem, due to the clutter it's
> hard to find genuine commits. What I want is a way to see HEAD's
> movement _excluding_ any rebase activity. So if I change history from
> A-o-B-C to A-o-B'-C', I want to see C and C' in the reflog, but not
> B', since B' is often actually identical to B, the only reason that it
> changed is that I did 'git rebase -i' on some far-back commit.
> 
> Is there an existing solution to this?

What about looking at the reflog for the branch you're on instead of 
HEAD?  In the reflog space they're different.


Nicolas

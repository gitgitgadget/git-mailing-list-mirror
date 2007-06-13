From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Wed, 13 Jun 2007 23:31:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706132322210.4059@racer.site>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net> <7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
 <7vveepz8pr.fsf@assigned-by-dhcp.cox.net> <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
 <7vejl0546b.fsf@assigned-by-dhcp.cox.net> <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
 <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net> <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:35:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HybQY-0006gV-Ci
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 00:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbXFMWer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 18:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755383AbXFMWer
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 18:34:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:36447 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755248AbXFMWeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 18:34:46 -0400
Received: (qmail invoked by alias); 13 Jun 2007 22:34:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 14 Jun 2007 00:34:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5cRc6/kL5tQ542R7VDzIkAnHYEqwmrOkUv95Dea
	V1RlRPtM0t3b3U
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50140>

Hi,

On Wed, 13 Jun 2007, Junio C Hamano wrote:

> I would want to start the 1.5.3-rc cycle, after merging
> at least the submodule Porcelain (Lars) and filter-tree
> (Johannes and Pasky).

Isn't that Johannesses (and filter-branch)? :-)

FWIW I think that there lies a long road in front of us with 
filter-branch, after submodule is merged in. I have no preference on what 
should go in first, but filter-branch If My Plan Succeeds (TM) will help 
transition from huge imports to subprojects.

So, even if I am not _that_ interested in subprojects myself, I _do_ want 
to enhance filter-branch. IMHO filter-branch is yet another proof that 
cogito -- even if it is now set to die -- was well worth it. Thanks Pasky.

Next plans are: make filter-branch a misnomer: actually be able to rewrite 
more than one branch in one go, writing the outcome to the refs/rewritten/ 
namespace. IIRC that was Hannes' project, but I'll gladly step in there if 
need be.

After that, I imagine automatic subprojects disentangling (maybe somewhat 
related to Alex' suggestion), so you can say "this big project is actually 
a subproject: directories a/, b/ and c/ are self-contained subprojects).

Of course, the nearest future from my POV is to actually implement the 
missing tests :-)

Ciao,
Dscho

P.S.: Junio, wherever you are right now, have a nice time. Hopefully not 
too stressful.

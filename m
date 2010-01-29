From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 16:51:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 <7veil8iqnj.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
 <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com>
 <alpine.LFD.2.00.1001291628510.1681@xanadu.home>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>, Jacob Helwig <jacob.helwig@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:51:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaykP-0003l5-Lt
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab0A2VvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754838Ab0A2VvT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:51:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53735 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab0A2VvT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:51:19 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX10088V3DIFU10@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 16:51:18 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138377>

On Fri, 29 Jan 2010, Sverre Rabbelier wrote:

> Heya,
> 
> On Fri, Jan 29, 2010 at 22:29, Nicolas Pitre <nico@fluxnic.net> wrote:
> > Then who was arguing about making Git more user friendly rather
> > then less?
> 
> Using a detached head is a more advanced feature than wanting to
> checkout a remote branch locally, creating a local tracking branch. As
> such, 'git checkout origin/topic' now means the same as 'git checkout
> -t origin/topic', and you can get the old behavior back by doing 'git
> checkout origin/topic^0'.

What purpose does this "feature" serve?  Making sure people remain 
stupid and get even more confused when the special dwimery doesn't work 
because they don't know the difference between a local branch and a 
remote tracking branch?

And now people will be left wondering why after a fetch they don't get 
the latest stuff when they do "git checkout topic" again.  Is this any 
better?

> I don't see what the problem is, if you're
> using a detached head you're an advanced enough git user that you can
> remember that you can use '^0' to detach your head.

I don't agree with the assertion that a detached HEAD is for advanced 
users only.

> It's not all that uncommon to do 'git checkout HEAD^0' to detach your 
> head to the current branch, no?

Certainly way more uncommon than 'git checkout origin/foo', and way less 
intuitive.


Nicolas

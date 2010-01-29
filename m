From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 16:20:38 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 <7veil8iqnj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:20:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayGj-0002VL-Dl
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab0A2VUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755626Ab0A2VUk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:20:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16394 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab0A2VUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:20:39 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX100K1J1YEGT10@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 16:20:38 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7veil8iqnj.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138360>

On Fri, 29 Jan 2010, Junio C Hamano wrote:

> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
> >> master^ is a commit (the first parent of master), not a branch (local
> >> or otherwise).
> >
> > Perhaps we should change the message to say "not a branch" if it's not
> > a reference to a remote branch? Or simply changing the text to "not a
> > (local) branch"?
> 
> I think "not a branch" is a good suggestion, whether the target of
> checkout is "master^" or "origin/topic".
> 
> These days, you can say "git checkout topic" to automagically create a
> local "topic" branch that forks from "origin/topic" remote tracking branch
> when you have one, thanks to Dscho's UI improvement ideas (one less
> reason you may end up on a detached HEAD state without wanting to).

If this is the case then I'm really disappointed.

With all due respects, I don't share Dscho's sentiment about Git's 
alleged non user-friendliness.  And I always praised Git's ability to 
use a detached head to check out a remote branch, and never had any 
problem teaching this concept to people.  So the above is not a UI 
improvement at all to me.


Nicolas

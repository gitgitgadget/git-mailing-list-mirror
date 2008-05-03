From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Sat, 3 May 2008 13:45:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805031340550.30431@racer>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness> <7viqy05mhp.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness> <7v63u05khw.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness>
 <7v1w4o3zle.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness> <7vr6cn1yzk.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804301253520.2136@eeepc-johanness> <7vy76tyhfd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 14:46:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsH8I-0001Fu-WB
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 14:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968AbYECMpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 08:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755688AbYECMpo
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 08:45:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:42839 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755242AbYECMpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 08:45:43 -0400
Received: (qmail invoked by alias); 03 May 2008 12:45:41 -0000
Received: from dslb-088-067-214-063.pools.arcor-ip.net (EHLO dslb-088-067-214-063.pools.arcor-ip.net) [88.67.214.63]
  by mail.gmx.net (mp023) with SMTP; 03 May 2008 14:45:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Rb6FFmNyRF1Gq8R4XGQ8FlvdaU3ntyqneesV+F8
	VpO2uRcYvibbB1
X-X-Sender: gene099@racer
In-Reply-To: <7vy76tyhfd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81075>

Hi,

On Thu, 1 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The idea I hinted at was to refer to them by another name than the short 
> > name.  Then we can use the sequencer machinery.
> >
> > I still maintain that it is such a rare need (even if you are a power user 
> > of it) that it makes sense to cater for other, simpler uses.
> 
> As usual, I am greedy and I would want to have both supported in such a
> way that (1) simple things are simple and (2) the language is expressive
> enough that complex things are possible.

Agreed.

> And I try to stress that while we are still in the drawing board phase, 
> because it would be painful to change once we start with a language 
> without enough expressiveness.

Unfortunately, we are no longer in the drawing board phase, because the 
offending code is already in 'next'.

> And that was where my "Can the approach to use the original commit ID to 
> stand for rewritten one express everything we would want to do in the 
> future, not just limited to 'rebase -i -p'" series of questions came 
> from.

I maintain that it can.  Because you can _still_ refer to the original 
commit name quite easily: just take one more letter.

In the meantime I thought about the "<commit name>'" approach (note the 
single apostrophe at the end), though, and it seems that this would not 
be too involved.

But hey, the code is so ugly and complicated by now, that I avert my eyes 
to other tasks.

Ciao,
Dscho

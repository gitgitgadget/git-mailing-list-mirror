From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 19:39:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001291935080.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com>
 <alpine.LFD.2.00.1001291628510.1681@xanadu.home>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
 <7viqakh8ty.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291716070.1681@xanadu.home>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 01:39:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb1NM-0001F8-2p
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 01:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626Ab0A3Ajn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 19:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754863Ab0A3Ajn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 19:39:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47050 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab0A3Ajm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 19:39:42 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX1008NSB65FUD0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Jan 2010 19:39:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7viqakcu56.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138412>

On Fri, 29 Jan 2010, Junio C Hamano wrote:

> How about this?
> 
> -- >8 -- not a patch -- >8 --
> Note: 'master^0' isn't a local branch head;
> 
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by checking out another branch.

s/checking out another branch/performing another checkout/

> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -b with the checkout command again. Example:
> 
>   git checkout -b <new_branch_name>
> 
> HEAD is now at a9d7c95... Merge branch 'maint'
> -- 8< -- not a patch -- 8< --
> 
> Again, everything except for the last line would disappear by setting the
> advice.detachedHEAD configuration to false.

Looks fine to me.


Nicolas

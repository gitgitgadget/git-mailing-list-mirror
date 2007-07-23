From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-apply versus git-am
Date: Mon, 23 Jul 2007 19:37:56 +0200
Message-ID: <20070723173756.GA4626@xp.machine.xx>
References: <a2e879e50707230054m60d45293ua1d57887367914c1@mail.gmail.com> <7vsl7flctg.fsf@assigned-by-dhcp.cox.net> <46A4E368.7080909@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sean Kelley <svk.sweng@gmail.com>, git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 19:38:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID1r6-0003ft-36
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 19:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759410AbXGWRh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 13:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759351AbXGWRh5
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 13:37:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:38464 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756498AbXGWRh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 13:37:56 -0400
Received: (qmail invoked by alias); 23 Jul 2007 17:37:55 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp055) with SMTP; 23 Jul 2007 19:37:55 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+7AtYKLkC7Ns1WnSpM1KqGfBakym7JMseyKYPXuZ
	nOtZvrP5j0PcYc
Mail-Followup-To: Timur Tabi <timur@freescale.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sean Kelley <svk.sweng@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46A4E368.7080909@freescale.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53451>

On Mon, Jul 23, 2007 at 12:20:40PM -0500, Timur Tabi wrote:
> Junio C Hamano wrote:
>
>> applymbox is going away.
>
> That sucks!  I like git-am.  Is there a replacement command that applies a 
> patch and commits it at the same time?  If I use git-apply on a patch that 
> adds new files, I need to use git-add on the files before I can commit it.  
> That's a real pain.

'git am' isn't going away, but as Junio mentioned, 'git applymbox' is.
Those are two *different* programms doing roughly the same, but
'git applymbox' is superceded by 'git am'.

-Peter

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multiple-commit cherry-pick?
Date: Mon, 10 Nov 2008 22:34:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811102234040.30769@pacific.mpi-cbg.de>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org> <20081107071231.GA4063@blimp.localdomain>
 <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org> <20081109102528.GA5463@blimp.localdomain> <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de> <7vabc75n5q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 22:28:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzeJH-0004xf-Nd
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 22:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYKJV1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 16:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbYKJV1V
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 16:27:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:37601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751005AbYKJV1V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 16:27:21 -0500
Received: (qmail invoked by alias); 10 Nov 2008 21:27:18 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 10 Nov 2008 22:27:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+c7V5DDQmcFTPjBHhWe3/VgN286cfgM8UAcesZlL
	p+45RNZx1yuTD4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vabc75n5q.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100577>

Hi,

On Mon, 10 Nov 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> Alex could also change the command to show the HEAD and HEAD~10, by 
> changing the way series of range parameters are evaluated by the 
> revision parsing machinery.  You take HEAD^..HEAD and come up with one 
> set (that has only one commit, HEAD), you take the next parameter 
> HEAD~10 and come up with another set (that also has only one commit, 
> HEAD~10, because show does not walk), then you take union.
> 
> I personally do not want to see that happen, though.  The way multiple
> "ranges" that come from separate command line parameters combine using set
> operator semantics is so useful to do something like...
> 
> 	git log ko/master..master ^maint
> 
> which is my way to ask "Which commits on master are the ones that I
> haven't pushed out?

Exactly one of my use cases, since we do not have ko/master,maint..master.

Ciao,
Dscho

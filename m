From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Tue, 29 Jul 2008 12:45:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807291243260.4631@eeepc-johanness>
References: <20080725055547.GA3699@blimp.local> <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org>
 <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org> <7vbq0ho5g7.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807281817230.3486@nehalem.linux-foundation.org> <7v3alto4r7.fsf@gitster.siamese.dyndns.org>
 <20080729014120.GA26807@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 12:44:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNmhK-0006wr-G7
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 12:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbYG2Kny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 06:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753982AbYG2Kny
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 06:43:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:60852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754729AbYG2Knx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 06:43:53 -0400
Received: (qmail invoked by alias); 29 Jul 2008 10:43:50 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp025) with SMTP; 29 Jul 2008 12:43:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fPZgD/dtfRfQuVGSMpu9884/CVA1FGjiI0T+zMG
	gSB48XBBnyqHvS
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080729014120.GA26807@old.davidb.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90611>

Hi,

On Mon, 28 Jul 2008, David Brown wrote:

> On Mon, Jul 28, 2008 at 06:31:24PM -0700, Junio C Hamano wrote:
>
> > Why does "rename(old, new)" change st_ctime when you move a regular 
> >file?
> 
> But, from the point of view of backup software, not updating the ctime 
> on rename would be horrible, because you'd never know when files got 
> renamed.

Any backup software that does not discover that there is a new _filename_ 
is not worth the label "software".  Rather "daftware" or somesuch.

Ciao,
Dscho

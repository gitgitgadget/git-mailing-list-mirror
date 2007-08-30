From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch: document --original option
Date: Fri, 31 Aug 2007 00:04:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708310004130.28586@racer.site>
References: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
 <1188493842963-git-send-email-giuseppe.bilotta@gmail.com>
 <11884938431525-git-send-email-giuseppe.bilotta@gmail.com>
 <7vy7fs7kmc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 01:05:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQt4c-0005on-AM
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 01:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762400AbXH3XFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 19:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762428AbXH3XFA
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 19:05:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:53862 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762400AbXH3XE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 19:04:59 -0400
Received: (qmail invoked by alias); 30 Aug 2007 23:04:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 31 Aug 2007 01:04:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Rd/lXjAYR//9uiUQOLUEVfe2Y0gzbSMiTSlrxGG
	nsUFn7dleuty3b
X-X-Sender: gene099@racer.site
In-Reply-To: <7vy7fs7kmc.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57087>

Hi,

On Thu, 30 Aug 2007, Junio C Hamano wrote:

> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
> 
> > +--original <namespace>::
> > +	Use this option to set the namespace where the original commits
> > +	will be stored. The default value is 'refs/original'.
> > +
> 
> The default seems to be "refs/original/".
> 
> Even worse.
> 
> I think if you say --force --original refs/head (notice the lack
> of "s" nor slash at the end), the code will get you in a *lot*
> of trouble.
> 
> Dscho, don't we want to do something like this?

Yes, I think so, too.  The --original option is probably the least tested 
option of filter-branch :-(

Ciao,
Dscho

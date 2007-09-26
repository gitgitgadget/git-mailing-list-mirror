From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-commit --amend: respect grafted parents.
Date: Wed, 26 Sep 2007 20:47:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709262039250.28395@racer.site>
References: <11908086961933-git-send-email-johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0709261322150.28395@racer.site> <46FA5604.101@viscovery.net>
 <Pine.LNX.4.64.0709261501190.28395@racer.site> <46FA6CD7.1020709@viscovery.net>
 <7vd4w51csv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:49:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iacsa-0000li-4M
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 21:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757615AbXIZTs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 15:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbXIZTs4
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 15:48:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:38120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756844AbXIZTsz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 15:48:55 -0400
Received: (qmail invoked by alias); 26 Sep 2007 19:48:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 26 Sep 2007 21:48:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2UC41iCu2IPfA9DsR6SAf4yU2VHPl6TYpd2T0wZ
	HshVuQdscISUm+
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4w51csv.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59241>

Hi,

On Wed, 26 Sep 2007, Junio C Hamano wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Johannes Schindelin schrieb:
> >> The reason why I insist on not putting this into --amend is that I 
> >> think this is not really an amend, but actively a rewrite of the 
> >> merge commit.
> >
> > You have a point here. I'm convinced. Scrap the patch.
> 
> I am slow today.  Since when --amend is not about "a rewrite of commit"?

Technically, you are right, of course.  Commit objects are immutable.  But 
from a _porcelain_ view I maintain that "amending" is about changes _to_ a 
commit.  It is not about redefining the (a) parent.

Ciao,
Dscho

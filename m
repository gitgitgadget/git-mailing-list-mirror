From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH,v4] git-checkout(1): mention fate of extraneous files
Date: Tue, 20 Jan 2009 11:07:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201106030.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901200040550.3586@pacific.mpi-cbg.de> <878wp6voar.fsf_-_@jidanni.org> <alpine.DEB.1.00.0901200110410.3586@pacific.mpi-cbg.de> <200901191854.58029.bss@iguanasuicide.net> <7vy6x6odiw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org, jidanni@jidanni.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 11:09:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPDXf-0002nc-Fq
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 11:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbZATKHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 05:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755199AbZATKHn
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 05:07:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:41022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754919AbZATKHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 05:07:42 -0500
Received: (qmail invoked by alias); 20 Jan 2009 10:07:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 20 Jan 2009 11:07:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zobQhO04zSR6hYbRO6/peDLHuLJg30X3IfWk+lH
	W962GHLv/GvLGs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vy6x6odiw.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106462>

Hi,

On Mon, 19 Jan 2009, Junio C Hamano wrote:

> [...] the more I think about it, I do not think it is natural at all to 
> expect "checkout" to behave as if you did "rm -fr" everything and then 
> "tar xf" over the void.  What other SCM implements branch switching that 
> way, and what workflow would such a behaviour help?
> 
> We need to draw a line somewhere to avoid cluttering the documentation 
> too much, and I do not think this is something even a person with CVS 
> braindamage would get confused about, which is where I think is a 
> reasonable place to draw that line.

IIRC both CVS and Subversion allow you to say "$SCM co" with an existing 
working directory, which is then updated (and untracked files are left 
alone, as "$SCM up" always did and should do).

So no, not even people with CVS/SVN braindamage would get confused thusly.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] remote show: fix the -n option
Date: Mon, 9 Jun 2008 18:56:56 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806091856180.1783@racer>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <484D5322.6050309@free.fr> <alpine.DEB.1.00.0806091733230.1783@racer>
 <484D6128.1010800@freesurf.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-221195252-1213034225=:1783"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr@freesurf.fr>
X-From: git-owner@vger.kernel.org Mon Jun 09 19:59:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5leB-00014w-FL
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 19:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbYFIR6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 13:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbYFIR6R
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 13:58:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:42157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752052AbYFIR6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 13:58:16 -0400
Received: (qmail invoked by alias); 09 Jun 2008 17:58:14 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 09 Jun 2008 19:58:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NxOIpDXHN8F8aL2XtWSKl0SieFNu+hh1/5Ap4sR
	Ykd3kHPoRcayXe
X-X-Sender: gene099@racer
In-Reply-To: <484D6128.1010800@freesurf.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84407>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-221195252-1213034225=:1783
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 9 Jun 2008, Olivier Marin wrote:

> Johannes Schindelin a écrit :
> > 
> > And I do not like this change either.  It proliferates the "we just 
> > die() and do not care about reusing the code where die()ing is not 
> > desired" paradigm.
> 
> I agree and I'm OK to try to do something about that. But not in that patch.
> 
> This patch is just to fix a regression.

But did you not now make it harder to fix "that"?  By relying on the die() 
behaviour in your regression fix?

Whatever,
Dscho

--8323329-221195252-1213034225=:1783--

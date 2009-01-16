From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Fri, 16 Jan 2009 02:55:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901160253210.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>  <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>  <87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch>  <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de> 
 <8763khtbfc.fsf@iki.fi>  <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de>  <7vmydstoys.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0901151940170.3586@pacific.mpi-cbg.de> <adf1fd3d0901151610p41930ee2gfc7259aee7e15d73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2123167173-1232070929=:3586"
Cc: Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 02:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNdwS-0003kf-7q
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 02:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbZAPByh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 20:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbZAPByg
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 20:54:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:38117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755683AbZAPByf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 20:54:35 -0500
Received: (qmail invoked by alias); 16 Jan 2009 01:54:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 16 Jan 2009 02:54:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YnOBmTCUY9NKbBHFhqdFPu8NUCBXwMbsYBsoPSH
	g4VutoarwP9oCM
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <adf1fd3d0901151610p41930ee2gfc7259aee7e15d73@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105904>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2123167173-1232070929=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 16 Jan 2009, Santi Béjar wrote:

> If everything works as I think (it's late night :-) with the above two lines:
> 
> matrix[a,b,c]
> matrix{d,b,c}
> 
> the word diff would be
> 
> matrix<RED>[<GREEN>{<RED>a<GREEN>d<RESET>,b,c<RED>]<GREEN>}<RED>

So I guess that you want something like

	[A-Za-z0-9]+|[^A-Za-z0-9 \t]+

Note: I only want to help you finding what you actually want, I am not 
trying to find it for you.

Ciao,
Dscho

--8323328-2123167173-1232070929=:3586--

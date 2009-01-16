From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Fri, 16 Jan 2009 12:57:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901161255520.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>  <87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch>  <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>  <8763khtbfc.fsf@iki.fi>  <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de>
  <7vmydstoys.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0901151940170.3586@pacific.mpi-cbg.de>  <adf1fd3d0901151610p41930ee2gfc7259aee7e15d73@mail.gmail.com>  <alpine.DEB.1.00.0901160253210.3586@pacific.mpi-cbg.de>
 <adf1fd3d0901160102y32a08e26q96728495fc0b6fcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-869287574-1232107074=:3586"
Cc: Junio C Hamano <gitster@pobox.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 12:58:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNnLO-0007gj-W5
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 12:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760064AbZAPL5C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 06:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759577AbZAPL5B
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 06:57:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:59024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758722AbZAPL47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 06:56:59 -0500
Received: (qmail invoked by alias); 16 Jan 2009 11:56:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 16 Jan 2009 12:56:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bvPZMPDibTExotrAhbYZdNRQGAOCJ7smDdsJ+kS
	pP3euujYl9kXzq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <adf1fd3d0901160102y32a08e26q96728495fc0b6fcf@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105943>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-869287574-1232107074=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 16 Jan 2009, Santi Béjar wrote:

>  2009/1/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >
> > On Fri, 16 Jan 2009, Santi Béjar wrote:
> >
> >> If everything works as I think (it's late night :-) with the above 
> >> two lines:
> >>
> >> matrix[a,b,c]
> >> matrix{d,b,c}
> >>
> >> the word diff would be
> >>
> >> matrix<RED>[<GREEN>{<RED>a<GREEN>d<RESET>,b,c<RED>]<GREEN>}<RED>
> >
> > So I guess that you want something like
> >
> >        [A-Za-z0-9]+|[^A-Za-z0-9 \t]+
> >
> 
> So, I see, it is a matter of finding the right regexp.
> 
> But the only use case for me is of this kind, and I think for the
> others too. So maybe an easier way to specify it could be worth.

Sure.  If you can come up with a nice name for it, we could add special 
handling for something like "[[:words:]]" expanding into said regexp.

Ciao,
Dscho

--8323328-869287574-1232107074=:3586--

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Fri, 23 Nov 2007 12:18:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711231132120.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> 
 <8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com> 
 <7v4pfe7g4e.fsf@gitster.siamese.dyndns.org>  <200711231018.49322.jnareb@gmail.com>
  <7vejehux3y.fsf@gitster.siamese.dyndns.org>
 <8aa486160711230213q6038037epe2cbd0240db8b612@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 13:19:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvXVB-0001M4-NC
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 13:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875AbXKWMSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 07:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755852AbXKWMSi
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 07:18:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:53508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755600AbXKWMSh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 07:18:37 -0500
Received: (qmail invoked by alias); 23 Nov 2007 12:18:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 23 Nov 2007 13:18:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8Li5x9lf8wi7HDHCw1bwafJiQIOiu9cMspmKy7a
	Fq5ZTVTArepKah
X-X-Sender: gene099@racer.site
In-Reply-To: <8aa486160711230213q6038037epe2cbd0240db8b612@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65895>

Hi,

On Fri, 23 Nov 2007, Santi B?jar wrote:

> My motivation was to have a similar workflow with bundles as with 
> pushes, or at least as similar as possible. So another possible workflow 
> would be with a:
> 
> git bundle push [<bundle> [<refspec>]]
> 
> that creates a bundle

What about

	git bundle create retort.bundle --all \
		--not $(git ls-remote the-other.bundle | cut -c1-40)

Hmm?

If you need that quite often, it should not be hard at all for you to add 
an option to the "create" named "--haves-from=<bundle>".

But I'd rather script it.

Ciao,
Dscho

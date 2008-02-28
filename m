From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2] clone: support cloning full bundles
Date: Thu, 28 Feb 2008 00:26:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802280024460.22527@racer.site>
References: <1203934349-12125-1-git-send-email-sbejar@gmail.com> <7v63waqasu.fsf@gitster.siamese.dyndns.org> <8aa486160802271504r7744422ag290b1f4d1725210f@mail.gmail.com> <8aa486160802271516h7c2c636dna3a9f067fc51da2@mail.gmail.com>
 <7vpruindag.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1713502588-1204158378=:22527"
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:27:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWcg-0002fM-Ey
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759483AbYB1A0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 19:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759131AbYB1A0u
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:26:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:32834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758035AbYB1A0t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 19:26:49 -0500
Received: (qmail invoked by alias); 28 Feb 2008 00:26:47 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp006) with SMTP; 28 Feb 2008 01:26:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DdmdikiMDMqea+W+Vw2k/egFKHgGwzVRCmSZ8mP
	0opIzLg/CUtUNx
X-X-Sender: gene099@racer.site
In-Reply-To: <7vpruindag.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75330>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1713502588-1204158378=:22527
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 27 Feb 2008, Junio C Hamano wrote:

> "Santi Béjar" <sbejar@gmail.com> writes:
> 
> > My preference are in order:
> >
> > 1) define an official extension + the && [ -f "$repo" ]
> > 2) the && [ -f "$repo"]
> > 3) just remove this line
> 
> Sure.  (1) sounds sane and if you make the extension ".git",
> then I do not think you need anything more ;-).  Jokes aside,
> calling it .bundle or .bndl would be sane.
> 
> Opinions?

I like .bundle, obviously (I used it in every single example I gave).

Ciao,
Dscho

P.S.: only recently, I found out how useful bundles really are.  Thanks, 
Mark, for persisting!

---1463811741-1713502588-1204158378=:22527--

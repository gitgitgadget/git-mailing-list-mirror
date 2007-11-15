From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Thu, 15 Nov 2007 13:44:34 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711151330300.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br>
 <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com>
 <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr>
 <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <87myth58r5.fsf@osv.gnss.ru>
 <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org> <85mytg1f6n.fsf@lola.goethe.zz>
 <473C0875.3020805@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Sergei Organov <osv@javad.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 15 13:45:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ise5X-0006m6-CP
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 13:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826AbXKOMoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 07:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756619AbXKOMoi
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 07:44:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:58672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756556AbXKOMoh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 07:44:37 -0500
Received: (qmail invoked by alias); 15 Nov 2007 12:44:35 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp041) with SMTP; 15 Nov 2007 13:44:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tcqdF7krtnrWBHyNSRXK92b5hHJH2qzqUeZBLUi
	S5IF7sTdS2gHFw
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <473C0875.3020805@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65114>

Hi,

On Thu, 15 Nov 2007, Andreas Ericsson wrote:

> Since empty repositories have HEAD pointing to refs/heads/master by 
> default, you might get away with a simpler implementation.

I recently had somebody asking me "how do I rename master in an empty 
repository?"  It is only logical to think in those terms if you want to 
start your common development on no common basis at all (i.e. the empty 
set).

> > Am I stupid for using git for this sort of thing?  I believe not.  
> > And yet git developers choose to call me stupid because my work flow 
> > does not lend any sense to a common ancestor commit.
> 
> Not stupid, but most likely unusual. Optimizing git for your needs would 
> imho be a bad idea. It's perfectly fine to use a tool for something else 
> than what it was intended for, but then you'll have to live with the 
> fact that it *will* have a few shortcomings and that you'll have to work 
> around them or fix them yourself.

Yes, I agree.  That's what Open Source is: some take their formula one car 
to go shopping.  In some cases, others laugh because that crate of beer 
tied to the front spoiler sure looks funny.  In some of these cases, the 
driver laughs back, because only this car allows her to go shopping for 
dinner in a town across the continent.

Seriously again, there are sure things git was not optimised for.  If 
some complaints involving such (from git's POV) suboptimal workflows are 
retorted by saying so, it is not calling somebody "stupid".  Sheesh.

Ciao,
Dscho

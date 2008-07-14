From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 22:19:03 +0300
Message-ID: <20080714191903.GB5788@mithlond.arda.local>
References: <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer> <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org> <alpine.LFD.1.10.0807141351540.12484@xanadu.home> <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Gerrit Pape <pape@smarden.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITe2-0004ta-12
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbYGNTWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbYGNTWf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:22:35 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:38000 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754487AbYGNTWe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:22:34 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 487B3C2C0003C809; Mon, 14 Jul 2008 22:19:05 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KITZf-0001aB-QW; Mon, 14 Jul 2008 22:19:03 +0300
Content-Disposition: inline
In-Reply-To: <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88451>

Junio C Hamano wrote (2008-07-14 12:00 -0700):

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Mon, 14 Jul 2008, Gerrit Pape wrote:

> >> > On Mon, 14 Jul 2008, Petr Baudis wrote:
> >> > > I'm saying this because I believe the best conservative upper
> >> > > bound for backwards compatibility is Git version in Debian
> >> > > stable. It gets 

> > Please consider it as a critical usability problem.
> >
> > Maybe we can release 1.4.5 with the ability to read index v2?  That
> > wouldn't be hard to backport the reading part of it.

> I am of two minds here.
> 
> On one hand, I am sympathetic to distros that want to give long time
> support for ancient versions to keep working in an ever-changing new
> world.  It is a wonderful thing that there are distros that aim for
> ultra conservative stability, and I applaud them.
> 
> But as the upstream, we have our own deprecation schedule.

As Debian stable (4.0 "Etch") and its git 1.4.4.4 was mentioned I'd like
to point out that git 1.5.6 is available for Etch users from
kind-of-semi-official <www.backports.org>. So I guess Debian stable
users aren't left completely behind. Git's web page already advertises
backports.org version for Etch.

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git filter-branch failed to suppress a file with an
 accentuated letter in the filename
Date: Sat, 16 Feb 2008 12:48:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802161246350.30505@racer.site>
References: <87bq6iw42w.dlv@maison.homelinux.org> <7vd4qygld8.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802151811240.30505@racer.site> <7vwsp5g8to.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802160308550.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 13:49:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQMTT-0008Qm-01
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 13:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbYBPMsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 07:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbYBPMsV
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 07:48:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:33959 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752000AbYBPMsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 07:48:20 -0500
Received: (qmail invoked by alias); 16 Feb 2008 12:48:19 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp024) with SMTP; 16 Feb 2008 13:48:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19U40tnzlpUW1QJV8CKfwEvpAUGUjeyF3BTtKz8g+
	vPMPSsrcWJEdas
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802160308550.30505@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74042>

Hi,

On Sat, 16 Feb 2008, Johannes Schindelin wrote:

> On Fri, 15 Feb 2008, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Having said that, I do not understand why the old code did not work.  
> > > Will have a look later today.
> > 
> > Now you mention it, it certainly is a bit puzzling why the old one did 
> > not work.
> 
> Okay, so I will not manage today.  Tomorrow is another day.

Ah, now I understand.  The accents are shown quoted, but xargs does not 
know how to unquote them.  Cute.

Ciao,
Dscho

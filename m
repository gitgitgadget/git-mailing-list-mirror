From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 5 Apr 2008 02:26:53 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804050221000.4008@racer.site>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <1207340506.10992.28.camel@gaara.boston.redhat.com> <7vzls9xs05.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1922446888-1207355208=:4008"
Cc: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 03:27:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhxC9-0004Xs-BS
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 03:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbYDEB0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 21:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbYDEB0q
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 21:26:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:42285 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751794AbYDEB0o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 21:26:44 -0400
Received: (qmail invoked by alias); 05 Apr 2008 01:26:42 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO racer.home) [86.165.92.90]
  by mail.gmx.net (mp016) with SMTP; 05 Apr 2008 03:26:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187QkkI2TI79volhDXo2e/6uLKhEyyyo3BTJIPR7z
	K77xYaoy484pk4
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzls9xs05.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
Content-ID: <alpine.LSU.1.00.0804050226510.4008@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78830>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1922446888-1207355208=:4008
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LSU.1.00.0804050226511.4008@racer.site>

Hi,

On Fri, 4 Apr 2008, Junio C Hamano wrote:

> Kristian Høgsberg <krh@redhat.com> writes:
> 
> > ... I know I just threw it over the fence, but Daniel picked it up and 
> > got it a lot closer to working?  Did it fall through the cracks or is 
> > it just 1.5.6 material?
> 
> If I recall correctly, "a lot closer to working" happened way after 
> 1.5.5 merge window closed, so it definitely is not 1.5.5 material.
> 
> Judging from the fact that we recently had to deal with the fallouts of 
> C rewrites that happened during the 1.5.4 timeframe, I would have to say 
> that any C rewrite of a substantial and important program needs to be 
> cooked at least for one (or preferably two cycles, especially we are 
> trying to have shorter cycles) in 'next'.

That would mean that you'd have to merge it into 'next'.  And rather 
sooner than later, since everything else would lead to a dragging out of 
the timeline.

As it happens, until you called out the 'please test master' phase, I was 
running with builtin clone, and did not find it lacking.  Although I have 
to admit that I have some cleanups, and I haven't merged with Daniel in a 
long time.  And I do not do anything particularly fancy, such as shallow 
clone or shared clone.

Ciao,
Dscho "who hopes that the please-test-master phase is over soon"
--8323584-1922446888-1207355208=:4008--

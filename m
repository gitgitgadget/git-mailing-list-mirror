From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Thu, 13 Mar 2008 12:11:01 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803131210110.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil> <alpine.LSU.1.00.0803122058430.1656@racer.site> <47D83C53.7000602@nrlssc.navy.mil> <7vejaf65q0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122153440.1656@racer.site>
 <4F997D24-1853-4B53-9865-F456ECA43FD7@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-790266761-1205406664=:1656"
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 12:12:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZlLr-00068B-0d
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 12:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbYCMLK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 07:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbYCMLK7
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 07:10:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:44025 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751794AbYCMLK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 07:10:58 -0400
Received: (qmail invoked by alias); 13 Mar 2008 11:10:56 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp006) with SMTP; 13 Mar 2008 12:10:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/azOF3n3balHygyeU3+k7Up1h3VFY01ILVBro8HE
	RjOq/VKLwTEsQj
X-X-Sender: gene099@racer.site
In-Reply-To: <4F997D24-1853-4B53-9865-F456ECA43FD7@wincent.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77059>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-790266761-1205406664=:1656
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 13 Mar 2008, Wincent Colaiuta wrote:

> El 12/3/2008, a las 21:55, Johannes Schindelin escribió:
> 
> >Alas, git-prune recently learnt the option --expire <minimum-age>, 
> >which makes it a much safer operation.  This allows us to call prune 
> >from git-gc, with a grace period of 2 weeks for the unreferenced loose 
> >objects (this value was determined in a discussion on the git list as a 
> >safe one).
> 
> Just a really minor quibble: I don't think you mean "alas" here; "alas" 
> basically means "unfortunately" or "regrettably".

No, I really meant "alas" here, since it is more of a sigh.  The sigh is 
because I had expected somebody else to care more than me about it, and I 
had done the --expire patch already.

Ciao,
Dscho

--8323584-790266761-1205406664=:1656--

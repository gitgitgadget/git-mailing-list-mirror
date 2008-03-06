From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 6 Mar 2008 19:26:50 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061925370.3941@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>  <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>  <alpine.LSU.1.00.0802281159550.22527@racer.site>  <200803052221.12495.johannes.sixt@telecom.at>  <alpine.LSU.1.00.0803052317350.15786@racer.site>
  <7vir00lski.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0803052327570.15786@racer.site>  <alpine.LSU.1.00.0803060212170.15786@racer.site>  <20080306063331.GA7325@glandium.org>  <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com> 
 <alpine.LSU.1.00.0803061153400.15786@racer.site> <1204827539.10084.9.camel@gaara.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-83239434-1204828010=:3941"
Cc: Reece Dunn <msclrhd@googlemail.com>, Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 19:27:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXKoR-0003B9-E0
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 19:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbYCFS0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 13:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbYCFS0t
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 13:26:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:36491 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751034AbYCFS0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 13:26:48 -0500
Received: (qmail invoked by alias); 06 Mar 2008 18:26:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 06 Mar 2008 19:26:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4isA2/Tq4YkW9AdgKUNrKo3owqyAATKuaUygZfE
	JXHskZwnSjGwrH
X-X-Sender: gene099@racer.site
In-Reply-To: <1204827539.10084.9.camel@gaara.boston.redhat.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76406>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-83239434-1204828010=:3941
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 6 Mar 2008, Kristian Høgsberg wrote:

> On Thu, 2008-03-06 at 11:55 +0100, Johannes Schindelin wrote:
>
> > So your suggestion is out, unless you suggest to implement the whole 
> > printf mechanism... which I hope you're not.
> 
> It's not a terrible idea, honestly.

Heh.  Yeah, I actually posted a start...

> There are several mature vsnprintf implementations out there under 
> friendly licenses.  We could just stick it in compat/.  It's the only 
> way to do reliable, cross platform vsnprintf, in my experience.  And the 
> issue with %I64u vs %llu could be handle by implementing both, as Wayne 
> Davison suggests.

Sure, we could always copy from somewhere else.  My rationale was that I 
had fun writing it, and that we do not really need a full printf() 
implementation.

Ciao,
Dscho

--8323584-83239434-1204828010=:3941--

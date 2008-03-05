From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Wed, 5 Mar 2008 17:37:20 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803051736100.15786@racer.site>
References: <20080304051149.GS8410@spearce.org>  <1b46aba20803041247h5cc64186q2abf7973372fd3ef@mail.gmail.com>  <20080305053612.GA8410@spearce.org>  <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>  <20080305081523.GK8410@spearce.org>
 <7bfdc29a0803050025p45dfcea9q87a1107a8bed46a6@mail.gmail.com> <47CEB44F.9040404@peralex.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Imran M Yousuf <imyousuf@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Noel Grandin <noel@peralex.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 17:38:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWwcz-0000pC-R7
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 17:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYCEQhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 11:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbYCEQhW
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 11:37:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:33538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750921AbYCEQhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 11:37:21 -0500
Received: (qmail invoked by alias); 05 Mar 2008 16:37:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 05 Mar 2008 17:37:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7pCFQatT7hOynHIPUfpVofR7f3NYn6XmdV9I3ej
	gaF21pbgoSUWAi
X-X-Sender: gene099@racer.site
In-Reply-To: <47CEB44F.9040404@peralex.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76240>

Hi,

On Wed, 5 Mar 2008, Noel Grandin wrote:

> Imran M Yousuf wrote:
> > To start with I was actually thinking of JNI + "exec from C". So later
> > when libification is completed we can replace the execs with call to
> > the libs directly instead. Is this a viable fourth option (sorry I
> > forgot to mention it the first time around)?
> >
> >   
> 
> This is probably a good idea. JGIT is always going to be 2 steps behind
> the native GIT code when comes to accessing on-disk structures.

Well, if you go the JNI route, you will always be platform dependent.  IMO 
this is one of the lesser intelligent things to do when relying on Java.

> This is also how the subversion plugin for the Eclipse IDE worked in the 
> beginning and the performance seemed to be acceptable (to me).

Git is much faster than subversion, so you will feel the overhead of 
fork()ing, especially on Windows.

Ciao,
Dscho


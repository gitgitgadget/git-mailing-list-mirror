From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Fwd: [ANNOUNCE] bzr-fastimport plugin, yet another Bazaar import
	option]
Date: Fri, 22 Feb 2008 10:33:57 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802221031550.17164@racer.site>
References: <47BE167A.4060005@internode.on.net>
	<20080222073228.GF8410@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: bazaar-bounces@lists.canonical.com Fri Feb 22 11:35:03 2008
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSVF8-0007D8-In
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 22 Feb 2008 11:35:02 +0100
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1JSVEU-0007Ic-BB; Fri, 22 Feb 2008 10:34:22 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by chlorine.canonical.com with smtp (Exim 4.60)
	(envelope-from <Johannes.Schindelin@gmx.de>) id 1JSVEQ-0007I6-SF
	for bazaar@lists.canonical.com; Fri, 22 Feb 2008 10:34:19 +0000
Received: (qmail invoked by alias); 22 Feb 2008 10:34:18 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO
	racer.home) [86.138.198.40]
	by mail.gmx.net (mp011) with SMTP; 22 Feb 2008 11:34:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+b97MvkcabBzSRQ4SkgKOx2P/BXISyyIa6Up0d80
	6gYWXy3V4tFp/M
X-X-Sender: gene099@racer.site
In-Reply-To: <20080222073228.GF8410@spearce.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-BeenThere: bazaar@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar discussion <bazaar.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar>
List-Post: <mailto:bazaar@lists.canonical.com>
List-Help: <mailto:bazaar-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-bounces@lists.canonical.com
Errors-To: bazaar-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74713>

Hi,

On Fri, 22 Feb 2008, Shawn O. Pearce wrote:

> Ian Clatworthy <ian.clatworthy@internode.on.net> wrote:
>  
> > BTW, you might want to either extend the specification (a little) or 
> > fix git-fast-export so they match. :-) See doc/notes.txt under 
> > http://bazaar.launchpad.net/~bzr/bzr-fastimport/fastimport.dev/files 
> > for details. For example, running git-fast-export on 64-bit Hardy 
> > Heron produces file modes longer than permitted if the spec was 
> > strictly interpreted.
> 
> We may need to take a small hammer to git-fast-export and fix its 
> output.  Generating long mode strings like your notes suggest is 
> incorrect.

Indeed.  Raising the issue with the original author of git-fast-export 
would not have hurt either.

Ciao,
Dscho

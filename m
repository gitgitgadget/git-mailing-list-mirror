From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ambiguous git-log date and timestamp syntax
Date: Sun, 2 Mar 2008 02:44:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803020240390.22527@racer.site>
References: <715587AA-D485-4B31-A786-D26334506007@gmail.com> <m3d4qejroy.fsf@localhost.localdomain> <alpine.LFD.1.00.0803011010480.17889@woody.linux-foundation.org> <200803012326.05698.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 03:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVeD9-0006Jw-K9
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 03:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbYCBCpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 21:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbYCBCpW
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 21:45:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:34741 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751800AbYCBCpV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 21:45:21 -0500
Received: (qmail invoked by alias); 02 Mar 2008 02:45:19 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp035) with SMTP; 02 Mar 2008 03:45:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kXXRh6hZkcUjtEJCFSBY2rkbOH/oUTG8k6Aj2Aa
	lNzmFjhvwCdRPs
X-X-Sender: gene099@racer.site
In-Reply-To: <200803012326.05698.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75716>

Hi,

On Sat, 1 Mar 2008, Jakub Narebski wrote:

> BTW. Git has few other such "reimplementing the wheel" things, like 
> strbuf, or ALLOC_GROW, or it's own parseopt. I guess main reasons are to 
> avoid adding yet another dependency, and that existing solutions doesn't 
> fill all git needs.

Or that the existing wheels are quadratic wheels, and flat.

Just look at our own parse-options.[ch].  It is _still_ smaller and less 
difficult to read than GNU getopt.  Yet, it is also much more powerful and 
easier to use.

Likewise, strbuf compares to Bstring, for example (although you might say 
that Bstring is more powerful, but it comes at a price: it clutters the 
namespace, and is not as performant as strbuf).

ALLOC_GROW() is so small as to not merit any third-party dependency.  

Also, I'd like to caution that depending on 3rd-party libraries is not 
always easy: just think about how much pain we suffer from the 
ever-changing asciidoc package, and the problems wit docbook xsl.

Ciao,
Dscho


From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ambiguous git-log date and timestamp syntax
Date: Sun, 2 Mar 2008 14:40:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803021438010.22527@racer.site>
References: <715587AA-D485-4B31-A786-D26334506007@gmail.com> <200803012326.05698.jnareb@gmail.com> <alpine.LSU.1.00.0803020240390.22527@racer.site> <200803021040.55252.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 15:42:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVpOQ-0002QN-CO
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 15:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbYCBOlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 09:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbYCBOlk
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 09:41:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:34268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751307AbYCBOlj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 09:41:39 -0500
Received: (qmail invoked by alias); 02 Mar 2008 14:41:37 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp058) with SMTP; 02 Mar 2008 15:41:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+eh1FtMF+5kjy8cRprGpXR5JrSknPF9d3IeLMLA
	B9SH1LgZPq3fYW
X-X-Sender: gene099@racer.site
In-Reply-To: <200803021040.55252.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75783>

Hi,

On Sun, 2 Mar 2008, Jakub Narebski wrote:

> I wonder if it would be worthwhile to extract all those useful codelets 
> (mini libraries) like approxidate, strbuf, parseopt, ALLOC_GROW, list 
> utils, etc. into separate micro-projects, to be able to be used by other 
> projects, for *them* not to have to reimplement the wheel.

Actually, something like this happens in git-cheetah ATM, where I would 
like to use parts of libgit.a to call programs.

But then, I see the responsibility of separating out parts of libgit.a by 
those who want to use it, not by the git crowd.

Ciao,
Dscho


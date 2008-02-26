From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix premature call to git_config() causing t1020-subdirectory
 to fail
Date: Tue, 26 Feb 2008 22:40:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802262239200.22527@racer.site>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <200802261640.48770.johan@herland.net> <alpine.LNX.1.00.0802261709180.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 23:42:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU8Uc-0007Nc-CY
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 23:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763173AbYBZWlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 17:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762977AbYBZWlH
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 17:41:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:43601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762979AbYBZWlG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 17:41:06 -0500
Received: (qmail invoked by alias); 26 Feb 2008 22:41:02 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp053) with SMTP; 26 Feb 2008 23:41:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QnUwb9WFQwT50anBMhVOJ64J3k5LQrFfM6TLrkG
	HH+5cNnYuWLv4b
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802261709180.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75184>

Hi,

On Tue, 26 Feb 2008, Daniel Barkalow wrote:

> Actually, I think I'll be leaving CONFIG_ENVIRONMENT alone entirely; I 
> was only using it to override the setting that t5505 uses, but t5505 is 
> just wrong to set it. So this is the right placement of git_config(), 
> and the setenv and unsetenv aren't needed.

Well, existing git-clone.sh sets GIT_CONFIG.  So we have to unset any 
existing GIT_CONFIG at least.

Ciao,
Dscho

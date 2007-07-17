From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 18:13:44 +0200
Message-ID: <20070717161344.GB4815@xp.machine.xx>
References: <469CE836.6010508@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Amit Walambe <awalambe@arcom.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:13:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IApgM-0002mb-JD
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763995AbXGQQNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 12:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763275AbXGQQNi
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:13:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:52784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762014AbXGQQNh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 12:13:37 -0400
Received: (qmail invoked by alias); 17 Jul 2007 16:13:36 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp056) with SMTP; 17 Jul 2007 18:13:36 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18/GBtHT1Y/aGOB1CZkL2qsP/BTUKU1yn5X5lk7DI
	HrAZOSgEMzaYeI
Mail-Followup-To: Amit Walambe <awalambe@arcom.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <469CE836.6010508@arcom.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52768>

On Tue, Jul 17, 2007 at 05:03:02PM +0100, Amit Walambe wrote:
> Hi!
> I was trying to do a git bisect on 2.6.22-git6 and 2.6.22-git8. For which I 
> get following error :
> root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
> Bad rev input: v2.6.22-git6
>
> The repository is obtained by :
> root@amit:/usr/src # git clone 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 linux-git
>
> I am running following git version on Debian Sid, updated today.
> # git --version
> git version 0.99.8.GIT

There is a very old GIT version in your PATH (version 0.99*), which
takes preference over the version from sid.

> '# dpkg -l | grep git' shows ' git-core 1:1.5.2.3-1'
>

-Peter

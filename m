From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: "error: non-monotonic index" during fresh linux-2.6.git cloning.
Date: Sun, 20 Jul 2008 00:06:09 +0400
Message-ID: <20080719200609.GB5093@2ka.mipt.ru>
References: <20080719174742.GA4253@2ka.mipt.ru> <20080719182014.GD32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 19 22:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKIie-0006LS-NX
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 22:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbYGSUGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 16:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbYGSUGu
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 16:06:50 -0400
Received: from relay.2ka.mipt.ru ([194.85.80.65]:38429 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbYGSUGt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 16:06:49 -0400
Received: from 2ka.mipt.ru (localhost [127.0.0.1])
	by 2ka.mipt.ru (8.14.1/8.14.1) with ESMTP id m6JK6CN7009975;
	Sun, 20 Jul 2008 00:06:12 +0400
Received: (from johnpol@localhost)
	by 2ka.mipt.ru (8.14.1/8.12.1/Submit) id m6JK697J009953;
	Sun, 20 Jul 2008 00:06:09 +0400
Content-Disposition: inline
In-Reply-To: <20080719182014.GD32184@machine.or.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89132>

Hi Petr.

On Sat, Jul 19, 2008 at 08:20:14PM +0200, Petr Baudis (pasky@suse.cz) wrote:
> On Sat, Jul 19, 2008 at 09:47:43PM +0400, Evgeniy Polyakov wrote:
> > $ git --version
> > git version 1.4.4.4
> > 
> > Fresh 32bit Debian testing.
> 
> Are you sure?  http://packages.debian.org/testing/git-core says
> 
> 	Package: git-core (1:1.5.6.2-1)
> 
> Your sounds more like the Debian stable version.

It is that version indeed:
apt-cache show git-core
...
 Version: 1:1.5.6.2-1
...

but it was imported there quite recently, so 'apt-get upgrade' will not
catch up with major version change. 1.5 works ok, I pointed to this
issue, so that resolution for the problem (i.e. upgrade to the more
recent version) could be found in archive.

-- 
	Evgeniy Polyakov

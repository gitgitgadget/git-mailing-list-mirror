From: Christopher Li <hg@chrisli.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 14:47:55 -0400
Message-ID: <20050628184755.GA2255@64m.dyndns.org>
References: <andrewkt@aktzero.com> <42C16877.6000909@aktzero.com>
	<200506282154.j5SLsETL010486@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mercurial@selenic.com, Petr Baudis <pasky@ucw.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Tue Jun 28 23:54:25 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnO2A-0004Fz-5j
	for gcvmd-mercurial@gmane.org; Tue, 28 Jun 2005 23:54:22 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SM17gM015955;
	Tue, 28 Jun 2005 17:01:08 -0500
Received: from sccrmhc12.comcast.net (sccrmhc12.comcast.net [204.127.202.56])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SM12tV015937
	for <mercurial@selenic.com>; Tue, 28 Jun 2005 17:01:02 -0500
Received: from localhost.localdomain
	(c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
	by comcast.net (sccrmhc12) with ESMTP
	id <2005062822004501200hd7dae>; Tue, 28 Jun 2005 22:00:56 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 669F73F17F; Tue, 28 Jun 2005 14:47:55 -0400 (EDT)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200506282154.j5SLsETL010486@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com

On Tue, Jun 28, 2005 at 05:54:14PM -0400, Horst von Brand wrote:
> 
> And is exactly the wrong way around. Even RCS stored the _last_ version and
> differences to earlier ones (you'll normally want the last one (or
> something near), and so occasionally having to reconstruct earlier ones by
> going back isn't a big deal; having to build up the current version by
> starting from /dev/null and applying each and every patch that ever touched
> the file each time is expensive given enough history, besides that any

Mercurial store a full text node when it detect the delta gets too long
to reach certain point. So what you describe here will not happen on
mercurial. Having it append only is a very nice feature.

> error in the file is guaranteed to destroy the current version, not
> (hopefully) just making old versions unavailable).  It also means that
> losing old history (what you'll want to do once in a while, e.g. forget
> everything before 2.8) is simple: Chop off at the right point.

You can still chop of the history before the full node, but rebuilding the
repositories. Mercurial save some much space that you would wonder why do you
what to chop the history if you can keep it.

Chris

From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 11:01:57 -0700
Message-ID: <20050628180157.GI12006@waste.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624123819.GD9519@64m.dyndns.org>
	<20050628150027.GB1275@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: mercurial-bounces@selenic.com Tue Jun 28 19:56:29 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnKJf-0003C1-Qp
	for gcvmd-mercurial@gmane.org; Tue, 28 Jun 2005 19:56:12 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SI1x5v015084;
	Tue, 28 Jun 2005 13:02:01 -0500
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SI1vuM015076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 28 Jun 2005 13:01:57 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j5SI1vbV015073;
	Tue, 28 Jun 2005 13:01:57 -0500
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050628150027.GB1275@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
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

On Tue, Jun 28, 2005 at 05:00:27PM +0200, Petr Baudis wrote:
> > Mercurial's undo is taking a snapshot of all the changed file's repo file length
> > at every commit or pull.  It just truncate the file to original size and undo 
> > is done.
> 
> "Trunactes"? That sounds very wrong... you mean replace with old
> version? Anyway, what if the file has same length? It just doesn't make
> much sense to me.

Everything in Mercurial is an append-only log. A transaction journal
records the original length of each log so that it can be restored on
failure.

-- 
Mathematics is the supreme nostalgia of our time.

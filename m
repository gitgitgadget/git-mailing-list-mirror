From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 17:35:45 +0200
Message-ID: <20050628153545.GF1275@pasky.ji.cz>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624123819.GD9519@64m.dyndns.org>
	<20050628150027.GB1275@pasky.ji.cz> <42C16877.6000909@aktzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>, mercurial@selenic.com,
        Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Tue Jun 28 17:29:59 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnI1Q-0003ro-Uq
	for gcvmd-mercurial@gmane.org; Tue, 28 Jun 2005 17:29:13 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SFZocE028357;
	Tue, 28 Jun 2005 10:35:50 -0500
Received: from machine.sinus.cz (qmailr@w241.dkm.cz [62.24.88.241])
	by waste.org (8.13.4/8.13.4/Debian-3) with SMTP id j5SFZkv2028344
	for <mercurial@selenic.com>; Tue, 28 Jun 2005 10:35:47 -0500
Received: (qmail 6067 invoked by uid 2001); 28 Jun 2005 15:35:45 -0000
To: Andrew Thompson <andrewkt@aktzero.com>
Content-Disposition: inline
In-Reply-To: <42C16877.6000909@aktzero.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
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

Dear diary, on Tue, Jun 28, 2005 at 05:10:47PM CEST, I got a letter
where Andrew Thompson <andrewkt@aktzero.com> told me that...
> Petr Baudis wrote:
> >>Mercurial's undo is taking a snapshot of all the changed file's repo file 
> >>length
> >>at every commit or pull.  It just truncate the file to original size and 
> >>undo is done.
> >
> >"Trunactes"? That sounds very wrong... you mean replace with old
> >version? Anyway, what if the file has same length? It just doesn't make
> >much sense to me.
> 
> I believe this works because the files stored in a binary format that 
> appends new changesets onto the end. Thus, truncating the new stuff from 
> the end effectively removes the commit.

Yes, I'm sorry - I missed the "repo" part and thought that was what it
was doing with the checked out files. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..

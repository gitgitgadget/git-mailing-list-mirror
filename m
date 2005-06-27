From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Mon, 27 Jun 2005 12:40:31 -0700
Message-ID: <20050627194031.GK12006@waste.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050627183118.GB1415@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: mercurial-bounces@selenic.com Mon Jun 27 21:34:29 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmzMX-0000Ho-AO
	for gcvmd-mercurial@gmane.org; Mon, 27 Jun 2005 21:33:45 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5RJeXa7012346;
	Mon, 27 Jun 2005 14:40:33 -0500
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5RJeVCl012341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 27 Jun 2005 14:40:31 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j5RJeVXG012338;
	Mon, 27 Jun 2005 14:40:31 -0500
To: Pavel Machek <pavel@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050627183118.GB1415@elf.ucw.cz>
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

On Mon, Jun 27, 2005 at 08:31:18PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Things in git-land are moving at lightning speed, and usability has 
> > > improved a lot since my post a month ago:  http://lkml.org/lkml/2005/5/26/11
> > 
> > And here's a quick comparison with the current state of Mercurial..
> > 
> > > 1) installing git
> > > 
> > > git requires bootstrapping, since you must have git installed in order 
> > > to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
> > > have put together a bootstrap tarball of today's git repository.
> > > 
> > > Download tarball from:
> > > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
> > > 
> > > tarball build-deps:  zlib, libcurl, libcrypto (openssl)
> > > 
> > > install tarball:  unpack && make && sudo make prefix=/usr/local install
> > > 
> > > jgarzik helper scripts, not in official git distribution:
> > > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-new-branch
> > > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script
> > > 
> > > After reading the rest of this document, come back and update your copy 
> > > of git to the latest:
> > > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
> > 
> > Download from: http://selenic.com/mercurial/mercurial-snapshot.tar.gz
> > Build-deps: Python 2.3
> > Install: unpack && python setup.py install [--home=/usr/local]
> 
> Did that... (had to install python2.3-dev, first), but got...
> Traceback (most recent call last):
>   File "/usr/local/bin/hg", line 11, in ?
>     from mercurial import commands
> ImportError: No module named mercurial

>From the README:

 To install system-wide:

 $ python setup.py install   # change python to python2.3 if 2.2 is default

 To install in your home directory (~/bin and ~/lib, actually), run:

 $ python2.3 setup.py install --home=~
 $ export PYTHONPATH=${HOME}/lib/python  # add this to your .bashrc
 $ export PATH=${HOME}/bin:$PATH         # 

 And finally:

 $ hg                                    # test installation, show help

 If you get complaints about missing modules, you probably haven't set
 PYTHONPATH correctly.

-- 
Mathematics is the supreme nostalgia of our time.

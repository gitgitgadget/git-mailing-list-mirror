From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Mon, 27 Jun 2005 20:31:18 +0200
Message-ID: <20050627183118.GB1415@elf.ucw.cz>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Mon Jun 27 20:25:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmyHj-0001zZ-9G
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 20:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVF0Sbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 14:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVF0Sbj
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 14:31:39 -0400
Received: from station-6.events.itd.umich.edu ([141.211.252.135]:18155 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261552AbVF0SbY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 14:31:24 -0400
Received: by amd.ucw.cz (Postfix, from userid 8)
	id BF4B52BDFF; Mon, 27 Jun 2005 20:31:18 +0200 (CEST)
To: Matt Mackall <mpm@selenic.com>
Content-Disposition: inline
In-Reply-To: <20050623235634.GC14426@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi!

> > Things in git-land are moving at lightning speed, and usability has 
> > improved a lot since my post a month ago:  http://lkml.org/lkml/2005/5/26/11
> 
> And here's a quick comparison with the current state of Mercurial..
> 
> > 1) installing git
> > 
> > git requires bootstrapping, since you must have git installed in order 
> > to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
> > have put together a bootstrap tarball of today's git repository.
> > 
> > Download tarball from:
> > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
> > 
> > tarball build-deps:  zlib, libcurl, libcrypto (openssl)
> > 
> > install tarball:  unpack && make && sudo make prefix=/usr/local install
> > 
> > jgarzik helper scripts, not in official git distribution:
> > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-new-branch
> > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script
> > 
> > After reading the rest of this document, come back and update your copy 
> > of git to the latest:
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
> 
> Download from: http://selenic.com/mercurial/mercurial-snapshot.tar.gz
> Build-deps: Python 2.3
> Install: unpack && python setup.py install [--home=/usr/local]

Did that... (had to install python2.3-dev, first), but got...

> $ mkdir linux-2.6
> $ cd linux-2.6
> $ hg init http://www.kernel.org/hg/    # obviously you can also browse this
> 
> This downloads about 125M of data, which include the whole kernel history
> back to 2.4.0 and everything in Linus' git repo as well.

byte-compiling /usr/local/lib/python/mercurial/fancyopts.py to
fancyopts.pyc
byte-compiling /usr/local/lib/python/mercurial/hg.py to hg.pyc
byte-compiling /usr/local/lib/python/mercurial/hgweb.py to hgweb.pyc
byte-compiling /usr/local/lib/python/mercurial/httprangereader.py to
httprangereader.pyc
byte-compiling /usr/local/lib/python/mercurial/lock.py to lock.pyc
byte-compiling /usr/local/lib/python/mercurial/mdiff.py to mdiff.pyc
byte-compiling /usr/local/lib/python/mercurial/revlog.py to revlog.pyc
byte-compiling /usr/local/lib/python/mercurial/transaction.py to
transaction.pyc
byte-compiling /usr/local/lib/python/mercurial/ui.py to ui.pyc
byte-compiling /usr/local/lib/python/mercurial/util.py to util.pyc
byte-compiling /usr/local/lib/python/mercurial/version.py to
version.pyc
running install_scripts
copying build/scripts-2.3/hg -> /usr/local/bin
copying build/scripts-2.3/hgmerge -> /usr/local/bin
changing mode of /usr/local/bin/hg to 755
changing mode of /usr/local/bin/hgmerge to 755
running install_data
creating /usr/local/lib/python/mercurial/templates
copying templates/map -> /usr/local/lib/python/mercurial/templates
copying templates/map-raw -> /usr/local/lib/python/mercurial/templates
copying templates/changelog.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/changelogentry.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/changeset-raw.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/changeset.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/fileannotate.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/filediff-raw.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/filediff.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/filelog.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/filelogentry.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/filerevision-raw.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/filerevision.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/footer.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/header-raw.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/header.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/manifest.tmpl ->
/usr/local/lib/python/mercurial/templates
copying templates/tags.tmpl ->
/usr/local/lib/python/mercurial/templates
root@Elf:/data/tmp/hg/mercurial-snapshot# Use "exit" to leave the
shell.
root@Elf:/data/tmp/hg/mercurial-snapshot# exit
pavel@Elf:/data/tmp/hg/mercurial-snapshot$ cd ../..
pavel@Elf:/data/tmp$ mkdir linux-hg
pavel@Elf:/data/tmp$ cd linux-hg/
pavel@Elf:/data/tmp/linux-hg$ hg init http://www.kernel.org/hg/
Traceback (most recent call last):
  File "/usr/local/bin/hg", line 11, in ?
    from mercurial import commands
ImportError: No module named mercurial
pavel@Elf:/data/tmp/linux-hg$
							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.

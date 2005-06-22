From: Dave Jones <davej@redhat.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 18:40:03 -0400
Message-ID: <20050622224003.GA21298@redhat.com>
References: <42B9E536.60704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 00:39:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlDsF-0006Y1-Eo
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 00:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVFVWoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 18:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVFVWoI
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 18:44:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262464AbVFVWkl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 18:40:41 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j5MMe8ib020340;
	Wed, 22 Jun 2005 18:40:08 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j5MMe3u19938;
	Wed, 22 Jun 2005 18:40:03 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j5MMe3re028415;
	Wed, 22 Jun 2005 18:40:03 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j5MMe3Nt028413;
	Wed, 22 Jun 2005 18:40:03 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: Jeff Garzik <jgarzik@pobox.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <42B9E536.60704@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
 > 
 > Things in git-land are moving at lightning speed, and usability has 
 > improved a lot since my post a month ago:  http://lkml.org/lkml/2005/5/26/11
 > 
 > 
 > 
 > 1) installing git
 > 
 > git requires bootstrapping, since you must have git installed in order 
 > to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
 > have put together a bootstrap tarball of today's git repository.
 > 
 > Download tarball from:
 > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2

<blatant self-promotion>
daily snapshots (refreshed once an hour) are available at:
http://www.codemonkey.org.uk/projects/git-snapshots/git/
</blatant self-promotion>

 > tarball build-deps:  zlib, libcurl, libcrypto (openssl)
 > 
 > install tarball:  unpack && make && sudo make prefix=/usr/local install

the sudo thing isn't necessary. make install by itself installs it
in ~/bin/ just fine.

 > After reading the rest of this document, come back and update your copy 
 > of git to the latest:
 > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git

See above, which allows you to skip this step ;)

		Dave


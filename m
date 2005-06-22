From: Dave Jones <davej@redhat.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 18:52:55 -0400
Message-ID: <20050622225255.GB21298@redhat.com>
References: <42B9E536.60704@pobox.com> <20050622224003.GA21298@redhat.com> <42B9EA67.1040407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 00:57:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlE9F-00020I-EB
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 00:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVFVXCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 19:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVFVW4w
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 18:56:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46024 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262557AbVFVWxB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 18:53:01 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j5MMr0ul022962;
	Wed, 22 Jun 2005 18:53:00 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j5MMqtu22559;
	Wed, 22 Jun 2005 18:52:55 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j5MMqt44002944;
	Wed, 22 Jun 2005 18:52:55 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j5MMqt2E002942;
	Wed, 22 Jun 2005 18:52:55 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: Jeff Garzik <jgarzik@pobox.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <42B9EA67.1040407@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2005 at 06:47:03PM -0400, Jeff Garzik wrote:

 > > > install tarball:  unpack && make && sudo make prefix=/usr/local install
 > >
 > >the sudo thing isn't necessary. make install by itself installs it
 > >in ~/bin/ just fine.
 > 
 > Clearly this does not work if installing in /usr/local, as I and others 
 > do (and as the example shows).

Sure, it just seemed to imply that it doesn't work with a non-root install,
which isn't true.

 > > > After reading the rest of this document, come back and update your copy 
 > > > of git to the latest:
 > > > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
 > >
 > >See above, which allows you to skip this step ;)
 > 
 > huh?  Nothing allows you to skip that step.  Regardless of when you suck 
 > the tarball, even from your snapshots, the users should not skip this step.

At worse, users will have tools 59 minutes old.  If a situation arises
where git from an hour ago isn't new enough to pull from the repository,
we have bigger problems.

You seem to be proposing that everyone needs the shiniest newest things,
which clearly isn't true, and suggesting so just complicates things
further imo.

		Dave


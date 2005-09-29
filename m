From: Dave Jones <davej@redhat.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 16:11:27 -0400
Message-ID: <20050929201127.GB31516@redhat.com>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com> <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932191AbVI2ULp@vger.kernel.org Thu Sep 29 22:12:26 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932191AbVI2ULp@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL4lN-0006Na-DG
	for glk-linux-kernel-3@gmane.org; Thu, 29 Sep 2005 22:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVI2ULp (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Sep 2005 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVI2ULp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:11:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33233 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932191AbVI2ULn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:11:43 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j8TKBTdk005036;
	Thu, 29 Sep 2005 16:11:29 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j8TKBTV05502;
	Thu, 29 Sep 2005 16:11:29 -0400
Received: from nwo.kernelslacker.org (vpn-4-5.stuttgart.redhat.com [10.32.4.5])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j8TKBSS8000429;
	Thu, 29 Sep 2005 16:11:29 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id j8TKBRpM003231;
	Thu, 29 Sep 2005 16:11:27 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id j8TKBR6o003230;
	Thu, 29 Sep 2005 16:11:27 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Anton Altaparmakov <aia21@cam.ac.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9503>

On Thu, Sep 29, 2005 at 09:07:29PM +0100, Anton Altaparmakov wrote:

 > > $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
 > > $ cd linux-2.6
 > > $ rsync -a --verbose --stats --progress \
 > >   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
 > >   .git/
 > > 
 > > Could be just..
 > > 
 > > $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
 > > $ cd linux-2.6
 > > $ git pull
 > 
 > That is not actually the same.  "git pull" for example will not download 
 > Linus' tags whilst the rsync would get everything.

Ah. I didn't know this. Thanks.
Hmm, it'd be nice to have a shorthand 'not have to type the url, pull everything'.
Something like 'git pull all'.

		Dave

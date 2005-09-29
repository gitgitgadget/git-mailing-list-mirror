From: Dave Jones <davej@redhat.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 17:40:43 -0400
Message-ID: <20050929214043.GE31516@redhat.com>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com> <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk> <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org> <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org> <Pine.LNX.4.64.0509291433040.5362@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 23:42:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL69C-0005ul-5d
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 23:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVI2Vky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVI2Vkx
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 17:40:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030254AbVI2Vkw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 17:40:52 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j8TLeji2003469;
	Thu, 29 Sep 2005 17:40:45 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j8TLejV32492;
	Thu, 29 Sep 2005 17:40:45 -0400
Received: from nwo.kernelslacker.org (vpn-4-5.stuttgart.redhat.com [10.32.4.5])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j8TLeimX031073;
	Thu, 29 Sep 2005 17:40:44 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id j8TLehcg011320;
	Thu, 29 Sep 2005 17:40:43 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id j8TLeh3D011319;
	Thu, 29 Sep 2005 17:40:43 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0509291433040.5362@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9517>

On Thu, Sep 29, 2005 at 02:35:15PM -0700, Linus Torvalds wrote:
 > 
 > 
 > On Thu, 29 Sep 2005, Linus Torvalds wrote:
 > > 
 > > Gaah. Using a new pine version, and it is back to corrupting whitespace.
 > 
 > Ok, disabling "text flowing" seems to have fixed it. It still leaves empty 
 > spaces at the end of lines when doing normal word-wrapping in the editor 
 > (and then seems to use those empty spaces as a "marker" for flowing), but 
 > that's at least just a small silly detail.
 > 
 > So how about this patch now? With it you can do
 > 
 > 	git fetch --tags <linus-kernel-repo>
 > 
 > and it should fetch all my tags automatically.

Seems to work. I blew away git/refs/tags/v2.6.13*
and git fetch --tags fetched them all back just fine.

		Dave

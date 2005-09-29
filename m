From: Dave Jones <davej@redhat.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 16:02:52 -0400
Message-ID: <20050929200252.GA31516@redhat.com>
References: <433BC9E9.6050907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030202AbVI2UDV@vger.kernel.org Thu Sep 29 22:06:10 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030202AbVI2UDV@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL4dK-0004FG-5z
	for glk-linux-kernel-3@gmane.org; Thu, 29 Sep 2005 22:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVI2UDV (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Sep 2005 16:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbVI2UDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:03:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030202AbVI2UDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:03:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j8TK30JW001312;
	Thu, 29 Sep 2005 16:03:00 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j8TK2sV02236;
	Thu, 29 Sep 2005 16:02:54 -0400
Received: from nwo.kernelslacker.org (vpn-4-5.stuttgart.redhat.com [10.32.4.5])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j8TK2rn6028956;
	Thu, 29 Sep 2005 16:02:54 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id j8TK2qi1002388;
	Thu, 29 Sep 2005 16:02:52 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id j8TK2qO8002387;
	Thu, 29 Sep 2005 16:02:52 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Jeff Garzik <jgarzik@pobox.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <433BC9E9.6050907@pobox.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9501>

On Thu, Sep 29, 2005 at 07:03:05AM -0400, Jeff Garzik wrote:
 > 
 > Just updated my KHGtG to include the latest goodies available in 
 > git-core, the Linux kernel standard SCM tool:
 > 
 > 	http://linux.yyz.us/git-howto.html
 > 
 > Several changes in git-core have made working with git a lot easier, so 
 > be sure to re-familiarize yourself with the development process.
 > 
 > Comments, corrections, and notes of omission welcome.  This document 
 > mainly reflects my typical day-to-day git activities, and may not be 
 > very applicable outside of kernel work.

You wrote..

$ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
$ cd linux-2.6
$ rsync -a --verbose --stats --progress \
  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
  .git/

Could be just..

$ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
$ cd linux-2.6
$ git pull

Likewise, in the next section, git pull doesn't need an argument
if pulling from the repo it cloned.

		Dave

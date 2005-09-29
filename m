From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 21:07:29 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030241AbVI2UHh@vger.kernel.org Thu Sep 29 22:08:07 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030241AbVI2UHh@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL4hL-0005LR-4S
	for glk-linux-kernel-3@gmane.org; Thu, 29 Sep 2005 22:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVI2UHh (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Sep 2005 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVI2UHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:07:37 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:32165 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030239AbVI2UHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:07:36 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:54673)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpa (EXTERNAL:aia21) id 1EL4gk-0001NP-4W (Exim 4.53)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 29 Sep 2005 21:07:30 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1EL4gj-0007mH-O0 (Exim 4.53)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 29 Sep 2005 21:07:29 +0100
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050929200252.GA31516@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9502>

On Thu, 29 Sep 2005, Dave Jones wrote:
> On Thu, Sep 29, 2005 at 07:03:05AM -0400, Jeff Garzik wrote:
>  > Just updated my KHGtG to include the latest goodies available in 
>  > git-core, the Linux kernel standard SCM tool:
>  > 
>  > 	http://linux.yyz.us/git-howto.html
>  > 
>  > Several changes in git-core have made working with git a lot easier, so 
>  > be sure to re-familiarize yourself with the development process.
>  > 
>  > Comments, corrections, and notes of omission welcome.  This document 
>  > mainly reflects my typical day-to-day git activities, and may not be 
>  > very applicable outside of kernel work.
> 
> You wrote..
> 
> $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> $ cd linux-2.6
> $ rsync -a --verbose --stats --progress \
>   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
>   .git/
> 
> Could be just..
> 
> $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> $ cd linux-2.6
> $ git pull

That is not actually the same.  "git pull" for example will not download 
Linus' tags whilst the rsync would get everything.

> Likewise, in the next section, git pull doesn't need an argument
> if pulling from the repo it cloned.

Now that is definitely correct.  (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

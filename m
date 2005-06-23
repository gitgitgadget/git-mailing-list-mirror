From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 09:01:41 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0506230900140.7099@hermes-1.csi.cam.ac.uk>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262871AbVFWIjw@vger.kernel.org Thu Jun 23 10:45:32 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262871AbVFWIjw@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlNKX-0007TP-Hd
	for glk-linux-kernel@gmane.org; Thu, 23 Jun 2005 10:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVFWIjw (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Thu, 23 Jun 2005 04:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbVFWIgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:36:39 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:42385 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262263AbVFWIBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:01:47 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:54918)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:aia21) id 1DlMeb-0000tL-V8 (Exim 4.51)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 23 Jun 2005 09:01:41 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1DlMeb-00048i-Jv (Exim 4.43)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 23 Jun 2005 09:01:41 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Linus Torvalds wrote:
> On Wed, 22 Jun 2005, Jeff Garzik wrote:
> > 2) download a linux kernel tree for the very first time
> > 
> > $ mkdir -p linux-2.6/.git
> > $ cd linux-2.6
> > $ rsync -a --delete --verbose --stats --progress \
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ 
> > \          <- word-wrapped backslash; sigh
> >      .git/
> 
> Gaah. I should do a "git-clone-script" or something that does this, and 
> then you could just do
> 
> 	git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> 	
> Anybody?

What's wrong with Pasky's cogito scripts?  There is a cg-pull as well as a 
cg-clone in there already.  If nothing else you could just copy the 
relevant scripts and rename them to git-blah...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

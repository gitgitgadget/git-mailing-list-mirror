From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: More problems...
Date: Mon, 2 May 2005 23:01:01 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0505022258150.27741@hermes-1.csi.cam.ac.uk>
References: <20050429170127.A30010@flint.arm.linux.org.uk>
 <20050429182708.GB14202@pasky.ji.cz> <20050429195055.GE1233@mythryan2.michonline.com>
 <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org> <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>
 <20050429221903.F30010@flint.arm.linux.org.uk>
 <Pine.LNX.4.60.0504292254430.25700@hermes-1.csi.cam.ac.uk>
 <20050502193327.GB20818@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Russell King <rmk@arm.linux.org.uk>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 00:19:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSjDB-0002B7-06
	for gcvg-git@gmane.org; Tue, 03 May 2005 00:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVEBWCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 18:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVEBWCv
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 18:02:51 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:13207 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261172AbVEBWBV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 18:01:21 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:53851)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:aia21) id 1DSiyL-0008LC-Uk (Exim 4.51)
	(return-path <aia21@hermes.cam.ac.uk>); Mon, 02 May 2005 23:01:01 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1DSiyL-0007sb-Fw (Exim 4.43)
	(return-path <aia21@hermes.cam.ac.uk>); Mon, 02 May 2005 23:01:01 +0100
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050502193327.GB20818@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2 May 2005, Petr Baudis wrote:
> Dear diary, on Fri, Apr 29, 2005 at 11:57:53PM CEST, I got a letter
> where Anton Altaparmakov <aia21@cam.ac.uk> told me that...
> > There should definitely be an option to either enable or disable this as 
> > there are legitimate cases for not wanting hard links or indeed using 
> > file systems which do not support them.
> 
> Are there legitimate cases for not wanting hard links when you are able
> to create them? (Same filesystem, filesystem supports them...)

I would say yes.  For example, I want to update my git tools to the latest 
and greatest development version.  Do I really want to let it loose on all 
the repositories?  Probably not.  So I would want to make a clone of the 
repository that is not connected in any way with the old one and then 
try the new tools.  If there were hard links involved working on the 
cloned repository could potentially damage the original one.

Yes, yes, I know all tools are perfect and never have bugs but I am 
paranoid.  (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

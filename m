From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: What to expect after GIT 0.99.7
Date: Mon, 19 Sep 2005 07:02:34 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0509190659160.30739@hermes-1.csi.cam.ac.uk>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
 <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 08:03:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHEjg-00033L-EW
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 08:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVISGCh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 02:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVISGCh
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 02:02:37 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:63976 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932321AbVISGCh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 02:02:37 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:33947)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:aia21) id 1EHEja-0000tw-W3 (Exim 4.51)
	(return-path <aia21@hermes.cam.ac.uk>); Mon, 19 Sep 2005 07:02:35 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1EHEja-0008JP-TK (Exim 4.43)
	(return-path <aia21@hermes.cam.ac.uk>); Mon, 19 Sep 2005 07:02:34 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8838>

On Sun, 18 Sep 2005, Junio C Hamano wrote:
[snip]
> * Perhaps a tool to revert a single file to pre-modification
>   state?  git-cat-file blob `git-ls-files | grep foo` >foo or
>   git-cat-file blob `git-ls-tree HEAD foo` >foo?  What should
>   the command be called?  git-revert is taken so is
>   git-checkout.

How about git-clean?  (It cleans a "dirty" file..."  IIRC that is what bk 
used to call it so at least some people should be familliar with its name 
that way.)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

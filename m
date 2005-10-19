From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: git-daemon enabled on kernel.org
Date: Wed, 19 Oct 2005 09:56:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0510190955260.31324@hermes-1.csi.cam.ac.uk>
References: <43554D4F.7040403@zytor.com> <20051019083542.GA31526@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 10:58:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES9lG-0003hG-VM
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 10:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVJSI5U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 04:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVJSI5U
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 04:57:20 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:27800 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932474AbVJSI5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 04:57:19 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:47014)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:25)
	with esmtpa (EXTERNAL:aia21) id 1ES9kl-0006yO-0z (Exim 4.53)
	(return-path <aia21@hermes.cam.ac.uk>); Wed, 19 Oct 2005 09:56:55 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1ES9kl-0004Im-9C (Exim 4.53)
	(return-path <aia21@hermes.cam.ac.uk>); Wed, 19 Oct 2005 09:56:55 +0100
To: Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20051019083542.GA31526@harddisk-recovery.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10277>

On Wed, 19 Oct 2005, Erik Mouw wrote:
> On Tue, Oct 18, 2005 at 12:30:23PM -0700, H. Peter Anvin wrote:
> > After getting gitweb behind mod_cache, the load on kernel.org has gotten 
> > down into the tolerable range, so I have enabled git-daemon in an 
> > attempt to fix that :)
> > 
> > The URL, obviously, is git://git.kernel.org/pub/scm/...
> > 
> > (or, to specify a specific server, git1.kernel.org or git2.kernel.org.)
> 
> How do I tell git to change the default repository to pull from?

Easy, depending on how old your repository either edit 
.git/branches/origin or .git/remotes/origin.  They contain the current 
default, just change it to the new one.  E.g. my .git/remotes/origin for 
Linux-2.6 repository is:

URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Pull: master:origin

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

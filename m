From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Sharing repositories later on
Date: Wed, 12 Jul 2006 17:57:51 +0200
Organization: Harddisk-recovery.com
Message-ID: <20060712155751.GE7328@harddisk-recovery.com>
References: <20060712132800.GA7328@harddisk-recovery.com> <7vpsgazw5j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 17:58:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0h65-0005wo-HT
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 17:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWGLP5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 11:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWGLP5y
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 11:57:54 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:34242 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751415AbWGLP5x (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 11:57:53 -0400
Received: (qmail 5477 invoked from network); 12 Jul 2006 17:57:52 +0200
Received: from unknown (HELO zurix.bitwizard.nl) (192.168.234.26)
  by abra2.bitwizard.nl with SMTP; 12 Jul 2006 17:57:52 +0200
Received: from erik by zurix.bitwizard.nl with local (Exim 3.36 #1 (Debian))
	id 1G0h60-0004Ix-00; Wed, 12 Jul 2006 17:57:52 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsgazw5j.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23787>

On Wed, Jul 12, 2006 at 08:21:28AM -0700, Junio C Hamano wrote:
> Erik Mouw <erik@harddisk-recovery.com> writes:
> > Right now I have a "linux-2.6" repository to track Linus's 2.6 kernel
> > tree and an "elinux-2.6" tree that pulls from linux-2.6 and holds my
> > own changes. I created a file .git/objects/info/alternates that
> > contains the line "/home/erik/git/linux-2.6/.git/objects". Now how do I
> > get rid of the "old" objects and packs without loosing my changes?
> 
> repack -a -d -l perhaps?

Thanks, that did the trick. I now have a small pack with around 100
objects.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Sharing repositories later on
Date: Wed, 12 Jul 2006 15:28:00 +0200
Organization: Harddisk-recovery.com
Message-ID: <20060712132800.GA7328@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 12 15:30:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0elf-0007VU-G4
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 15:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWGLN2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 09:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWGLN2E
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 09:28:04 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:26695 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750813AbWGLN2D (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 09:28:03 -0400
Received: (qmail 25712 invoked from network); 12 Jul 2006 15:28:00 +0200
Received: from unknown (HELO zurix.bitwizard.nl) (192.168.234.26)
  by abra2.bitwizard.nl with SMTP; 12 Jul 2006 15:28:00 +0200
Received: from erik by zurix.bitwizard.nl with local (Exim 3.36 #1 (Debian))
	id 1G0eky-00028K-00
	for <git@vger.kernel.org>; Wed, 12 Jul 2006 15:28:00 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23780>

Hi,

I just learned out about "git clone -s" to share objects between
repositories. How do I use that with already existing repositories?

Right now I have a "linux-2.6" repository to track Linus's 2.6 kernel
tree and an "elinux-2.6" tree that pulls from linux-2.6 and holds my
own changes. I created a file .git/objects/info/alternates that
contains the line "/home/erik/git/linux-2.6/.git/objects". Now how do I
get rid of the "old" objects and packs without loosing my changes?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

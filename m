From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Safe way to remove .temp objects?
Date: Thu, 26 Jan 2006 10:35:07 +0100
Organization: Harddisk-recovery.com
Message-ID: <20060126093507.GA5118@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 26 10:35:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F23XB-00037e-MS
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 10:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWAZJfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 04:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWAZJfO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 04:35:14 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:50057 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932186AbWAZJfM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jan 2006 04:35:12 -0500
Received: (qmail 11677 invoked by uid 501); 26 Jan 2006 10:35:08 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15155>

Hi,

After a git repack, git count-objects reports there are still 20
objects in the repository. It looks like those are temp objects:

  erik@arthur:~/git/linux-2.6 > ls .git/objects/??/
  .git/objects/14/:
  d6545767f5103b5ef4702bc8fffa18dbe32ce1.temp

  .git/objects/1a/:
  d37b580be4215f1b0927b7560f5e8b8d1bc0fa.temp

  [...]

Is there a git command to remove those objects in a safe way, or can I
just rm them without "harming" git??


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com

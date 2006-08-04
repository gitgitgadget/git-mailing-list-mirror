From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [KORG] kernel.org/git/ showing nothing
Date: Fri, 4 Aug 2006 12:59:17 +0200
Organization: Harddisk-recovery.com
Message-ID: <20060804105916.GJ31998@harddisk-recovery.com>
References: <44D3208E.8090403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ftpadmin@kernel.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 12:59:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8xOp-0007PP-8S
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 12:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWHDK7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 06:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161195AbWHDK7V
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 06:59:21 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:21552 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1161185AbWHDK7T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 06:59:19 -0400
Received: (qmail 31405 invoked from network); 4 Aug 2006 12:59:17 +0200
Received: from unknown (HELO zurix.bitwizard.nl) (192.168.234.26)
  by abra2.bitwizard.nl with SMTP; 4 Aug 2006 12:59:17 +0200
Received: from erik by zurix.bitwizard.nl with local (Exim 3.36 #1 (Debian))
	id 1G8xOf-0005iN-00; Fri, 04 Aug 2006 12:59:17 +0200
To: Jeff Garzik <jeff@garzik.org>
Content-Disposition: inline
In-Reply-To: <44D3208E.8090403@garzik.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24788>

On Fri, Aug 04, 2006 at 06:25:18AM -0400, Jeff Garzik wrote:
> When I visit http://www.kernel.org/git/ no projects at all are listed.
> 
> At least one other person independently noted this, as well.

It depends on which www.kernel.org you're looking at:

  erik@arthur:~ > host www.kernel.org
  www.kernel.org          CNAME   zeus-pub.kernel.org
  zeus-pub.kernel.org     A       204.152.191.37
  zeus-pub.kernel.org     A       204.152.191.5

  erik@arthur:~ > host 204.152.191.37
  Name: zeus-pub2.kernel.org
  Address: 204.152.191.37

  erik@arthur:~ > host 204.152.191.5
  Name: zeus-pub1.kernel.org
  Address: 204.152.191.5

http://zeus-pub1.kernel.org/git/ gives you all projects, zeus-pub2
doesn't.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

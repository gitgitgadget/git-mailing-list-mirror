From: Jeff Garzik <jgarzik@pobox.com>
Subject: gitweb and kernel.org
Date: Fri, 20 May 2005 13:48:32 -0400
Message-ID: <428E22F0.3050007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: FTP Admin <ftpadmin@kernel.org>, Kay Sievers <kay.sievers@vrfy.org>
X-From: git-owner@vger.kernel.org Fri May 20 19:49:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZBb5-0005yM-Sm
	for gcvg-git@gmane.org; Fri, 20 May 2005 19:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVETRso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 13:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVETRso
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 13:48:44 -0400
Received: from mail.dvmed.net ([216.237.124.58]:17848 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261162AbVETRsm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 13:48:42 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DZBbw-0008Uy-0W; Fri, 20 May 2005 17:48:38 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


No sure who maintains http://www.kernel.org/git/ so...

I have a request for the above URL:  provide access to branches in 
refs/heads/* somehow.  -All- my work occurs in a branch, with the main 
branch containing nothing but "vanilla Linus" tree.

My jgarzik/libata-dev.git repository contains a large number of branches:
> [jgarzik@pretzel libata-dev]$ ls .git/refs/heads/
> adma        atapi-enable        iomap        new-ids   promise-sata-pata
> adma-mwi    bridge-detect       iomap-step1  passthru  sil24
> ahci-atapi  chs-support         master       pdc2027x
> ahci-msi    ioctl-get-identity  misc-fixes   pdc20619

and ditto for jgarzik/netdev-2.6.git:
> [jgarzik@pretzel netdev-2.6]$ ls .git/refs/heads/
> 8139cp         e100         janitor      pcnet32          skge           we18
> 8139too-iomap  e1000        master       ppp              smc91x         wifi
> airo           forcedeth    misc-fixes   qeth             smc91x-eeprom
> amd8111        hdlc         natsemi      r8169            starfire
> atmel          ieee80211    ns83820      register-netdev  tlan
> chelsio        iff-running  orinoco      remove-drivers   veth
> dm9000         ixgb         orinoco-hch  sis900           viro


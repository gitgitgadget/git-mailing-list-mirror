From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb and kernel.org
Date: Fri, 20 May 2005 20:58:21 +0200
Message-ID: <1116615502.12975.29.camel@dhcp-188>
References: <428E22F0.3050007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	FTP Admin <ftpadmin@kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 20:58:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZCgm-00077h-Vh
	for gcvg-git@gmane.org; Fri, 20 May 2005 20:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVETS6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 14:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVETS6l
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 14:58:41 -0400
Received: from soundwarez.org ([217.160.171.123]:21212 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261548AbVETS6i (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 14:58:38 -0400
Received: from dhcp-188.off.vrfy.org (d027239.adsl.hansenet.de [80.171.27.239])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 3DF0A5C61;
	Fri, 20 May 2005 20:58:36 +0200 (CEST)
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <428E22F0.3050007@pobox.com>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-20 at 13:48 -0400, Jeff Garzik wrote:
> No sure who maintains http://www.kernel.org/git/ so...
> 
> I have a request for the above URL:  provide access to branches in 
> refs/heads/* somehow.  -All- my work occurs in a branch, with the main 
> branch containing nothing but "vanilla Linus" tree.
> 
> My jgarzik/libata-dev.git repository contains a large number of branches:
> > [jgarzik@pretzel libata-dev]$ ls .git/refs/heads/
> > adma        atapi-enable        iomap        new-ids   promise-sata-pata
> > adma-mwi    bridge-detect       iomap-step1  passthru  sil24
> > ahci-atapi  chs-support         master       pdc2027x
> > ahci-msi    ioctl-get-identity  misc-fixes   pdc20619
> 
> and ditto for jgarzik/netdev-2.6.git:
> > [jgarzik@pretzel netdev-2.6]$ ls .git/refs/heads/
> > 8139cp         e100         janitor      pcnet32          skge           we18
> > 8139too-iomap  e1000        master       ppp              smc91x         wifi
> > airo           forcedeth    misc-fixes   qeth             smc91x-eeprom
> > amd8111        hdlc         natsemi      r8169            starfire
> > atmel          ieee80211    ns83820      register-netdev  tlan
> > chelsio        iff-running  orinoco      remove-drivers   veth
> > dm9000         ixgb         orinoco-hch  sis900           viro

Initial support for branches added! :)

Kay


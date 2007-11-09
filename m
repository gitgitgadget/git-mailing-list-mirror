From: "Medve Emilian" <Emilian.Medve@freescale.com>
Subject: linux-2.6 clone with CygWin git
Date: Fri, 9 Nov 2007 07:29:07 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E270174D8A2@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 15:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUrW-0007st-Dh
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 15:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760178AbXKIO3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 09:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760349AbXKIO3T
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 09:29:19 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:36304 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759848AbXKIO3S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 09:29:18 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id lA9ET9xs022151
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 07:29:15 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lA9ET8F3003497
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 08:29:09 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: linux-2.6 clone with CygWin git
thread-index: Acgi3OMnVwG9jCkOQXmAtfzFWy1aTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64190>

Hello,


I noticed that something might not be right with my CygWin git (latest
CygWin relevant build packages + a few days old git build from the next
& master branches). When I clone, say,  Linus' tree over the native git
protocol everything goes fine but a git-status shows this:

$ git-status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   include/linux/netfilter/xt_CONNMARK.h
#       modified:   include/linux/netfilter/xt_DSCP.h
#       modified:   include/linux/netfilter/xt_MARK.h
#       modified:   include/linux/netfilter/xt_TCPMSS.h
#       modified:   include/linux/netfilter_ipv4/ipt_CONNMARK.h
#       modified:   include/linux/netfilter_ipv4/ipt_DSCP.h
#       modified:   include/linux/netfilter_ipv4/ipt_ECN.h
#       modified:   include/linux/netfilter_ipv4/ipt_MARK.h
#       modified:   include/linux/netfilter_ipv4/ipt_TCPMSS.h
#       modified:   include/linux/netfilter_ipv4/ipt_TOS.h
#       modified:   include/linux/netfilter_ipv4/ipt_TTL.h
#       modified:   include/linux/netfilter_ipv6/ip6t_HL.h
#       modified:   include/linux/netfilter_ipv6/ip6t_MARK.h
#       modified:   net/ipv4/netfilter/ipt_ECN.c
#       modified:   net/ipv4/netfilter/ipt_TOS.c
#       modified:   net/ipv4/netfilter/ipt_TTL.c
#       modified:   net/ipv6/netfilter/ip6t_HL.c
#       modified:   net/netfilter/xt_CONNMARK.c
#       modified:   net/netfilter/xt_DSCP.c
#       modified:   net/netfilter/xt_MARK.c
#       modified:   net/netfilter/xt_TCPMSS.c
#
no changes added to commit (use "git add" and/or "git commit -a")

git-fsck --strict --full finds no fault in the clone, git-reset --hard
goes fine but changes nothing in the output of git-status. Some
additional superficial investigation showed that git-diff doesn't even
compare my checked out tree against the latest commit. Checkout of
various commits shows the same issue.

Can somebody please double-check this scenario for me just to validate
that this happens only due to some particular factors combination on my
box?


Thanks,
Emil.

From: Len Brown <lenb@kernel.org>
Subject: octopus limit
Date: Thu, 26 Jun 2008 22:44:23 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806262243130.2988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 04:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC3yO-00031e-OV
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 04:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbYF0CpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 22:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYF0CpA
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 22:45:00 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:53709 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237AbYF0Con (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 22:44:43 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3300B1DOY0Q4O7@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 26 Jun 2008 21:44:25 -0500 (CDT)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id m5R2iN69018997	for
 <git@vger.kernel.org>; Thu, 26 Jun 2008 22:44:24 -0400
Received: from localhost (lenb@localhost)
	by localhost.localdomain (8.14.2/8.14.2/Submit) with ESMTP id m5R2iNHp018992
	for <git@vger.kernel.org>; Thu, 26 Jun 2008 22:44:23 -0400
X-X-Sender: lenb@localhost.localdomain
X-Authentication-warning: localhost.localdomain: lenb owned process doing -bs
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86514>

it would be nice if a merge of more than 16 branches failed
right at the start, rather than chunking along doing merges
and then giving up, leaving my repo in an intermediate state.

cheers,
-len

git merge test acpica bugzilla-10807-v2 bugzilla-10927 bugzilla-6217 
bugzilla-9684 bugzilla-9704 bugzilla-9772 compal-laptop debug-test 
dev-printk fujitsu-laptop gpe-debug misc per-cpu pnp-v3 suspend wmi-2.6.27
Already up-to-date with c4e6a2e64e948de42473e9c829181d768b1258c3
Trying simple merge with aa10d9f35361d3b260750f305ba8eb41c78e1a29
Trying simple merge with 23ac069d8be58c314af149dca2bb42dafdc38069
Trying simple merge with 60d40a50886415040888bde5133ccfeab40d945f
Trying simple merge with a7f34ae2abc9cb51a5b906f2da0aaa697f1a8883
Simple merge did not work, trying automatic merge.
Auto-merging drivers/acpi/events/evgpe.c
Trying simple merge with 009733ab59c05c4331c5504001587562e66a0d2b
Trying simple merge with 7004cf59cbfa54bc5ef0b3c5e0f81af410365e07
Trying simple merge with ad7f0d9feee6980a3ab3ea806854f56817d1da8e
Simple merge did not work, trying automatic merge.
Auto-merging drivers/acpi/processor_core.c
Auto-merging drivers/acpi/scan.c
Auto-merging kernel/cpu.c
Trying simple merge with 46c636862ee7e2f45e3369393f7c00761727e674
Simple merge did not work, trying automatic merge.
Auto-merging MAINTAINERS
Trying simple merge with 9e030ab0bffdc8b6d8be663b639bd5e2374537f0
Simple merge did not work, trying automatic merge.
Auto-merging drivers/acpi/namespace/nsxfeval.c
Auto-merging drivers/acpi/utilities/utmisc.c
Trying simple merge with 48e25157d315ec5fed3f5e1db88119dcde6175ea
Trying simple merge with 770c091f85a922d92505e2da8b30cf30dd6bc2f3
Simple merge did not work, trying automatic merge.
Auto-merging MAINTAINERS
Auto-merging drivers/misc/Kconfig
Trying simple merge with bb9babebc64541307d2eca41ed8e4c977f4beb10
Simple merge did not work, trying automatic merge.
Auto-merging drivers/acpi/hardware/hwgpe.c
Auto-merging include/acpi/achware.h
Auto-merging include/acpi/acpixf.h
Trying simple merge with eac9c2dc06e1ea25efebcd3d508c0ae40f4a9ece
Simple merge did not work, trying automatic merge.
Auto-merging include/acpi/aclocal.h
Trying simple merge with e1d755bbddba413c4050db1bfbe1f7e17dee3002
Simple merge did not work, trying automatic merge.
Auto-merging drivers/acpi/processor_core.c
Auto-merging drivers/acpi/processor_idle.c
Auto-merging drivers/acpi/processor_throttling.c
Auto-merging include/acpi/processor.h
Trying simple merge with f382348d43f80b6267a0881729366be2e5542ace
Trying simple merge with a143f92aca5eaf9a4ac608f7d208592e514574ed
Simple merge did not work, trying automatic merge.
Auto-merging drivers/acpi/sleep/main.c
Trying simple merge with 1a76b5a83e977cee4cd27c2f45a239a5faa9c1cc
fatal: Too many parents (16 max)

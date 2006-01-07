From: Len Brown <len.brown@intel.com>
Subject: Re: needs merge
Date: Sat, 7 Jan 2006 03:57:13 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200601070357.13954.len.brown@intel.com>
References: <200601070332.36654.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 07 09:57:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev9t2-00019t-MJ
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 09:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWAGI5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 03:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWAGI5S
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 03:57:18 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:37564 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030367AbWAGI5R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 03:57:17 -0500
Received: from intel.com (c-24-63-232-79.hsd1.ma.comcast.net[24.63.232.79])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2006010708571601400q96bae>; Sat, 7 Jan 2006 08:57:16 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <200601070332.36654.len.brown@intel.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14246>

> git-update-index my-file

yes, that allowed the git commit to complete, thanks.

however, when i then merged that branch into another there seem to
be some phantom conflicts on the very same files.
Do I understand all this output to mean that git attempted two
different merges, and discarded the 1st attempt in favor of the second?

thanks,
-Len

$ /lab/bin/git.merge acpica test
Merging test with ed03f430cdc8c802652467e9097606fedc2c7abc
Merging:
e3627f3165301a7d946c2dc40be93f744f441c30 Auto-update from upstream
ed03f430cdc8c802652467e9097606fedc2c7abc Pull pnpacpi into acpica branch
found 2 common ancestor(s):
0aec63e67c69545ca757a73a66f5dcf05fa484bf [PATCH] Fix posix-cpu-timers sched_time accumulation
ed349a8a0a780ed27e2a765f16cee54d9b63bfee [ACPI] fix pnpacpi regression resulting from ACPICA 20051117
  Merging:
  0aec63e67c69545ca757a73a66f5dcf05fa484bf [PATCH] Fix posix-cpu-timers sched_time accumulation
  ed349a8a0a780ed27e2a765f16cee54d9b63bfee [ACPI] fix pnpacpi regression resulting from ACPICA 20051117
  found 1 common ancestor(s):
  927fe18397b3b1194a5b26b1d388d97e391e5fd2 Pull 5165 into release branch
  Auto-merging arch/i386/kernel/mpparse.c
  Auto-merging include/asm-x86_64/mpspec.h
  Auto-merging arch/ia64/pci/pci.c
  Auto-merging drivers/acpi/utilities/utmisc.c
  CONFLICT (content): Merge conflict in drivers/acpi/utilities/utmisc.c
  Auto-merging include/acpi/acglobal.h
  CONFLICT (content): Merge conflict in include/acpi/acglobal.h
  Auto-merging drivers/acpi/scan.c
  Auto-merging drivers/acpi/pci_link.c

Merge bfaa3a0777f0fc3b82831cb1daf286f8ac3b4c8d, made by recursive.
 drivers/pnp/pnpacpi/rsparser.c |   48 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 44 insertions(+), 4 deletions(-)
$

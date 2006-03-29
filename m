From: Len Brown <len.brown@intel.com>
Subject: Is 'merge' in your path?
Date: Wed, 29 Mar 2006 03:42:39 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200603290342.40970.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Mar 29 10:42:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOWFa-0003lf-42
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 10:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWC2Ilx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 03:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWC2Ilx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 03:41:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:12863 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750766AbWC2Ilx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 03:41:53 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101-1.jf.intel.com with ESMTP; 29 Mar 2006 00:41:52 -0800
Received: from unknown (HELO fmsmsxvs040.fm.intel.com) ([132.233.42.124])
  by orsmga001.jf.intel.com with SMTP; 29 Mar 2006 00:41:52 -0800
X-IronPort-AV: i="4.03,142,1141632000"; 
   d="scan'208"; a="16487600:sNHT15548029"
Received: from toshiba.site ([10.127.56.187])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006032900415127756
 for <git@vger.kernel.org>; Wed, 29 Mar 2006 00:41:51 -0800
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18160>

trying to do a merge on my laptop using git as of today,
but it bombs out.  anybody seen this?

lenb@toshiba:~/src> git --version
git version 1.3-rc1.GIT

lenb@toshiba:~/src/linux-acpi-2.6> /lab/bin/git.update test
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging test with 224b148ef7c9a00642eb33dbdf62f2840bde974f
Merging:
9dc2a5c16ba732595afa926aabbf07efaef40b92 Pull trivial into test branch
224b148ef7c9a00642eb33dbdf62f2840bde974f Merge branch 'for-linus' of 
master.kernel.org:/pub/scm/linux/kernel/git/scjody/ieee1394
found 1 common ancestor(s):
35ab0e88c63fb8e61013011560ad10e6200b5ee0 Merge branch 'release' of 
git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6
Removing arch/sparc64/lib/find_bit.c
Removing drivers/scsi/qla2xxx/ql6312.c
Removing include/asm-arm/arch-h720x/param.h
Removing include/asm-arm/arch-imx/irq.h
Removing drivers/usb/media/pwc/pwc-kiara.c
Removing include/asm-ppc/xparameters.h
Removing drivers/i2c/busses/i2c-frodo.c
Removing include/asm-arm/arch-lh7a40x/irq.h
Removing drivers/char/rio/riopcicopy.c
Auto-merging Documentation/kernel-parameters.txt
merge -L test/Documentation/kernel-parameters.txt -L 
orig/Documentation/kernel-parameters.txt -L 
224b148ef7c9a00642eb33dbdf62f2840bde974f/Documentation/kernel-parameters.txt .merge_file_2KLpUR .merge_file_H6NRcP .merge_file_WLV6HQ: 
No such file or directory
Failed to execute 'merge'. merge(1) is used as the file-level merge tool. Is 
'merge' in your path?
No merge strategy handled the merge.
lenb@toshiba:~/src/linux-acpi-2.6> which git-merge
/home/lenb/bin/git-merge
lenb@toshiba:~/src/linux-acpi-2.6> which git
/home/lenb/bin/git
lenb@toshiba:~/src/linux-acpi-2.6>                               

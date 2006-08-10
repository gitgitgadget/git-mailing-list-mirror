From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: merge-recur status
Date: Thu, 10 Aug 2006 08:29:14 +0200
Message-ID: <20060810062914.GA5192@c165.ib.student.liu.se>
References: <Pine.LNX.4.63.0608092232000.13885@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Aug 10 08:29:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB42i-0000w0-6A
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 08:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWHJG3R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 02:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWHJG3Q
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 02:29:16 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:56525 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1161047AbWHJG3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 02:29:16 -0400
Received: from c165 ([213.114.27.85] [213.114.27.85])
          by mxfep01.bredband.com with ESMTP
          id <20060810062914.BYGW17083.mxfep01.bredband.com@c165>;
          Thu, 10 Aug 2006 08:29:14 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GB42c-0001RP-00; Thu, 10 Aug 2006 08:29:14 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608092232000.13885@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25156>

Hi,

I just want to say that you have made a great work with porting
merge-recursive to C!

I ran merge-recur through a couple of test merges that I used to test
merge-recursive with. It is mostly merge cases people have posted to
the mailing list, but also some home made ones. For some of them I get
segmentation faults, see the log below. The first three come from
Linus kernel tree. The last one,
44583d380d189095fa959ec8ba87f0cb6deb15f5, is from Thomas Gleixner's
historical Linux kernel repository. I haven't seen "fatal: fatal:
cache changed flush_cache();" before...

Let me know if you can't reproduce some them.

- Fredrik



Testing 84ffa747520edd4556b136bdfc9df9eb1673ce12 Merge from-linus to-akpm
Starting merge...
Merging merge-test-branch with 81065e2f415af6c028eac13f481fb9e60a0b487b
Merging:
702c7e7626deeabb057b6f529167b65ec2eefbdb [ACPI] fix ia64 build issues resulting from Lindent and merge
81065e2f415af6c028eac13f481fb9e60a0b487b [PATCH] zd1201 kmalloc size fix
found 2 common ancestor(s):
30e332f3307e9f7718490a706e5ce99f0d3a7b26 [ACPI] re-enable platform-specific hotkey drivers by default
3edea4833a1efcd43e1dff082bc8001fdfe74b34 [PATCH] intelfb/fbdev: Save info->flags in a local variable
  Merging:
  30e332f3307e9f7718490a706e5ce99f0d3a7b26 [ACPI] re-enable platform-specific hotkey drivers by default
  3edea4833a1efcd43e1dff082bc8001fdfe74b34 [PATCH] intelfb/fbdev: Save info->flags in a local variable
  found 1 common ancestor(s):
  d4ab025b73a2d10548e17765eb76f3b7351dc611 [ACPI] delete Warning: Encountered executable code at module level, [AE_NOT_CONFIGURED]
  Removing Documentation/DocBook/scsidrivers.tmpl
  Removing Documentation/dvb/README.dibusb
  Auto-merging Documentation/kernel-parameters.txt
  Removing Documentation/networking/wanpipe.txt
  Removing arch/arm/kernel/arch.c
  Removing arch/arm/lib/longlong.h
  Removing arch/arm/lib/udivdi3.c
  Removing arch/arm/mach-omap/Kconfig
  Removing arch/arm/mach-omap/Makefile
  Removing arch/arm/mach-omap/common.c
  Removing arch/mips/vr41xx/common/giu.c
  Removing arch/ppc/boot/utils/addSystemMap.c
  Removing arch/ppc/syslib/ppc4xx_kgdb.c
  Removing arch/ppc64/boot/mknote.c
  Removing arch/ppc64/boot/piggyback.c
  Removing arch/ppc64/kernel/XmPciLpEvent.c
  Removing arch/ppc64/kernel/iSeries_pci_reset.c
  Removing arch/um/kernel/skas/time.c
  Removing arch/um/kernel/tt/time.c
  Removing arch/um/kernel/tt/unmap.c
  Auto-merging drivers/acpi/osl.c
  Removing drivers/base/class_simple.c
  Removing drivers/ide/cris/ide-v10.c
  Removing drivers/input/gameport/cs461x.c
  Removing drivers/input/gameport/vortex.c
  Removing drivers/isdn/hisax/enternow.h
  Removing drivers/isdn/hisax/st5481_hdlc.c
  Removing drivers/isdn/hisax/st5481_hdlc.h
  Removing drivers/isdn/sc/debug.c
  Removing drivers/macintosh/macserial.c
  Removing drivers/macintosh/macserial.h
  Removing drivers/media/dvb/b2c2/skystar2.c
  Removing drivers/media/dvb/dibusb/Kconfig
  Removing drivers/media/dvb/dibusb/Makefile
  Removing drivers/media/dvb/dibusb/dvb-dibusb-core.c
  Removing drivers/media/dvb/dibusb/dvb-dibusb-dvb.c
  Removing drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c
  Removing drivers/media/dvb/dibusb/dvb-dibusb-firmware.c
  Removing drivers/media/dvb/dibusb/dvb-dibusb-remote.c
  Removing drivers/media/dvb/dibusb/dvb-dibusb-usb.c
  Removing drivers/media/dvb/dibusb/dvb-dibusb.h
  Removing drivers/mtd/maps/db1550-flash.c
  Removing drivers/mtd/maps/db1x00-flash.c
  Removing drivers/mtd/maps/elan-104nc.c
  Removing drivers/mtd/maps/pb1550-flash.c
  Removing drivers/mtd/maps/pb1xxx-flash.c
  Removing drivers/mtd/nand/tx4925ndfmc.c
  Removing drivers/mtd/nand/tx4938ndfmc.c
  Removing drivers/net/fmv18x.c
  Removing drivers/net/sk_g16.c
  Removing drivers/net/sk_g16.h
  Removing drivers/net/skfp/lnkstat.c
  Removing drivers/net/skfp/smtparse.c
  Removing drivers/net/smc-mca.h
  Removing drivers/pci/hotplug/acpiphp_pci.c
  Removing drivers/pci/hotplug/acpiphp_res.c
  Removing drivers/scsi/pci2000.c
  Removing drivers/scsi/pci2220i.c
  Removing drivers/scsi/pci2220i.h
  Removing drivers/scsi/psi_dale.h
  Removing drivers/scsi/psi_roy.h
  Removing drivers/serial/bast_sio.c
  Removing drivers/usb/atm/usb_atm.c
  Removing drivers/usb/atm/usb_atm.h
  Removing fs/freevxfs/vxfs_kcompat.h
  Removing include/asm-m32r/m32102peri.h
  Removing include/asm-ppc/fsl_ocp.h
  Removing include/asm-ppc64/iSeries/HvCallCfg.h
  Removing include/asm-ppc64/iSeries/LparData.h
  Removing include/asm-ppc64/iSeries/XmPciLpEvent.h
  Removing include/asm-ppc64/iSeries/iSeries_proc.h
  Removing include/linux/ioc4_common.h
  Removing include/linux/netfilter_ipv4/lockhelp.h
  Removing include/linux/pci-dynids.h
  Removing include/linux/xattr_acl.h
  Removing net/ipv4/utils.c
  Removing sound/pcmcia/vx/vx_entry.c
  Removing sound/pcmcia/vx/vxp/home/freku/local/bin/git-merge: line 286: 32288 Segmenteringsfel        git-merge-$strategy $common -- "$head_arg" "$@"
No merge strategy handled the merge.
Exit code: 2


Testing 0c168775709faa74c1b87f1e61046e0c51ade7f3 Merge upstream 2.6.13-rc1-git1 into 'ieee80211' branch of netdev-2.6.
Starting merge...
/home/freku/local/bin/git-merge: line 286: 32357 Segmenteringsfel        git-merge-$strategy $common -- "$head_arg" "$@"
No merge strategy handled the merge.
Exit code: 2



Testing 467ca22d3371f132ee225a5591a1ed0cd518cb3d Merge with rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Starting merge...
/home/freku/local/bin/git-merge: line 286: 32702 Segmenteringsfel        git-merge-$strategy $common -- "$head_arg" "$@"
No merge strategy handled the merge.
Exit code: 2


Testing 44583d380d189095fa959ec8ba87f0cb6deb15f5 Merge uml.karaya.com:/home/jdike/linux/2.5/skas-2.5
Starting merge...
merge: warning: conflicts during merge
fatal: fatal: cache changed flush_cache();
Merging merge-test-branch with 8bf1412a4bbfc9da0224e73203172f98f987b41a
Merging:
645dbacc0c65228151b7cbcb8a977c83328cef76 Put X86_NUMAQ and X86_SUMMIT under the "Subarchitecture Type" config.
8bf1412a4bbfc9da0224e73203172f98f987b41a Forwarded ported a number of skas-related fixes from 2.4.
found 6 common ancestor(s):
170f6c8f82c198fb54f86cbef95a631eec6034af Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
6543e917ce4a0b1702d80a3d54b3711cf936abef Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
48277fd028606d49ed7cbfa3d70006c7701e8157 Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
625207a1f419e3e217a0b343f12accf9d281d25b Merge jdike.stearns.org:linux/fixes-2.5
8631e9b3bd11d994fb99bc9f7451a1337cfc9487 Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
31f3e9c005d3378db504d26e387ba6b91aa19e49 Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  Merging:
  170f6c8f82c198fb54f86cbef95a631eec6034af Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  6543e917ce4a0b1702d80a3d54b3711cf936abef Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  found 2 common ancestor(s):
  5e32ae7ed6f1dd53fbdd9c3540f4b1dcbcc0c5ef Linux v2.5.53
  433553bd1f42c0515fe77d9c0a93b67c2ff66030 Updated to 2.5.49, which involved fixing the calls to do_fork.
    Merging:
    5e32ae7ed6f1dd53fbdd9c3540f4b1dcbcc0c5ef Linux v2.5.53
    433553bd1f42c0515fe77d9c0a93b67c2ff66030 Updated to 2.5.49, which involved fixing the calls to do_fork.
    found 1 common ancestor(s):
    cebce9d8beb7493d5c82035db854a475f6a1ae66 Linux v2.5.49
    Auto-merging arch/um/kernel/sys_call_table.c
    Auto-merging arch/um/sys-i386/Makefile
  Auto-merging arch/um/kernel/signal_kern.c
  Auto-merging arch/um/kernel/syscall_kern.c
  Removing arch/um/ptproxy/Makefile
  Merging:
  virtual merged tree
  48277fd028606d49ed7cbfa3d70006c7701e8157 Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  found 1 common ancestor(s):
  5e32ae7ed6f1dd53fbdd9c3540f4b1dcbcc0c5ef Linux v2.5.53
  Merging:
  virtual merged tree
  625207a1f419e3e217a0b343f12accf9d281d25b Merge jdike.stearns.org:linux/fixes-2.5
  found 1 common ancestor(s):
  5e32ae7ed6f1dd53fbdd9c3540f4b1dcbcc0c5ef Linux v2.5.53
  Auto-merging arch/um/Makefile
  Removing arch/um/boot/Makefile
  Auto-merging arch/um/drivers/fd.c
  Auto-merging arch/um/drivers/port_kern.c
  CONFLICT (content): Merge conflict in arch/um/drivers/port_kern.c
  Auto-merging arch/um/drivers/port_user.c
  Auto-merging arch/um/drivers/ubd_kern.c
  Auto-merging arch/um/drivers/xterm.c
  Auto-merging arch/um/kernel/helper.c
  Removing arch/um/kernel/setup.c
  Merging:
  virtual merged tree
  8631e9b3bd11d994fb99bc9f7451a1337cfc9487 Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  found 2 common ancestor(s):
  5e32ae7ed6f1dd53fbdd9c3540f4b1dcbcc0c5ef Linux v2.5.53
  341d04a98d72b0693909f8e8a7ef3b064f07167d Merged the get_config changes from 2.4.
    Merging:
    5e32ae7ed6f1dd53fbdd9c3540f4b1dcbcc0c5ef Linux v2.5.53
    341d04a98d72b0693909f8e8a7ef3b064f07167d Merged the get_config changes from 2.4.
    found 1 common ancestor(s):
    fc983daf8fe2318d66f416931b0f6b1e469e78e6 Linux v2.5.48
  Already uptodate!
  Merging:
  virtual merged tree
  31f3e9c005d3378db504d26e387ba6b91aa19e49 Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  found 1 common ancestor(s):
  5e32ae7ed6f1dd53fbdd9c3540f4b1dcbcc0c5ef Linux v2.5.53
No merge strategy handled the merge.
Exit code: 2

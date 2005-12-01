From: Luben Tuikov <ltuikov@yahoo.com>
Subject: resolve (merge) problems
Date: Thu, 1 Dec 2005 15:18:44 -0800 (PST)
Message-ID: <20051201231844.59450.qmail@web31801.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Dec 02 00:19:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhxhT-00034g-25
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 00:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVLAXSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 18:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVLAXSq
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 18:18:46 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:6325 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750704AbVLAXSp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 18:18:45 -0500
Received: (qmail 59452 invoked by uid 60001); 1 Dec 2005 23:18:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2srZKzSwAanvvVDEAKH1Y7FET1KGlC/6sKDTsRaPHml+dQeYtJjD049LcpfrisGStY1z+AF/KWnDpIpBmzPwTFDABD97eEmeWVhtDXN4QtOQr8M+LzF6EavIhfqIjwZWny9jUBn7/M9Jnnz8HxXGE/wfVq0MBVVJ8HUc5Ywv+GI=  ;
Received: from [68.221.13.176] by web31801.mail.mud.yahoo.com via HTTP; Thu, 01 Dec 2005 15:18:44 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13087>

Hi,

$git resolve HEAD master "merge linus' tree"
Trying to merge 5666c0947ede0432ba5148570aa66ffb9febff5b into
32df3299405fb7054b76346899f3db2fa29150fb using 458af5439fe7ae7d95ca14106844e61f0795166c.
Simple merge failed, trying Automatic merge
Removing arch/arm/configs/poodle_defconfig
Removing drivers/atm/atmdev_init.c
fatal: merge program failed
Automatic merge failed, fix up by hand

How do I proceed from here?

The output from git-diff-index is:

$git-diff-index --name-status HEAD
M       Documentation/usb/error-codes.txt
M       Makefile
M       arch/arm/configs/corgi_defconfig
U       arch/arm/configs/poodle_defconfig
M       arch/arm/configs/spitz_defconfig
M       arch/arm/kernel/head.S
M       arch/arm/mach-pxa/Kconfig
M       arch/arm/mach-realview/core.c
M       arch/arm/mm/consistent.c
M       arch/arm/tools/mach-types
M       arch/frv/kernel/semaphore.c
M       arch/frv/mb93090-mb00/pci-irq.c
M       arch/frv/mm/init.c
M       arch/frv/mm/pgalloc.c
M       arch/i386/kernel/io_apic.c
M       arch/i386/kernel/reboot.c
M       arch/ia64/kernel/ia64_ksyms.c
M       arch/ia64/kernel/kprobes.c
M       arch/ia64/kernel/traps.c
M       arch/m32r/kernel/io_mappi3.c
M       arch/m32r/kernel/setup_mappi3.c
M       arch/m32r/kernel/sys_m32r.c
M       arch/powerpc/kernel/ppc_ksyms.c
M       arch/powerpc/kernel/process.c
M       arch/powerpc/kernel/prom_init.c
M       arch/powerpc/kernel/vdso.c
M       arch/ppc/kernel/ppc_ksyms.c
M       arch/ppc/kernel/process.c
M       arch/sparc/mm/generic.c
M       arch/sparc64/mm/generic.c
M       drivers/atm/Kconfig
M       drivers/atm/Makefile
A       drivers/atm/adummy.c
U       drivers/atm/atmdev_init.c
M       drivers/atm/atmtcp.c
M       drivers/atm/lanai.c
M       drivers/char/drm/drm_context.c
M       drivers/char/mem.c
M       drivers/cpufreq/cpufreq.c
M       drivers/hwmon/w83792d.c
M       drivers/md/md.c
M       drivers/md/raid1.c
M       drivers/md/raid10.c
M       drivers/md/raid5.c
M       drivers/md/raid6main.c
M       drivers/media/video/Kconfig
M       drivers/media/video/cx88/Kconfig
M       drivers/media/video/cx88/Makefile
M       drivers/media/video/saa7134/Kconfig
M       drivers/media/video/saa7134/Makefile
M       drivers/message/fusion/mptbase.c
M       drivers/message/fusion/mptbase.h
M       drivers/mmc/mmc.c
M       drivers/mtd/chips/cfi_cmdset_0001.c
M       drivers/mtd/chips/cfi_probe.c
M       drivers/mtd/chips/sharp.c
M       drivers/mtd/devices/block2mtd.c
M       drivers/mtd/devices/ms02-nv.c
M       drivers/mtd/ftl.c
M       drivers/mtd/maps/Kconfig
M       drivers/mtd/maps/Makefile
M       drivers/mtd/maps/ixp4xx.c
M       drivers/mtd/maps/nettel.c
M       drivers/mtd/maps/pci.c
M       drivers/mtd/maps/physmap.c
M       drivers/mtd/maps/sc520cdp.c
M       drivers/mtd/nand/nandsim.c
M       drivers/mtd/rfd_ftl.c
M       drivers/pcmcia/m32r_cfc.c
M       drivers/scsi/megaraid.c
M       drivers/serial/8250.c
M       drivers/serial/8250_pci.c
M       drivers/serial/serial_core.c
M       drivers/serial/serial_cs.c
M       drivers/usb/atm/cxacru.c
M       drivers/usb/atm/usbatm.c
M       drivers/usb/core/hcd-pci.c
M       drivers/usb/core/hcd.c
M       drivers/usb/core/hcd.h
M       drivers/usb/host/ehci-pci.c
M       drivers/usb/host/ehci-q.c
M       drivers/usb/host/ehci-sched.c
M       drivers/usb/host/ohci-hcd.c
M       drivers/usb/host/ohci-hub.c
M       drivers/usb/host/ohci-pci.c
M       drivers/usb/host/uhci-hcd.c
M       drivers/video/Kconfig
M       drivers/video/cirrusfb.c
M       drivers/video/console/fbcon_ccw.c
M       drivers/video/console/fbcon_rotate.h
M       fs/9p/vfs_inode.c
M       fs/cifs/CHANGES
M       fs/cifs/README
M       fs/cifs/TODO
M       fs/cifs/cifsfs.c
M       fs/cifs/cifssmb.c
M       fs/cifs/dir.c
M       fs/cifs/inode.c
M       fs/cifs/misc.c
M       fs/cifs/netmisc.c
M       fs/cifs/transport.c
M       fs/dquot.c
M       fs/exec.c
M       fs/ext3/resize.c
M       fs/fuse/dir.c
M       fs/hfsplus/hfsplus_fs.h
M       fs/hfsplus/hfsplus_raw.h
M       fs/hfsplus/options.c
M       fs/hfsplus/super.c
M       fs/jffs2/fs.c
M       fs/jffs2/super.c
M       fs/proc/task_mmu.c
M       fs/reiserfs/inode.c
M       fs/reiserfs/journal.c
M       include/asm-arm/arch-s3c2410/regs-gpio.h
M       include/asm-arm/arch-sa1100/io.h
M       include/asm-frv/hardirq.h
M       include/asm-frv/ide.h
M       include/asm-frv/page.h
M       include/asm-frv/semaphore.h
M       include/asm-frv/thread_info.h
M       include/asm-ia64/page.h
M       include/asm-m32r/atomic.h
M       include/asm-m32r/ide.h
M       include/asm-m32r/mappi3/mappi3_pld.h
M       include/asm-m32r/system.h
M       include/asm-sparc64/pgtable.h
M       include/linux/atmdev.h
M       include/linux/cn_proc.h
M       include/linux/cpu.h
M       include/linux/memory.h
M       include/linux/mm.h
M       include/linux/mmc/protocol.h
M       include/linux/mtd/cfi.h
M       include/linux/rmap.h
M       include/linux/sched.h
M       include/linux/serial_core.h
M       include/linux/swap.h
M       kernel/cpu.c
M       kernel/fork.c
M       kernel/posix-cpu-timers.c
M       kernel/power/main.c
M       kernel/ptrace.c
M       kernel/workqueue.c
M       lib/genalloc.c
M       mm/fremap.c
M       mm/madvise.c
M       mm/memory.c
M       mm/mempolicy.c
M       mm/msync.c
M       mm/nommu.c
M       mm/page_alloc.c
M       mm/rmap.c
M       mm/thrash.c
M       mm/vmscan.c
M       net/atm/atm_misc.c
M       net/atm/common.c
M       net/atm/common.h
M       net/atm/resources.c
M       net/atm/resources.h
M       net/ipv4/fib_hash.c
M       net/ipv4/fib_semantics.c
M       net/ipv4/icmp.c
M       net/ipv4/ip_gre.c
M       net/ipv4/ip_output.c
M       net/ipv4/ipvs/ip_vs_conn.c
M       net/ipv4/ipvs/ip_vs_ctl.c
M       net/ipv4/ipvs/ip_vs_proto_tcp.c
M       net/ipv4/netfilter/ip_conntrack_amanda.c
M       net/ipv4/netfilter/ip_conntrack_core.c
M       net/ipv4/netfilter/ip_conntrack_ftp.c
M       net/ipv4/netfilter/ip_conntrack_irc.c
M       net/ipv4/netfilter/ip_conntrack_proto_icmp.c
M       net/ipv4/netfilter/ip_conntrack_proto_sctp.c
M       net/ipv4/netfilter/ip_conntrack_proto_tcp.c
M       net/ipv4/netfilter/ip_nat_core.c
M       net/ipv4/netfilter/ip_tables.c
M       net/ipv4/netfilter/ipt_LOG.c
M       net/ipv4/proc.c
M       net/ipv4/route.c
M       net/ipv4/tcp.c
M       net/ipv6/addrconf.c
M       net/ipv6/icmp.c
M       net/ipv6/ip6_output.c
M       net/ipv6/ipv6_sockglue.c
M       net/ipv6/netfilter/ip6_tables.c


Thanks,
   Luben

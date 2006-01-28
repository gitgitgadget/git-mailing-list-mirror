From: Roberto Nibali <ratz@drugphish.ch>
Subject: No merge strategy handled the merge (git version 1.1.GIT)
Date: Sat, 28 Jan 2006 11:53:10 +0100
Message-ID: <43DB4D16.6050807@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 28 11:53:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2nhl-0001Wd-2x
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 11:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWA1KxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 05:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWA1KxO
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 05:53:14 -0500
Received: from drugphish.ch ([69.55.226.176]:55528 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S932079AbWA1KxN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jan 2006 05:53:13 -0500
Received: from [172.23.2.3] (adsl-dyn-83-173-208-107.cybernet.ch [83.173.208.107])
	by www.drugphish.ch (Postfix) with ESMTP id A0A5E406C005
	for <git@vger.kernel.org>; Sat, 28 Jan 2006 11:53:12 +0100 (CET)
User-Agent: Thunderbird 1.5 (X11/20051201)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15195>

Hello,

I've been hacking on some features for IPVS in the Linux kernel recently 
but abandoned work for 3 weeks. Today I wanted to re-sync with Linus to 
work in a more up-to-date tree and simply typed (forgot I had previously 
done work in that tree)

     git-pull

in my local repository tree, which resulted in following:

[...]
ff/df76b725bc7c0ce7db0b123957c21989674aaf
pack/pack-0741dd55e7c560f401c7f37120f3203ad8664bb0.idx
pack/pack-0741dd55e7c560f401c7f37120f3203ad8664bb0.pack

wrote 43124 bytes  read 122278591 bytes  66461.13 bytes/sec
total size is 122060858  speedup is 1.00
* refs/heads/origin: fast forward to branch 'master' of 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with 3ee68c4af3fd7228c1be63254b9f884614f9ebb2
Merging:
03f7e47c28dc1273395112c72ee198e86f2d576d Merge 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
3ee68c4af3fd7228c1be63254b9f884614f9ebb2 [SPARC64]: Use 
compat_sys_futimesat in 32-bit syscall table.
found 1 common ancestor(s):
48ea753075aa15699bd5fac26faa08431aaa697b Merge branch 'release' of 
git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6
Removing arch/sh/boards/hp6xx/hp620/mach.c
Removing arch/ia64/ia32/ia32_ioctl.c
Removing drivers/net/sk98lin/skproc.c
Removing include/asm-arm/arch-epxa10db/timer00.h
Removing arch/powerpc/xmon/start_32.c
Removing arch/arm/mach-integrator/dma.c
Removing drivers/video/aty/xlinit.c
Removing arch/arm/mach-epxa10db/Makefile.boot
Removing scripts/lxdialog/lxdialog.c
Removing include/asm-mips/.gitignore
Removing arch/ppc/platforms/pmac_smp.c
Removing drivers/scsi/sym53c8xx_defs.h
Removing arch/ppc/platforms/pmac_pci.c
Removing arch/sparc64/kernel/ioctl32.c
Removing arch/powerpc/xmon/start_8xx.c
Removing arch/um/include/time_user.h
Removing include/asm-mips/riscos-syscall.h
Removing drivers/char/rio/poll.h
Removing drivers/char/rio/brates.h
Removing scripts/lxdialog/inputbox.c
Removing drivers/char/rio/eisa.h
Removing arch/ppc/boot/openfirmware/coffmain.c
Removing drivers/char/rio/proto.h
Removing drivers/char/rio/riowinif.h
Removing drivers/char/rio/riscos.h
Removing drivers/serial/uart00.c
Removing net/ipv6/netfilter/ip6t_length.c
Removing arch/sh/kernel/cpu/irq_ipr.c
Removing arch/s390/crypto/des_z990.c
Removing scripts/lxdialog/yesno.c
Removing arch/x86_64/boot/compressed/miscsetup.h
Removing net/ipv6/netfilter/ip6t_mark.c
Removing net/ipv6/netfilter/ip6t_NFQUEUE.c
Removing include/asm-arm/arch-epxa10db/io.h
Removing drivers/char/rio/hosthw.h
Removing arch/ppc/platforms/pmac_time.c
Removing net/ipv6/netfilter/ip6t_MARK.c
Removing kernel/crash_dump.c
Removing arch/arm/mach-epxa10db/irq.c
Removing arch/ppc/platforms/pmac_low_i2c.c
Removing drivers/char/rio/cmd.h
Removing drivers/net/arm/ether00.c
Removing arch/mips/kernel/ioctl32.c
Removing arch/um/kernel/skas/mem_user.c
Removing drivers/i2c/busses/i2c-pmac-smu.c
Removing drivers/input/mouse/maplemouse.c
Removing drivers/char/rio/rtahw.h
Removing drivers/char/rio/mca.h
Removing scripts/lxdialog/textbox.c
Auto-merging net/ipv4/ipvs/ip_vs_ctl.c
Traceback (most recent call last):
   File "/home/ratz/bin/git-merge-recursive", line 915, in ?
     firstBranch, secondBranch, graph)
   File "/home/ratz/bin/git-merge-recursive", line 87, in merge
     branch1Name, branch2Name)
   File "/home/ratz/bin/git-merge-recursive", line 160, in mergeTrees
     if not processEntry(entry, branch1Name, branch2Name):
   File "/home/ratz/bin/git-merge-recursive", line 868, in processEntry
     branch1Name, branch2Name)
   File "/home/ratz/bin/git-merge-recursive", line 212, in mergeFile
     src1, orig, src2], returnCode=True)
   File "/home/ratz/share/git-core/python/gitMergeCommon.py", line 72, 
in runProgram
     raise ProgramError(progStr, e.strerror)
ProgramError: merge -L HEAD/net/ipv4/ipvs/ip_vs_ctl.c -L 
orig/net/ipv4/ipvs/ip_vs_ctl.c -L 
3ee68c4af3fd7228c1be63254b9f884614f9ebb2/net/ipv4/ipvs/ip_vs_ctl.c 
.merge_file_uofMwv .merge_file_hcesLs .merge_file_TwtEqw: No such file 
or directory
No merge strategy handled the merge.

I'm all for verbosity when it comes to a problem with software, however 
this output does not tell me much about what I could do to achieve 
following state:

1. Sync my local tree to Linus' tree.
2. Merge my changes I've done locally with the resulting tree of 1.

git-diff shows me 222 unmerged paths, along with my changes:

~> git-diff net/ipv4/ipvs/
* Unmerged path net/ipv4/ipvs/ip_vs_ctl.c
diff --git a/net/ipv4/ipvs/ip_vs_ctl.c b/net/ipv4/ipvs/ip_vs_ctl.c
* Unmerged path net/ipv4/ipvs/ip_vs_lblc.c
diff --git a/net/ipv4/ipvs/ip_vs_lblc.c b/net/ipv4/ipvs/ip_vs_lblc.c
* Unmerged path net/ipv4/ipvs/ip_vs_lblcr.c
diff --git a/net/ipv4/ipvs/ip_vs_lblcr.c b/net/ipv4/ipvs/ip_vs_lblcr.c
* Unmerged path net/ipv4/ipvs/ip_vs_proto_tcp.c
diff --git a/net/ipv4/ipvs/ip_vs_proto_tcp.c 
b/net/ipv4/ipvs/ip_vs_proto_tcp.c

Would it be faster for me to clone the current master again and diff the 
old (master, probably inconsistent) tree to master and merge the changes 
by hand? Of course I can start my work again from scratch, it's only 
been around 200 lines of changes so far ;).

Oh, btw, how is git branch -D supposed to work? Isn't there some code 
missing?

Thanks for any insights,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc

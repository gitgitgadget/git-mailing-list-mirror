From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: Re: git can't find none
Date: Mon, 29 Sep 2008 13:33:53 +0200
Message-ID: <48E0BD21.1040504@cetrtapot.si>
References: <48E0B8FE.6060203@cetrtapot.si>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040201060702040601070405"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 13:36:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkH3P-0008P7-W2
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 13:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbYI2Lf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 07:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbYI2Lf3
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 07:35:29 -0400
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172]:37946 "EHLO
	zimbra-mta.cetrtapot.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbYI2Lf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 07:35:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id DB3E619F9E3
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 13:35:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.27
X-Spam-Level: 
X-Spam-Status: No, score=-4.27 tagged_above=-10 required=5
	tests=[ALL_TRUSTED=-1.8, AWL=0.129, BAYES_00=-2.599]
Received: from zimbra-mta.cetrtapot.si ([127.0.0.1])
	by localhost (zimbra-mta.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NgA8baRnxkYX for <git@vger.kernel.org>;
	Mon, 29 Sep 2008 13:35:21 +0200 (CEST)
Received: from [172.31.65.135] (unknown [192.168.66.2])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 3D19019F9B6
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 13:35:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48E0B8FE.6060203@cetrtapot.si>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97005>

This is a multi-part message in MIME format.
--------------040201060702040601070405
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit

Hinko Kocevar wrote:
> Hi,
> 
> I've recently discovered that some git command stopped working. I'm not sure if this is related to my git tree or not, it happens on other trees too:
> $ git blame Makefile 
> sh: none: command not found
> 
> 'none' ?
> 
> $ git clone ...
> Works fine.
> 
> 
> This is on gentoo using gentoo provided ebuild for git (I even tied reemerging git package with no avail).
> $ git --version
> git version 1.5.6.4
> 

ou,
forgot to attach strace output if anyone can see what is going on.

Thank you,
Hinko

-- 
ÈETRTA POT, d.o.o., Kranj
Planina 3
4000 Kranj
Slovenia, Europe
Tel. +386 (0) 4 280 66 03
E-mail: hinko.kocevar@cetrtapot.si
Http: www.cetrtapot.si


--------------040201060702040601070405
Content-Type: text/plain;
 name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log"

execve("/usr/bin/git", ["git", "status"], [/* 42 vars */]) = 0
brk(0)                                  = 0x814e000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=78249, ...}) = 0
mmap2(NULL, 78249, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f1d000
close(3)                                = 0
open("/usr/lib/libcurl.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\221\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=244612, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f1c000
mmap2(NULL, 243932, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ee0000
mmap2(0xb7f1a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3a) = 0xb7f1a000
close(3)                                = 0
open("/lib/libz.so.1", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\25\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=71064, ...}) = 0
mmap2(NULL, 73976, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ecd000
mmap2(0xb7ede000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10) = 0xb7ede000
close(3)                                = 0
open("/usr/lib/libcrypto.so.0.9.8", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\317\3\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0555, st_size=1294876, ...}) = 0
mmap2(NULL, 1307384, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d8d000
mmap2(0xb7eb4000, 86016, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x127) = 0xb7eb4000
mmap2(0xb7ec9000, 13048, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7ec9000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@a\1\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1237276, ...}) = 0
mmap2(NULL, 1242576, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7c5d000
mmap2(0xb7d87000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12a) = 0xb7d87000
mmap2(0xb7d8a000, 9680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7d8a000
close(3)                                = 0
open("/lib/librt.so.1", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\30\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=30552, ...}) = 0
mmap2(NULL, 33356, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7c54000
mmap2(0xb7c5b000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb7c5b000
close(3)                                = 0
open("/usr/lib/libssl.so.0.9.8", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\305\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0555, st_size=266084, ...}) = 0
mmap2(NULL, 265016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7c13000
mmap2(0xb7c50000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3d) = 0xb7c50000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\n\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=9612, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7c12000
mmap2(NULL, 12412, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7c0e000
mmap2(0xb7c10000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb7c10000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20H\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=118357, ...}) = 0
mmap2(NULL, 90592, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7bf7000
mmap2(0xb7c0a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13) = 0xb7c0a000
mmap2(0xb7c0c000, 4576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7c0c000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7bf6000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7bf68d0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0xb7c0a000, 4096, PROT_READ)   = 0
mprotect(0xb7c10000, 4096, PROT_READ)   = 0
mprotect(0xb7c50000, 4096, PROT_READ)   = 0
mprotect(0xb7c5b000, 4096, PROT_READ)   = 0
mprotect(0xb7d87000, 8192, PROT_READ)   = 0
mprotect(0xb7eb4000, 32768, PROT_READ)  = 0
mprotect(0xb7ede000, 4096, PROT_READ)   = 0
mprotect(0xb7f1a000, 4096, PROT_READ)   = 0
mprotect(0x8106000, 4096, PROT_READ)    = 0
mprotect(0xb7f4b000, 4096, PROT_READ)   = 0
munmap(0xb7f1d000, 78249)               = 0
set_tid_address(0xb7bf6918)             = 30293
set_robust_list(0xb7bf6920, 0xc)        = 0
rt_sigaction(SIGRTMIN, {0xb7bfb310, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xb7bfb390, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
uname({sys="Linux", node="alala", ...}) = 0
brk(0)                                  = 0x814e000
brk(0x816f000)                          = 0x816f000
getcwd("/tmp/sdk", 4096)                = 9
stat64(".git", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
access(".git/objects", X_OK)            = 0
access(".git/refs", X_OK)               = 0
lstat64(".git/HEAD", {st_mode=S_IFREG|0644, st_size=23, ...}) = 0
open(".git/HEAD", O_RDONLY|O_LARGEFILE) = 3
read(3, "ref: refs/heads/master\n", 255) = 23
read(3, "", 232)                        = 0
close(3)                                = 0
access("/etc/gitconfig", R_OK)          = -1 ENOENT (No such file or directory)
stat64(".git", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
access("/home/hinkok/.gitconfig", R_OK) = 0
open("/home/hinkok/.gitconfig", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=155, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f30000
read(3, "[user]\n\temail = hinkocevar@gmail"..., 4096) = 155
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f30000, 4096)                = 0
open(".git/config", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=244, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f30000
read(3, "[core]\n\trepositoryformatversion "..., 4096) = 244
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f30000, 4096)                = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
access("/etc/gitconfig", R_OK)          = -1 ENOENT (No such file or directory)
access("/home/hinkok/.gitconfig", R_OK) = 0
open("/home/hinkok/.gitconfig", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=155, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f30000
read(3, "[user]\n\temail = hinkocevar@gmail"..., 4096) = 155
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f30000, 4096)                = 0
open(".git/config", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=244, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f30000
read(3, "[core]\n\trepositoryformatversion "..., 4096) = 244
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f30000, 4096)                = 0
pipe([3, 4])                            = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb7bf6918) = 30294
dup2(3, 0)                              = 0
close(3)                                = 0
close(4)                                = 0
select(1, [0], NULL, [0], NULL)         = 1 ()
--- SIGCHLD (Child exited) @ 0 (0) ---
execve("/usr/bin/none", ["none"...], [/* 42 vars */]) = -1 ENOENT (No such file or directory)
execve("/home/hinkok/bin/none", ["none"...], [/* 42 vars */]) = -1 ENOENT (No such file or directory)
execve("/work/tools/bin/none", ["none"...], [/* 42 vars */]) = -1 ENOENT (No such file or directory)
execve("/usr/local/bin/none", ["none"...], [/* 42 vars */]) = -1 ENOENT (No such file or directory)
execve("/usr/bin/none", ["none"...], [/* 42 vars */]) = -1 ENOENT (No such file or directory)
execve("/bin/none", ["none"...], [/* 42 vars */]) = -1 ENOENT (No such file or directory)
execve("/opt/bin/none", ["none"...], [/* 42 vars */]) = -1 ENOENT (No such file or directory)
execve("/usr/i486-pc-linux-gnu/gcc-bin/4.1.2/none", ["none"...], [/* 42 vars */]) = -1 ENOENT (No such file or directory)
execve("/usr/i686-pc-linux-gnu/gcc-bin/4.1.2/none", ["none"...], [/* 42 vars */]) = -1 ENOENT (No such file or directory)
execve("/bin/sh", ["sh"..., "-c"..., "none"...], [/* 42 vars */]) = 0
brk(0)                                  = 0x80ed000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=78249, ...}) = 0
mmap2(NULL, 78249, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f14000
close(3)                                = 0
open("/lib/libncurses.so.5", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\364\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=266136, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f13000
mmap2(NULL, 267076, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ed1000
mmap2(0xb7f09000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x38) = 0xb7f09000
mmap2(0xb7f12000, 836, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f12000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\n\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=9612, ...}) = 0
mmap2(NULL, 12412, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ecd000
mmap2(0xb7ecf000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb7ecf000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@a\1\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1237276, ...}) = 0
mmap2(NULL, 1242576, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d9d000
mmap2(0xb7ec7000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12a) = 0xb7ec7000
mmap2(0xb7eca000, 9680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7eca000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7d9c000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7d9c6c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0xb7ec7000, 8192, PROT_READ)   = 0
mprotect(0xb7ecf000, 4096, PROT_READ)   = 0
mprotect(0xb7f09000, 32768, PROT_READ)  = 0
mprotect(0x80e2000, 4096, PROT_READ)    = 0
mprotect(0xb7f42000, 4096, PROT_READ)   = 0
munmap(0xb7f14000, 78249)               = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/dev/tty", O_RDWR|O_NONBLOCK|O_LARGEFILE) = 3
close(3)                                = 0
brk(0)                                  = 0x80ed000
brk(0x810e000)                          = 0x810e000
getuid32()                              = 1000
getgid32()                              = 1000
geteuid32()                             = 1000
getegid32()                             = 1000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
time(NULL)                              = 1222687397
open("/proc/meminfo", O_RDONLY)         = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f27000
read(3, "MemTotal:      4079432 kB\nMemFre"..., 1024) = 754
close(3)                                = 0
munmap(0xb7f27000, 4096)                = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {SIG_IGN}, 8) = 0
rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_IGN}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_IGN}, 8) = 0
uname({sys="Linux", node="alala", ...}) = 0
stat64("/tmp/sdk", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
getpid()                                = 30293
getppid()                               = 30292
stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/usr/bin/sh", 0xbfb429e8)       = -1 ENOENT (No such file or directory)
stat64("/home/hinkok/bin/sh", 0xbfb429e8) = -1 ENOENT (No such file or directory)
stat64("/work/tools/bin/sh", 0xbfb429e8) = -1 ENOENT (No such file or directory)
stat64("/usr/local/bin/sh", 0xbfb429e8) = -1 ENOENT (No such file or directory)
stat64("/usr/bin/sh", 0xbfb429e8)       = -1 ENOENT (No such file or directory)
stat64("/bin/sh", {st_mode=S_IFREG|0755, st_size=651148, ...}) = 0
open("/proc/sys/kernel/ngroups_max", O_RDONLY) = 3
read(3, "65536\n", 31)                  = 6
close(3)                                = 0
mmap2(NULL, 266240, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7d5b000
getgroups32(65536, [7, 10, 14, 18, 19, 27, 80, 85, 100, 411, 1000, 1003]) = 12
stat64("/bin/sh", {st_mode=S_IFREG|0755, st_size=651148, ...}) = 0
getpgrp()                               = 30292
rt_sigaction(SIGCHLD, {0x807b8d5, [], 0}, {SIG_DFL}, 8) = 0
getrlimit(RLIMIT_NPROC, {rlim_cur=38400, rlim_max=38400}) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/usr/bin/none", 0xbfb428c8)     = -1 ENOENT (No such file or directory)
stat64("/home/hinkok/bin/none", 0xbfb428c8) = -1 ENOENT (No such file or directory)
stat64("/work/tools/bin/none", 0xbfb428c8) = -1 ENOENT (No such file or directory)
stat64("/usr/local/bin/none", 0xbfb428c8) = -1 ENOENT (No such file or directory)
stat64("/usr/bin/none", 0xbfb428c8)     = -1 ENOENT (No such file or directory)
stat64("/bin/none", 0xbfb428c8)         = -1 ENOENT (No such file or directory)
stat64("/opt/bin/none", 0xbfb428c8)     = -1 ENOENT (No such file or directory)
stat64("/usr/i486-pc-linux-gnu/gcc-bin/4.1.2/none", 0xbfb428c8) = -1 ENOENT (No such file or directory)
stat64("/usr/i686-pc-linux-gnu/gcc-bin/4.1.2/none", 0xbfb428c8) = -1 ENOENT (No such file or directory)
rt_sigaction(SIGINT, {SIG_IGN}, {SIG_IGN}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_IGN}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {0x807b8d5, [], 0}, 8) = 0
fstat64(2, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 3), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f27000
write(2, "sh: none: command not found\n", 28) = 28
exit_group(127)                         = ?

--------------040201060702040601070405--

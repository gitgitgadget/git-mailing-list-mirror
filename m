From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: Re: git add / update-cache --add fails.
Date: Tue, 26 Apr 2005 07:26:04 +0100
Message-ID: <200504260726.04908.rhys@rhyshardwick.co.uk>
References: <200504252226.00354.rhys@rhyshardwick.co.uk> <200504252252.05957.rhys@rhyshardwick.co.uk> <Pine.LNX.4.58.0504251741430.18901@ppc970.osdl.org>
Reply-To: rhys@rhyshardwick.co.uk
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 26 08:21:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQJRo-0005J6-6k
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 08:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVDZG0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 02:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVDZG0e
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 02:26:34 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:54626 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261343AbVDZG0H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 02:26:07 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp004.mail.ukl.yahoo.com with SMTP; 26 Apr 2005 06:26:05 -0000
Received: from [192.168.1.40] (helo=metatron.rhyshardwick.co.uk)
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1DQJWH-0004aM-Dn
	for git@vger.kernel.org; Tue, 26 Apr 2005 07:26:05 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <Pine.LNX.4.58.0504251741430.18901@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

That may be true!  I changed to linux full time only about 8 months ago, but 
haven't looked back.

Ok strace gave me:

=====

rhys@metatron:~/repo/learning.repo$ strace update-cache --add w1d4p1.c
execve("/home/rhys/bin/update-cache", ["update-cache", "--add", "w1d4p1.c"], 
[/*
 37 vars */]) = 0
uname({sys="Linux", node="metatron", ...}) = 0
brk(0)                                  = 0x8050000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0
xb7fe9000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=78204, ...}) = 0
old_mmap(NULL, 78204, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fd5000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/usr/lib/libz.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\27"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0644, st_size=67468, ...}) = 0
old_mmap(NULL, 70528, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7fc3000
old_mmap(0xb7fd4000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x100
00) = 0xb7fd4000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/usr/lib/i686/cmov/libssl.so.0.9.7", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\205\0"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0644, st_size=198576, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0
xb7fc2000
old_mmap(NULL, 199344, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7f91000
old_mmap(0xb7fbf000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x2e
000) = 0xb7fbf000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`Z\1\000"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1254468, ...}) = 0
old_mmap(NULL, 1264780, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7e5c000
old_mmap(0xb7f86000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x12
9000) = 0xb7f86000
old_mmap(0xb7f8f000, 7308, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONY
MOUS, -1, 0) = 0xb7f8f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/usr/lib/i686/cmov/libcrypto.so.0.9.7", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\300\2"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1029672, ...}) = 0
old_mmap(NULL, 1043608, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7d5d000
old_mmap(0xb7e47000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0xea
000) = 0xb7e47000
old_mmap(0xb7e59000, 11416, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANON
YMOUS, -1, 0) = 0xb7e59000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/tls/libdl.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\32"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0644, st_size=9872, ...}) = 0
old_mmap(NULL, 8632, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7d5a000
old_mmap(0xb7d5c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x200
0) = 0xb7d5c000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0xb7d59000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7d592a0, limit:1048575, 
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, 
seg_not_present:0, useable:1}) = 0
munmap(0xb7fd5000, 78204)               = 0
open(".git/index.lock", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
access(".git/objects", X_OK)            = 0
open(".git/index", O_RDONLY)            = 4
fstat64(4, {st_mode=S_IFREG|0600, st_size=176, ...}) = 0
mmap2(NULL, 176, PROT_READ, MAP_PRIVATE, 4, 0) = 0xb7fe8000
close(4)                                = 0
brk(0)                                  = 0x8050000
brk(0x8071000)                          = 0x8071000
brk(0)                                  = 0x8071000
open("w1d4p1.c", O_RDONLY)              = -1 ENOENT (No such file or 
directory)
write(2, "fatal: ", 7fatal: )                  = 7
write(2, "Unable to add w1d4p1.c to databa"..., 34Unable to add w1d4p1.c to 
database) = 34
write(2, "\n", 1
)                       = 1
unlink(".git/index.lock")               = 0
exit_group(1)                           = ?

====

ltrace update-cache --add xxxx gave

====

rhys@metatron:~/repo/learning.repo$ ltrace update-cache --add w1d4p1.c
__libc_start_main(0x8049680, 3, 0xbffff854, 0x804ad60, 0x804adc0 
<unfinished ...>
getenv("GIT_INDEX_FILE")                                                = NULL
snprintf(".git/index.lock", 4097, "%s.lock", ".git/index")              = 15
open(".git/index.lock", 194, 0600)                                      = 3
__cxa_atexit(0x8049660, 0, 0, 0xb7f8de80, 0xbffff7c8)                   = 0
__errno_location()                                                      = 
0xb7d59280
getenv("SHA1_FILE_DIRECTORY")                                           = NULL
access(".git/objects", 1)                                               = 0
getenv("GIT_INDEX_FILE")                                                = NULL
open(".git/index", 0, 026777021220)                                     = 4
__fxstat(3, 4, 0xbffff710)                                              = 0
__errno_location()                                                      = 
0xb7d59280
mmap(0, 176, 1, 2, 4)                                                   = 
0xb7fe8000
close(4)                                                                = 0
SHA1_Init(0xbffff660, 0xb7e67bc8, 0xb7fc2290, 0x804870e, 96)            = 1
SHA1_Update(0xbffff660, 0xb7fe8000, 156, 0x804870e, 96)                 = 1
SHA1_Final(0xbffff640, 0xbffff660, 156, 0x804870e, 96)                  = 1
calloc(27, 4)                                                           = 
0x8050008
open("w1d4p1.c", 0, 044653)                                             = -1
__errno_location()                                                      = 
0xb7d59280
fputs("fatal: ", 0xb7f86f60fatal: )                                            
= 1
vfprintf(0xb7f86f60, "Unable to add %s to database", 0xbffff794Unable to add 
w1d4p1.c to database)        = 34
fputc('\n', 0xb7f86f60
)                                                 = 10
exit(1 <unfinished ...>
unlink(".git/index.lock")                                               = 0
+++ exited (status 1) +++

====

More information:  this seems to be happening with all my local repositories.  
I can remove files from the cache, and commit fine, but not add files.


Rhys

On Tuesday 26 Apr 2005 01:47, Linus Torvalds wrote:



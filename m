Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD7DDA8
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585397; cv=pass; b=hOQkqQySpKAjTnhFi9pArdmA6ztRqbB0Ndo7U2MAR1ABew7rWPCJ7TSkSJe7xqLCgfr0g5AroYtRok/YTv9jvvAvk6MUymP4lEUOsxnAMfOtmwtgio1s7mPExLXatV2foszN9TVdSBikgL7pHb/CrPAiQJ3ti81lERYoOXr4t44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585397; c=relaxed/simple;
	bh=18RvoCVs8msYiHkGyqIPYxKxz47zPoB6pKJcjwD3Yf0=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=XGnP+vuP2FXIObsL9ffna6PcOHTD/lE51ySQsZGV61iEEEFulHxtA/hsLs1Ael3ptwyvBLvWJTIXRJOFl/U0HjCWO37bKDq6cPcFhFLEFmsiqxWEoV/wVROlb0ZFb0i+Oczx6er4AlCtDSaT0lkOWxKadfDrYKzJ6nwvwP+meNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AE1FD23829
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 02:09:48 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-3.trex.outbound.svc.cluster.local [100.105.38.254])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2142E231F8
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 02:09:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739585388; a=rsa-sha256;
	cv=none;
	b=iCTCo4Ek7eSQ3zhLu3mUArg/pg1kH2vHlB//kjuuez2o2DRG5XIsv/JH0RzAT4DOq5ZHaP
	uDm+13iQwUVg/FXDy8s1UdtoLVhAA8VcXxM7bEyyzmbsr7olkNAVHAzkrAR2vCzoJT8pUj
	PbsVgVsVO1dQsG8thCPsyjhORHPF+2/Msg8zFQMkLVMERUSKp2RaLRt3GI17HRq64bRbX+
	vtcIay/j7IrRDSXM9hEKbdfU881wBaYAsq0Efn8remoSNYt2ShSXxjhzWpx2xLUWmmnB1d
	BZbsztE7FPreZS7Upo9tyzdkVDJYqyrGVAN/JRlJdX1WRdUx5xIqIQdpxeVr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739585388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Vl7LPRNo+En1rkNcRo9jKV+qK5e70cmQNVrBAJkU4U=;
	b=GZgJVzlKOg280LaDmSnwTuAh8JcDRwu7AsHhKMEYRHm0fnzyNPJkUq6NzEzmwJBb7trx0Y
	1hwgAagFf5Xhy5+mZYPmGYSoFe9UsHsh7wB38dN/e0rgQyuwm68+yOCC4KX1uvsDn32Kcw
	VvQ+RX0w37NmbU2YYtyee1/DCSX5m1UHdYFkHhxyJQV/+9pBRaN5etK9CmZdF0cb4F3UF0
	C1E1DIRF1RQwrbq4jbc1RlExtRCcSFTWoQAYEGWjqToAf8VGoBUmPj76B5L6pM6nAttKlV
	KD9Qw09E/FUATFRcWw2SG4JCGWtzvdMvij+NpPg3deq0v13JXucYvBnX3wZeSA==
ARC-Authentication-Results: i=1;
	rspamd-5dd9985cb-nzx7s;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Madly-Skirt: 6e73c01721370823_1739585388618_858847466
X-MC-Loop-Signature: 1739585388618:2498075457
X-MC-Ingress-Time: 1739585388618
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.38.254 (trex/7.0.2);
	Sat, 15 Feb 2025 02:09:48 +0000
Received: from p57b04755.dip0.t-ipconnect.de ([87.176.71.85]:62340 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <calestyo@scientia.org>)
	id 1tj7cr-00000007O0y-43f1
	for git@vger.kernel.org;
	Sat, 15 Feb 2025 02:09:46 +0000
Message-ID: <1480fc360e9afd4e2d381e1506624df058355ae6.camel@scientia.org>
Subject: free(): invalid pointer, error: git died of signal 6 and error: git
 died of signal 11
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: git@vger.kernel.org
Date: Sat, 15 Feb 2025 03:09:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.55.2-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.

I see some weird segfaults on a fresh repo.
It has just one commit with license files, then branch from master in
which I have a staged an initial skeleton program.

From there when I do a
  git dt
(which is an alias `dt =3D difftool --dir-diff`) I get most of the time:

$ git dt
error: git died of signal 11

with kernel log:
Feb 15 02:52:43 heisenberg kernel: git[633078]: segfault at 557a50000000 ip=
 00007faddc054435 sp 00007ffcd3acc600 error 4 in libc.so.6[a2435,7faddbfda0=
00+165000] likely on CPU 0 (core 0, socket 0)
Feb 15 02:52:43 heisenberg kernel: Code: 56 14 00 a8 04 74 26 48 8b 15 97 4=
d 14 00 48 8d 04 95 00 00 00 00 48 f7 d8 48 85 d2 48 c7 c2 00 00 00 fc 48 0=
f 44 c2 48 21 f0 <48> 8b 38 31 d2 e8 a1 d5 ff ff 64 89 2b 48 83 c4 18 5b 5d=
 c3 0f 1f

and when creating a core dump of that and looking at it with gdb:
$ gdb /usr/lib/git-core/git core.633078=20
GNU gdb (Debian 16.2-1) 16.2
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from /usr/lib/git-core/git...
Reading symbols from /usr/lib/debug/.build-id/21/a30636041d46556cf064a7ea3e=
3a744c89bee2.debug...
[New LWP 633078]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
Core was generated by `/usr/lib/git-core/git difftool --dir-diff'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x00007faddc054435 in arena_for_chunk (ptr=3D0x557a509f69cc) at ./mallo=
c/arena.c:153

warning: 153	./malloc/arena.c: No such file or directory
(gdb) bt
#0  0x00007faddc054435 in arena_for_chunk (ptr=3D0x557a509f69cc) at ./mallo=
c/arena.c:153
#1  arena_for_chunk (ptr=3D0x557a509f69cc) at ./malloc/arena.c:151
#2  __GI___libc_free (mem=3D<optimized out>) at ./malloc/malloc.c:3397
#3  0x0000557a508a5e9b in free_individual_entries (map=3Dmap@entry=3D0x7ffc=
d3acc920, entry_offset=3D0) at ./hashmap.c:188
#4  0x0000557a508a61c8 in hashmap_clear_ (map=3Dmap@entry=3D0x7ffcd3acc920,=
 entry_offset=3Dentry_offset@entry=3D0) at ./hashmap.c:207
#5  0x0000557a5076161b in run_dir_diff (extcmd=3D0x0, symlinks=3D1, prefix=
=3D<optimized out>, child=3D0x7ffcd3acc980) at builtin/difftool.c:666
#6  cmd_difftool (argc=3D<optimized out>, argv=3D<optimized out>, prefix=3D=
<optimized out>, repo=3D<optimized out>) at builtin/difftool.c:801
#7  0x0000557a50724593 in run_builtin (p=3D0x557a50acdb50 <commands+912>, a=
rgc=3D2, argv=3D0x7ffcd3acd630, repo=3D0x557a50affec0 <the_repo>) at ./git.=
c:483
#8  handle_builtin (argc=3D2, argv=3D0x7ffcd3acd630) at ./git.c:749
#9  0x0000557a50725515 in run_argv (argcp=3Dargcp@entry=3D0x7ffcd3acd40c, a=
rgv=3Dargv@entry=3D0x7ffcd3acd400) at ./git.c:819
#10 0x0000557a50726088 in cmd_main (argc=3D<optimized out>, argc@entry=3D3,=
 argv=3D<optimized out>, argv@entry=3D0x7ffcd3acd628) at ./git.c:954
#11 0x0000557a50724209 in main (argc=3D3, argv=3D0x7ffcd3acd628) at ./commo=
n-main.c:64
(gdb)=20



Once I also got:
$ git dt
free(): invalid pointer
error: git died of signal 6

with no kernel message and I think the following was the corresponding
core dump:
$ gdb /usr/lib/git-core/git core.633069=20
GNU gdb (Debian 16.2-1) 16.2
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from /usr/lib/git-core/git...
Reading symbols from /usr/lib/debug/.build-id/21/a30636041d46556cf064a7ea3e=
3a744c89bee2.debug...
[New LWP 633069]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
Core was generated by `/usr/lib/git-core/git difftool --dir-diff'.
Program terminated with signal SIGABRT, Aborted.
#0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsign=
o@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44

warning: 44	./nptl/pthread_kill.c: No such file or directory
(gdb) bt
#0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsign=
o@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
#1  0x00007fb22ef18e2f in __pthread_kill_internal (threadid=3D<optimized ou=
t>, signo=3D6) at ./nptl/pthread_kill.c:78
#2  0x00007fb22eec4d02 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/po=
six/raise.c:26
#3  0x00007fb22eead4f0 in __GI_abort () at ./stdlib/abort.c:79
#4  0x00007fb22eeae32d in __libc_message_impl (fmt=3Dfmt@entry=3D0x7fb22f03=
0303 "%s\n") at ../sysdeps/posix/libc_fatal.c:134
#5  0x00007fb22ef22965 in malloc_printerr (str=3Dstr@entry=3D0x7fb22f02e082=
 "free(): invalid pointer") at ./malloc/malloc.c:5772
#6  0x00007fb22ef24bf4 in _int_free (av=3D0x34fbb8158b0200, p=3D<optimized =
out>, have_lock=3Dhave_lock@entry=3D0) at ./malloc/malloc.c:4507
#7  0x00007fb22ef2743f in __GI___libc_free (mem=3D<optimized out>) at ./mal=
loc/malloc.c:3398
#8  0x000055b4e4106e9b in free_individual_entries (map=3Dmap@entry=3D0x7ffe=
e0e35a30, entry_offset=3D0) at ./hashmap.c:188
#9  0x000055b4e41071c8 in hashmap_clear_ (map=3Dmap@entry=3D0x7ffee0e35a30,=
 entry_offset=3Dentry_offset@entry=3D0) at ./hashmap.c:207
#10 0x000055b4e3fc261b in run_dir_diff (extcmd=3D0x0, symlinks=3D1, prefix=
=3D<optimized out>, child=3D0x7ffee0e35a90) at builtin/difftool.c:666
#11 cmd_difftool (argc=3D<optimized out>, argv=3D<optimized out>, prefix=3D=
<optimized out>, repo=3D<optimized out>) at builtin/difftool.c:801
#12 0x000055b4e3f85593 in run_builtin (p=3D0x55b4e432eb50 <commands+912>, a=
rgc=3D2, argv=3D0x7ffee0e36740, repo=3D0x55b4e4360ec0 <the_repo>) at ./git.=
c:483
#13 handle_builtin (argc=3D2, argv=3D0x7ffee0e36740) at ./git.c:749
#14 0x000055b4e3f86515 in run_argv (argcp=3Dargcp@entry=3D0x7ffee0e3651c, a=
rgv=3Dargv@entry=3D0x7ffee0e36510) at ./git.c:819
#15 0x000055b4e3f87088 in cmd_main (argc=3D<optimized out>, argc@entry=3D3,=
 argv=3D<optimized out>, argv@entry=3D0x7ffee0e36738) at ./git.c:954
#16 0x000055b4e3f85209 in main (argc=3D3, argv=3D0x7ffee0e36738) at ./commo=
n-main.c:64
(gdb)=20


The same happens also on a fresh and empty repo:
$ git init foo; cd foo
$ gdb --args git difftool --dir-diff
GNU gdb (Debian 16.2-1) 16.2
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from git...
Reading symbols from /usr/lib/debug/.build-id/21/a30636041d46556cf064a7ea3e=
3a744c89bee2.debug...
(gdb) run
Starting program: /usr/bin/git difftool --dir-diff
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[Detaching after fork from child process 635588]

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7d7c435 in arena_for_chunk (ptr=3D0x5555558489cc) at ./malloc/ar=
ena.c:153
warning: 153	./malloc/arena.c: No such file or directory
(gdb) bt
#0  0x00007ffff7d7c435 in arena_for_chunk (ptr=3D0x5555558489cc) at ./mallo=
c/arena.c:153
#1  arena_for_chunk (ptr=3D0x5555558489cc) at ./malloc/arena.c:151
#2  __GI___libc_free (mem=3D<optimized out>) at ./malloc/malloc.c:3397
#3  0x00005555556f7e9b in free_individual_entries (map=3Dmap@entry=3D0x7fff=
ffffd220, entry_offset=3D0) at ./hashmap.c:188
#4  0x00005555556f81c8 in hashmap_clear_ (map=3Dmap@entry=3D0x7fffffffd220,=
 entry_offset=3Dentry_offset@entry=3D0) at ./hashmap.c:207
#5  0x00005555555b361b in run_dir_diff (extcmd=3D0x0, symlinks=3D1, prefix=
=3D<optimized out>, child=3D0x7fffffffd280) at builtin/difftool.c:666
#6  cmd_difftool (argc=3D<optimized out>, argv=3D<optimized out>, prefix=3D=
<optimized out>, repo=3D<optimized out>) at builtin/difftool.c:801
#7  0x0000555555576593 in run_builtin (p=3D0x55555591fb50 <commands+912>, a=
rgc=3D2, argv=3D0x7fffffffdf30, repo=3D0x555555951ec0 <the_repo>) at ./git.=
c:483
#8  handle_builtin (argc=3D2, argv=3D0x7fffffffdf30) at ./git.c:749
#9  0x0000555555577515 in run_argv (argcp=3Dargcp@entry=3D0x7fffffffdd0c, a=
rgv=3Dargv@entry=3D0x7fffffffdd00) at ./git.c:819
#10 0x0000555555578088 in cmd_main (argc=3D<optimized out>, argc@entry=3D3,=
 argv=3D<optimized out>, argv@entry=3D0x7fffffffdf28) at ./git.c:954
#11 0x0000555555576209 in main (argc=3D3, argv=3D0x7fffffffdf28) at ./commo=
n-main.c:64
(gdb) quit
A debugging session is active.

	Inferior 1 [process 635585] will be killed.

Quit anyway? (y or n) quit
EOF [assumed Y]
calestyo@heisenberg:~/xx/foo$ l
total 0
drwxr-xr-x 1 calestyo calestyo  8 Feb 15 02:58 .
drwxr-xr-x 1 calestyo calestyo 12 Feb 15 02:59 ..
drwxr-xr-x 1 calestyo calestyo 98 Feb 15 02:58 .git
calestyo@heisenberg:~/xx/foo$=20
calestyo@heisenberg:~/xx/foo$=20
calestyo@heisenberg:~/xx/foo$=20
calestyo@heisenberg:~/xx/foo$=20
calestyo@heisenberg:~/xx/foo$=20
calestyo@heisenberg:~/xx/foo$=20
calestyo@heisenberg:~/xx/foo$ gdb --args git difftool --dir-diff
GNU gdb (Debian 16.2-1) 16.2
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from git...
Reading symbols from /usr/lib/debug/.build-id/21/a30636041d46556cf064a7ea3e=
3a744c89bee2.debug...
(gdb)=20

looking slightly different, and I can directly get the backtrace
without the coredump (presumably the alias handling get's otherwise in
the way with this?).


That's all on Debian unstable, with their git package 1:2.47.2-0.1.


Cheers,
Chris.

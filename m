Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D660820286
	for <e@80x24.org>; Wed, 13 Sep 2017 14:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdIMOtt (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 10:49:49 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:43709 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdIMOtr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 10:49:47 -0400
Received: by mail-io0-f174.google.com with SMTP id k101so2618948iod.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ln1p7A0AdWD4VpITK0IdLXuz/vjf6E5/WW7Y5DgsRoM=;
        b=UyJ6baa3WSWWJioWRunnprQ9cthUfuOXRxxb2nf39YzAnYajnKakdTA9bSa0ZH1OZH
         Ug1t1GBdP6Qn3eRpxqho/Z1Uizv+HyJsjH+ox2FO5gTXYO1SAsQaMZ/18oVe6RW/d1Eb
         YFIwg8elnC+AbVA22LzhEH3C8g8MnBMp5mUcGeru7sYw7GXu4VDCOPmWONKKES9VL4tL
         9TB9s+VfwsT2rT0v2zMvv0Z4kCmbOdRT1StUBQemQ30MUEW3Cu1+/LXhBxeQsWpA15Jk
         JJddLKbiSfmcZl+pm1HRt5f0ktNEgo3mRc2f2rtyiWs7I5A0cKpPUy7iLr2xDDOlK1aN
         GggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ln1p7A0AdWD4VpITK0IdLXuz/vjf6E5/WW7Y5DgsRoM=;
        b=TsrJjyh7Uiuu1hw4yPcEB4F27vtWTV1Oh6VwWgjOfhJQdKCSYTwJupH/rrInM7Cd7e
         G7Dxvoq7TGv9j3MS3JqQ71UspqXOT/EsEHlYj0ZJGYS8P3/vnKA8xPp4gF758A+3mtl5
         Nw8eYfQtsWMYkrnyc+oVTkqqYBqsVbLr31FUlfaO/bXTU28eRYloNT9JZ+tPrr+ZFL2d
         zm2BBJwlfpPXkK0kcNUw20aH7UEr9cmaPtqKfBIPAr2qpF16nnEObSktbJ8g9rx5w8p3
         Km07QGf+RhPdENUcOxLYZF8otY3G7AbpKxZ5N0qZqIxd6LUwd9ibIk81zUOHpRnesxZs
         PxZg==
X-Gm-Message-State: AHPjjUiNz4I/FSTiblV4Pg/Dc65c1MQV7PQb/QUhxR8AJqhExaBskbGE
        ffXDBGhfk8OiGbI+VucTzktqg7sFCFO3dLBqSLk=
X-Google-Smtp-Source: AOwi7QDiGOXOzsIPaC3T6VHEs3tuYESXHi+8sGRXKj5SLCLO35ReSCXtLoPgN+7BNHI3YrkW8p2yzHTA6vg0UEaDEnQ=
X-Received: by 10.107.82.14 with SMTP id g14mr15876646iob.137.1505314186240;
 Wed, 13 Sep 2017 07:49:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.4 with HTTP; Wed, 13 Sep 2017 07:49:45 -0700 (PDT)
In-Reply-To: <20170913141739.mkmiaud2eemgnbbh@sigill.intra.peff.net>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
 <20170913123420.die3thfcpaweakce@sigill.intra.peff.net> <CANgJU+U3Vzmmag9fpFGf7sx4Sq4S9qjLc5bnR4e+U0C3aaQXJA@mail.gmail.com>
 <20170913141739.mkmiaud2eemgnbbh@sigill.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 13 Sep 2017 16:49:45 +0200
Message-ID: <CANgJU+WHr2-FjAUUKQ8pUkniczcxrr11dTo_zBeXdTi_su2oUA@mail.gmail.com>
Subject: Re: Bug: git branch --unset-upstream command can nuke config when
 disk is full.
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 September 2017 at 16:17, Jeff King <peff@peff.net> wrote:
> You're welcome to read over the function to double-check, but I just
> looked it over and couldn't find any unchecked writes.

I can look, but I doubt I would notice something you did not.

On the other hand the strace output does show that this is a case
where the writes failed, but we still renamed the empty config.lock
file into place:


write(3, "[core]\n\tsharedRepository = true\n"..., 288) = -1 ENOSPC
(No space left on device)
write(3, "        merge = refs/heads/yves/"..., 51) = -1 ENOSPC (No
space left on device)
munmap(0x7f48d9b8c000, 363)             = 0
close(3)                                = 0
rename("/usr/local/git_tree/main/.git/config.lock",
"/usr/local/git_tree/main/.git/config") = 0

Full strace is below:

>> > Given that your output is consistent with it failing to find the key,
>> > and that the result is an empty file, it sounds like somehow the mmap'd
>> > input appeared empty (but neither open nor fstat nor mmap returned an
>> > error). You're not on any kind of exotic filesystem, are you?
>>
>> I don't think so, but I don't know. Is there a command I can run to check?

I freed up space and things worked, so I somehow doubt the filesystem
is at fault. When I then filled up the disk and retried the error was
repeatable.

>> BTW, with a bit of faffing I can probably recreate this problem.
>> Should I try? Is there something I could do during recreation that
>> would help?
>
> If you think you can reproduce, the output of "strace" on a failing
> invocation would be very interesting.

I can reproduce, see below. Preceded and suffixed by ls on the .git/config file.

I have munged the branch name for privacy reasons, hope that doesn't
invalidate the strace utility.

cheers,
yves

$ ls -la .git/config
-rw-rw-r-- 1 root users 363 Sep 13 16:36 .git/config
$ strace git branch --unset-upstream
execve("/usr/bin/git", ["git", "branch", "--unset-upstream"], [/* 39
vars */]) = 0
brk(0)                                  = 0x222c000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b94000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=50300, ...}) = 0
mmap(NULL, 50300, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f48d9b87000
close(3)                                = 0
open("/lib64/libpcre.so.0", O_RDONLY)   = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@\25\0\0\0\0\0\0"...,
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=183080, ...}) = 0
mmap(NULL, 2278264, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7f48d9748000
mprotect(0x7f48d9774000, 2097152, PROT_NONE) = 0
mmap(0x7f48d9974000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2c000) = 0x7f48d9974000
close(3)                                = 0
open("/lib64/libz.so.1", O_RDONLY)      = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0
!\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=88600, ...}) = 0
mmap(NULL, 2183696, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7f48d9532000
mprotect(0x7f48d9547000, 2093056, PROT_NONE) = 0
mmap(0x7f48d9746000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0x7f48d9746000
close(3)                                = 0
open("/lib64/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000^\0\0\0\0\0\0"...,
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=143280, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b86000
mmap(NULL, 2212848, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7f48d9315000
mprotect(0x7f48d932c000, 2097152, PROT_NONE) = 0
mmap(0x7f48d952c000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17000) = 0x7f48d952c000
mmap(0x7f48d952e000, 13296, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f48d952e000
close(3)                                = 0
open("/lib64/librt.so.1", O_RDONLY)     = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\240!\0\0\0\0\0\0"...,
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=44472, ...}) = 0
mmap(NULL, 2128816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7f48d910d000
mprotect(0x7f48d9114000, 2093056, PROT_NONE) = 0
mmap(0x7f48d9313000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0x7f48d9313000
close(3)                                = 0
open("/lib64/libc.so.6", O_RDONLY)      = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0000\356\1\0\0\0\0\0"...,
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1924768, ...}) = 0
mmap(NULL, 3750184, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7f48d8d79000
mprotect(0x7f48d8f03000, 2097152, PROT_NONE) = 0
mmap(0x7f48d9103000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x18a000) = 0x7f48d9103000
mmap(0x7f48d9109000, 14632, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f48d9109000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b85000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b84000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b83000
arch_prctl(ARCH_SET_FS, 0x7f48d9b84700) = 0
mprotect(0x7f48d9103000, 16384, PROT_READ) = 0
mprotect(0x7f48d9313000, 4096, PROT_READ) = 0
mprotect(0x7f48d952c000, 4096, PROT_READ) = 0
mprotect(0x7f48d9746000, 4096, PROT_READ) = 0
mprotect(0x7f48d9b95000, 4096, PROT_READ) = 0
munmap(0x7f48d9b87000, 50300)           = 0
set_tid_address(0x7f48d9b849d0)         = 50373
set_robust_list(0x7f48d9b849e0, 24)     = 0
futex(0x7fff059e43bc, FUTEX_WAKE_PRIVATE, 1) = 0
futex(0x7fff059e43bc, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME,
1, NULL, 7f48d9b84700) = -1 EAGAIN (Resource temporarily unavailable)
rt_sigaction(SIGRTMIN, {0x7f48d931acb0, [], SA_RESTORER|SA_SIGINFO,
0x7f48d93247e0}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x7f48d931ad40, [],
SA_RESTORER|SA_RESTART|SA_SIGINFO, 0x7f48d93247e0}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=10240*1024, rlim_max=RLIM64_INFINITY}) = 0
open("/dev/null", O_RDWR)               = 3
close(3)                                = 0
brk(0)                                  = 0x222c000
brk(0x224d000)                          = 0x224d000
open("/usr/lib/locale/locale-archive", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=99170352, ...}) = 0
mmap(NULL, 99170352, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f48d2ee5000
close(3)                                = 0
open("/usr/lib64/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=26060, ...}) = 0
mmap(NULL, 26060, PROT_READ, MAP_SHARED, 3, 0) = 0x7f48d9b8d000
close(3)                                = 0
futex(0x7f48d9108828, FUTEX_WAKE_PRIVATE, 2147483647) = 0
rt_sigprocmask(SIG_UNBLOCK, [PIPE], NULL, 8) = 0
rt_sigaction(SIGPIPE, {SIG_DFL, [PIPE], SA_RESTORER|SA_RESTART,
0x7f48d8dab510}, {SIG_DFL, [], 0}, 8) = 0
getcwd("/usr/local/git_tree/main", 129) = 25
stat("/usr/local/git_tree/main", {st_mode=S_IFDIR|S_ISGID|0775,
st_size=4096, ...}) = 0
stat("/usr/local/git_tree/main/.git", {st_mode=S_IFDIR|S_ISGID|0775,
st_size=4096, ...}) = 0
lstat("/usr/local/git_tree/main/.git/HEAD", {st_mode=S_IFREG|0664,
st_size=39, ...}) = 0
open("/usr/local/git_tree/main/.git/HEAD", O_RDONLY) = 3
read(3, "ref: refs/heads/yves/simple_proj"..., 255) = 39
read(3, "", 216)                        = 0
close(3)                                = 0
lstat("/usr/local/git_tree/main/.git/commondir", 0x7fff059e3ec0) = -1
ENOENT (No such file or directory)
access("/usr/local/git_tree/main/.git/objects", X_OK) = 0
access("/usr/local/git_tree/main/.git/refs", X_OK) = 0
lstat(".git/commondir", 0x7fff059e3ef0) = -1 ENOENT (No such file or directory)
open(".git/config", O_RDONLY)           = 3
fstat(3, {st_mode=S_IFREG|0664, st_size=363, ...}) = 0
fstat(3, {st_mode=S_IFREG|0664, st_size=363, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(3, "[core]\n\tsharedRepository = true\n"..., 4096) = 363
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
getcwd("/usr/local/git_tree/main", 129) = 25
stat(".git", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
lstat(".git/commondir", 0x7fff059e3f50) = -1 ENOENT (No such file or directory)
access("/etc/gitconfig", R_OK)          = 0
open("/etc/gitconfig", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=1353, ...}) = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=1353, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(3, "################################"..., 4096) = 1353
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
access("/home/yorton/.config/git/config", R_OK) = -1 ENOENT (No such
file or directory)
access("/home/yorton/.gitconfig", R_OK) = 0
open("/home/yorton/.gitconfig", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=377, ...}) = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=377, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(3, "[alias]\n\thist = log --graph --co"..., 4096) = 377
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
access(".git/config", R_OK)             = 0
open(".git/config", O_RDONLY)           = 3
fstat(3, {st_mode=S_IFREG|0664, st_size=363, ...}) = 0
fstat(3, {st_mode=S_IFREG|0664, st_size=363, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(3, "[core]\n\tsharedRepository = true\n"..., 4096) = 363
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2512, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2512
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
open("/usr/share/locale/en_CA.utf8/LC_MESSAGES/git.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en_CA/LC_MESSAGES/git.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/git.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/git.mo", O_RDONLY) = -1 ENOENT
(No such file or directory)
access("/etc/gitconfig", R_OK)          = 0
open("/etc/gitconfig", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=1353, ...}) = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=1353, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(3, "################################"..., 4096) = 1353
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
access("/home/yorton/.config/git/config", R_OK) = -1 ENOENT (No such
file or directory)
access("/home/yorton/.gitconfig", R_OK) = 0
open("/home/yorton/.gitconfig", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=377, ...}) = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=377, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(3, "[alias]\n\thist = log --graph --co"..., 4096) = 377
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
access(".git/config", R_OK)             = 0
open(".git/config", O_RDONLY)           = 3
fstat(3, {st_mode=S_IFREG|0664, st_size=363, ...}) = 0
fstat(3, {st_mode=S_IFREG|0664, st_size=363, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(3, "[core]\n\tsharedRepository = true\n"..., 4096) = 363
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
lstat(".git/commondir", 0x7fff059e3590) = -1 ENOENT (No such file or directory)
lstat(".git/HEAD", {st_mode=S_IFREG|0664, st_size=39, ...}) = 0
open(".git/HEAD", O_RDONLY)             = 3
read(3, "ref: refs/heads/yves/xxx"..., 256) = 39
read(3, "", 217)                        = 0
close(3)                                = 0
lstat(".git/refs/heads/yves/xxx", 0x7fff059e3580) = -1 ENOENT (No such
file or directory)
open(".git/packed-refs", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0664, st_size=231354, ...}) = 0
fstat(3, {st_mode=S_IFREG|0664, st_size=231354, ...}) = 0
fstat(3, {st_mode=S_IFREG|0664, st_size=231354, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(3, "# pack-refs with: peeled fully-p"..., 4096) = 4096
read(3, "1a5c122f68f04fae374ac3cdf11\n14e0"..., 4096) = 4096
read(3, "b16f20dde39f97ef2869296\nba29d061"..., 4096) = 4096
read(3, "6-141414\n^29ba731b77bb5f5c15644d"..., 4096) = 4096
read(3, "df2d5e\n3cd1ca6cffc2ce48ecc09c0c1"..., 4096) = 4096
read(3, "fd414d360b4d742e8711fe8093a09fa "..., 4096) = 4096
read(3, "pit-20170511-164552\n^cb28295c135"..., 4096) = 4096
read(3, "4a4cb2cf8620771feb\n41b2f890ea48b"..., 4096) = 4096
read(3, "\n^9827bb20ed16ec66dd510d72d779c6"..., 4096) = 4096
read(3, "-160507\n^56472ff6a42c58dee27d337"..., 4096) = 4096
read(3, "0d01a69f3c0\nef9052d4b9c0e143a5f0"..., 4096) = 4096
read(3, "/tags/dummyapp-20170609-182243_a"..., 4096) = 4096
read(3, "5418485a012396832faedc5\nc697717c"..., 4096) = 4096
read(3, "3-141556\n^69219f5ddd74c43d5574e5"..., 4096) = 4096
read(3, "0602-122026\n^4cbb642a2b3cb305336"..., 4096) = 4096
read(3, "a9bee28a76502716da588fd2fc22020a"..., 4096) = 4096
read(3, "73a677f refs/tags/events-2016090"..., 4096) = 4096
read(3, "3be9fd87d5bf6217aaf195d5\n650866a"..., 4096) = 4096
read(3, "a95cda22bc90a79\n4f3a36e9adac266f"..., 4096) = 4096
read(3, "ec1097435aeed7ed8\n7a2c97e8ad1a9f"..., 4096) = 4096
read(3, "dba7614549cec3ed80803b6b01161c3d"..., 4096) = 4096
read(3, "4ef8e8f\n7e3c15cd86655da442c48ba7"..., 4096) = 4096
read(3, "1d057a4b7dc47ac09f40a8d31916218\n"..., 4096) = 4096
read(3, "s/tags/intercomcron-20170615-110"..., 4096) = 4096
read(3, "\n^43f080925840cf77ae016fa93ecbdf"..., 4096) = 4096
read(3, "gs/logproc-20161230-121402\n^a25f"..., 4096) = 4096
read(3, "2d55c54c708fca2cfe726e72d86ad50 "..., 4096) = 4096
read(3, "70612-163608\n^614fcefc7f4c39b12f"..., 4096) = 4096
read(3, "ilebuild-20170512-145808\n^47a87c"..., 4096) = 4096
brk(0x226e000)                          = 0x226e000
read(3, "7a428de652f5a3c9c4\n214d8d1128260"..., 4096) = 4096
read(3, "\n^e5486659e4bad48a3fb1177b619f11"..., 4096) = 4096
read(3, "91f33991c3efed545f51 refs/tags/p"..., 4096) = 4096
read(3, "08d313fb454\nefe6a551adac01f51538"..., 4096) = 4096
read(3, "/ppcapp-20170628-111257\n^f56019d"..., 4096) = 4096
read(3, "b50901 refs/tags/provdash-201706"..., 4096) = 4096
read(3, "7 refs/tags/rtmapp-20170613-1102"..., 4096) = 4096
read(3, "-192153\n^296cc5ffc1c84b049fd0a15"..., 4096) = 4096
read(3, "a6\nda231495f5708ecdafe41aedf28a4"..., 4096) = 4096
read(3, "202\n^70ebec46ba2859c12b67a6dca82"..., 4096) = 4096
read(3, "9d54a38eeff507e45d\n9d93a8eaf70d3"..., 4096) = 4096
read(3, "ecure-hmsapp-20161021-181248\n^a5"..., 4096) = 4096
read(3, "0111-134153\n^13d748af46df47b5315"..., 4096) = 4096
read(3, "1 refs/tags/soylent-20170606-154"..., 4096) = 4096
read(3, "tags/statprofileapp-20161104-125"..., 4096) = 4096
read(3, "tags/substreamproc-20170214-1429"..., 4096) = 4096
read(3, "efs/tags/suite_partner_sites-201"..., 4096) = 4096
read(3, "167 refs/tags/tokenauth-20160929"..., 4096) = 4096
read(3, "640\n^00b52cdaaaf3c55e069cb62740d"..., 4096) = 4096
read(3, "9753e496ebbf7b05f009dd32\ndb917ed"..., 4096) = 4096
read(3, "8cc96a8a9313d82cc4c91d2ddc31613b"..., 4096) = 4096
read(3, "2ad87b80a7a0\n56519d1a3c4fe5cdcc3"..., 4096) = 4096
read(3, " refs/tags/xml-secure-mobile-201"..., 4096) = 4096
read(3, "794a5b25d4b5d411cc736298a\nb4cb1c"..., 4096) = 4096
read(3, "057d938c27f8b16e6ef9839874f696a2"..., 4096) = 4096
read(3, "3f3259ffc0262e4bf56f4eec01c76ac8"..., 4096) = 4096
read(3, "\n^dbab804616296abf788d4a1d991b3b"..., 4096) = 4096
read(3, "dad60d1e168e7d7de94e3da1 refs/ta"..., 4096) = 1978
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
lstat(".git/HEAD", {st_mode=S_IFREG|0664, st_size=39, ...}) = 0
open(".git/HEAD", O_RDONLY)             = 3
read(3, "ref: refs/heads/yves/xxx"..., 256) = 39
read(3, "", 217)                        = 0
close(3)                                = 0
lstat(".git/refs/heads/yves/xxx", 0x7fff059e34b0) = -1 ENOENT (No such
file or directory)
stat(".git/packed-refs", {st_mode=S_IFREG|0664, st_size=231354, ...}) = 0
readlink(".git/config", 0x2267b40, 32)  = -1 EINVAL (Invalid argument)
rt_sigaction(SIGINT, {0x54a550, [INT], SA_RESTORER|SA_RESTART,
0x7f48d8dab510}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGHUP, {0x54a550, [HUP], SA_RESTORER|SA_RESTART,
0x7f48d8dab510}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGTERM, {0x54a550, [TERM], SA_RESTORER|SA_RESTART,
0x7f48d8dab510}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGQUIT, {0x54a550, [QUIT], SA_RESTORER|SA_RESTART,
0x7f48d8dab510}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGPIPE, {0x54a550, [PIPE], SA_RESTORER|SA_RESTART,
0x7f48d8dab510}, {SIG_DFL, [PIPE], SA_RESTORER|SA_RESTART,
0x7f48d8dab510}, 8) = 0
getcwd("/usr/local/git_tree/main", 129) = 25
open("/usr/local/git_tree/main/.git/config.lock",
O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) = 3
lstat("/usr/local/git_tree/main/.git/config.lock",
{st_mode=S_IFREG|0664, st_size=0, ...}) = 0
open(".git/config", O_RDONLY)           = 4
open(".git/config", O_RDONLY)           = 5
fstat(5, {st_mode=S_IFREG|0664, st_size=363, ...}) = 0
fstat(5, {st_mode=S_IFREG|0664, st_size=363, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(5, "[core]\n\tsharedRepository = true\n"..., 4096) = 363
lseek(5, 0, SEEK_CUR)                   = 363
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
fstat(4, {st_mode=S_IFREG|0664, st_size=363, ...}) = 0
mmap(NULL, 363, PROT_READ, MAP_PRIVATE, 4, 0) = 0x7f48d9b8c000
close(4)                                = 0
chmod("/usr/local/git_tree/main/.git/config.lock", 0664) = 0
write(3, "[core]\n\tsharedRepository = true\n"..., 288) = -1 ENOSPC
(No space left on device)
write(3, "        merge = refs/heads/yves/"..., 51) = -1 ENOSPC (No
space left on device)
munmap(0x7f48d9b8c000, 363)             = 0
close(3)                                = 0
rename("/usr/local/git_tree/main/.git/config.lock",
"/usr/local/git_tree/main/.git/config") = 0
readlink(".git/config", 0x2230d00, 32)  = -1 EINVAL (Invalid argument)
getcwd("/usr/local/git_tree/main", 129) = 25
open("/usr/local/git_tree/main/.git/config.lock",
O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) = 3
lstat("/usr/local/git_tree/main/.git/config.lock",
{st_mode=S_IFREG|0664, st_size=0, ...}) = 0
open(".git/config", O_RDONLY)           = 4
open(".git/config", O_RDONLY)           = 5
fstat(5, {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
fstat(5, {st_mode=S_IFREG|0664, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f48d9b8c000
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0x7f48d9b8c000, 4096)            = 0
close(3)                                = 0
unlink("/usr/local/git_tree/main/.git/config.lock") = 0
close(4)                                = 0
write(2, "fatal: could not unset 'branch.y"..., 61fatal: could not
unset 'branch.yves/xxx.merge'
) = 61
exit_group(128)                         = ?
+++ exited with 128 +++
$ ls -la .git/config
-rw-rw-r-- 1 yorton users 0 Sep 13 16:38 .git/config



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"

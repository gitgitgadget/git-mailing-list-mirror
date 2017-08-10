Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5253208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbdHJToh (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:44:37 -0400
Received: from mout.web.de ([212.227.15.14]:55110 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752942AbdHJTog (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:44:36 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lu5BO-1dWQut41zy-011OQV; Thu, 10
 Aug 2017 21:44:26 +0200
Subject: Re: fatal: Out of memory, getdelim failed under NFS mounts
To:     Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <20170810144305.5d4lcx6oubkemsss@hopa.kiewit.dartmouth.edu>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <863176c5-5854-7a9b-ea38-d40621cead20@web.de>
Date:   Thu, 10 Aug 2017 21:44:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170810144305.5d4lcx6oubkemsss@hopa.kiewit.dartmouth.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:JwiWLOC2td46haDP2CdeCCzx+5dC46HC4nIw1WL8CP2q4N+WNzf
 etOcZ1xIyH2oIJCzwNJKdaE7DMYg0stlU15Q/23SJ5s5Hl1xv94W3Q98UkiDLMsljPkopxp
 Bw1YljJFyl+3hzY9chptx9jjH7VyRQjcPrkTsWpJBHbFPpGY12D8iFxtCVg8eOJzIW2v9To
 /0s4J1/zTUiPiyoW4AgXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B9e/xCVeIUA=:wdxbdtizsdetjEZRKClK/4
 NJbYMcg+nde51YWvlgwBBkKZF3299hY3kjNINFqcwdc4bG668S4bwyp5daIVLHwSCVwj9tZza
 fZa7TkXAzXg01alyyfiypoFRB4tiPhsGclzVfxJNfgNW4y5V9ccp82vWvTeMWkk2szLC9RWm+
 IQJzEkWW0DuylYWXN7cpS18x+15HtZ6un3g5m1C+1tOb36zNCCLA192zHCots1UcrDMD98AMl
 Xdgh+2VYwYK+unPkKFTL/r9fy8ugENj4hihePUvACItUv3b+zuI2skQCD1Lvnd70NPEkPI0O0
 e2ec+M2X9Em103YD+gEL6SC4m4L0DxqZONSHnElsmpP0nYM7Qr+Ur5cUAYk7dD4t+Uk/MqIMB
 RKe69SSUJT6XzUSOG/LHgCUnsIsO85aYmT8nM1qdVNtQtej1WxveE0vy2VUDTjcYmDslNGTBt
 1Mx4rXpUo0/PBWx4O4r9kAKergF9qtbbeYnwMKmG+fPoqg0JTE8K9gSv2KW4EeQgAHLhTEJzI
 kish8GWrGPozufckW11Zm8n0GdQDOhd2491eZY2Qkg8b8F3xtAn7QfBzsl8tnDGhrrUYK/0WG
 GbGiFCyori/mmZEOgeoPP48W1jR11GUzovQBcsouNldcYuYFCAFZJbL+x+XFVWP8H4Oy+cVSD
 J7azxZwBpj2WPUScDlx01EtOv3VNxq9msADn4Ke3/Oq3DWA1GO2+5bdAVKXyxcJC63tTnuxns
 6foJWcQ9O/RvdYbj6jnY2vBpr4AfQUHys83SQEa4UPIep7yCuv6ubRghZJdEfG4gz0YySW42B
 IYgy2VA7JGqgjHhyUxsKVgYyo3ZcV2NU9maqkRdSiPBZjO0CfU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.2017 um 16:43 schrieb Yaroslav Halchenko:
> On Thu, 10 Aug 2017, René Scharfe wrote:
>> Am 09.08.2017 um 19:39 schrieb Yaroslav Halchenko:
>>> More context (may be different issue(s)) could be found at
>>> http://git-annex.branchable.com/forum/git-annex_add_out_of_memory_error/
>>> but currently I am consistently reproducing it while running
>>> git (1:2.11.0-3 debian stretch build) within debian stretch singularity
>>> environment [1].
> 
>>> External system is Centos 6.9, and git 1.7.1 (and installed in modules
>>> 2.0.4) do not show similar buggy behavior.
> 
>>> NFS mounted partitions are bind mounted inside the sinularity space and
>>> when I try to do some git operations, I get that error inconsistently , e.g.
> 
>>> 	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
>>> 	fatal: Out of memory, getdelim failed
>>> 	error: git://github.com/datalad/datalad did not send all necessary objects
> 
>>> 	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
>>> 	fatal: Out of memory, getdelim failed
>>> 	error: git://github.com/datalad/datalad did not send all necessary objects
> 
>>> 	yhalchen@discovery:/mnt/scratch/yoh/datalad$ git pull --ff-only origin master
>>> 	From git://github.com/datalad/datalad
>>> 	 * branch              master     -> FETCH_HEAD
>>> 	fatal: Out of memory, getdelim failed
> 
>>> and some times it succeeds.  So it smells that some race condition
>>> somewhere...?
> 
>> I doubt the type of file system matters.
> 
> So far it has been a very consistent indicator.  I did not manage to get
> this error while performing the same operation under /tmp (bind to local
> mounted drive), where it also feels going faster (again suggesting that
> original issue is some kind of a race)

Well, there have been bugs in getdelim() before, e.g.:

  https://bugzilla.redhat.com/show_bug.cgi?id=601071
  https://bugzilla.redhat.com/show_bug.cgi?id=1332917

git v2.5.0 was the first version to use it.   So if all else fails it may
be worth compiling git without HAVE_GETDELIM.

>> The questions are: How much
>> main memory do you have, what is git trying to cram into it, is there
>> a way to reduce the memory footprint or do you need to add more RAM?
>> ... reordered ...
>> "free" and "ulimit -a" can help you find out how much memory you can
>> use.
> 
> I think those aren't the reason:
> 
> yhalchen@discovery:/mnt/scratch/yoh/datalad$ free -h
>                total        used        free      shared  buff/cache   available
> Mem:           126G        2.5G         90G        652K         33G        123G
> Swap:          127G        1.7M        127G

Is all of that available to the git in the Singularity container or
is that the memory size of the host and there's some kind of limit
for the guests?

> yhalchen@discovery:/mnt/scratch/yoh/datalad$ ulimit
> unlimited

That's just the maximum file size; memory-related limits are more
interesting for this case.  "ulimit -a" will show all limits.

>>> any recommendations on how to pin point the "offender"? ;)
>> Running "GIT_TRACE=1 git pull --ff-only origin master" would be a
>> good start, I think, to find out which of the different activities
>> that pull is doing causes the out-of-memory error.
> 
> samples of bad, and then good runs (from eyeballing -- the same until
> error message):
> 
> yhalchen@discovery:/mnt/scratch/yoh$ cat git_trace_bad.log
> 14:05:25.782270 git.c:371               trace: built-in: git 'pull' '--ff-only' 'origin' 'master'
> 14:05:25.795036 run-command.c:350       trace: run_command: 'fetch' '--update-head-ok' 'origin' 'master'
> 14:05:25.795332 exec_cmd.c:116          trace: exec: 'git' 'fetch' '--update-head-ok' 'origin' 'master'
> 14:05:25.797212 git.c:371               trace: built-in: git 'fetch' '--update-head-ok' 'origin' 'master'
> 14:05:25.904088 run-command.c:350       trace: run_command: 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
> 14:05:26.085954 run-command.c:350       trace: run_command: 'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 11652 on discovery.hpcc.dartmouth.edu' '--pack_header=2,103'
> 14:05:26.086333 exec_cmd.c:116          trace: exec: 'git' 'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 11652 on discovery.hpcc.dartmouth.edu' '--pack_header=2,103'
> 14:05:26.088382 git.c:371               trace: built-in: git 'index-pack' '--stdin' '--fix-thin' '--keep=fetch-pack 11652 on discovery.hpcc.dartmouth.edu' '--pack_header=2,103'
> 14:05:26.133326 run-command.c:350       trace: run_command: 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
> 14:05:26.133688 exec_cmd.c:116          trace: exec: 'git' 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
> 14:05:26.135493 git.c:371               trace: built-in: git 'rev-list' '--objects' '--stdin' '--not' '--all' '--quiet'
> fatal: Out of memory, getdelim failed
> error: git://github.com/datalad/datalad did not send all necessary objects

That rev-list call comes from connected::check_connected(); the error
message from builtin/fetch.c::store_updated_refs(), which actually calls
check_connected().  So you should be able to reproduce the issue just
with git fetch or with git rev-list.  The latter requires passing the
right objects to the command, but perhaps reproduction is possible with
guessed or arbitrary values.

I don't know which files these commands access with getdelim() except
for the ones mentioned below, though.

>> Also: What does "wc -L .git/FETCH_HEAD .git/packed-refs" report?
> 
> "varying" and not consistent with causing an error (first trials, where I
> did not cat .git/FETCH_HEAD kinda suggested differently):
> 
> yhalchen@discovery:/mnt/scratch/yoh/datalad$ cat .git/FETCH_HEAD; wc -L .git/FETCH_HEAD .git/packed-refs; git pull --ff-only origin master
> 1f90ef474ee200befea19ba77242fa44f16739f0                branch 'master' of git://github.com/datalad/datalad
>   107 .git/FETCH_HEAD
>    90 .git/packed-refs
>   107 total

These line lengths are unlikely to exhaust the memory.  I was rather
hoping for values in the range of billions due to some kind of freak
accident or unconventional refs usage.

> NB is there a diff which could be given regexes within a line to ignore
> in diffs in so we could still retain original lines, i.e. answer to
> https://stackoverflow.com/questions/15841223/diff-while-ignoring-patterns-within-a-line-but-not-the-entire-line
> ?
> 
> FWIW -- here is a diff (from good to bad run) of strace (with pid/address
> info changed to stay the same for comparisons):
> 
> @@ -3121,6 +3118,7 @@
>   [pid YYYYY] close(3)                    = 0
>   [pid YYYYY] brk(NULL)                   = 0xXXXXX
>   [pid YYYYY] brk(0xXXXXX)         = 0xXXXXX
> +[pid YYYYY] mmap(NULL, 1048576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xXXXXX

That looks like malloc() increasing its pool by 1 MB...

>   [pid YYYYY] open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>   [pid YYYYY] open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>   [pid YYYYY] open("/usr/lib/locale/en_US/LC_MESSAGES", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
> @@ -3144,11 +3142,9 @@
>   [pid YYYYY] lstat(".git/commondir", 0xXXXXX) = -1 ENOENT (No such file or directory)
>   [pid YYYYY] open(".git/config", O_RDONLY) = 3
>   [pid YYYYY] fstat(3, {st_mode=S_IFREG|0644, st_size=257, ...}) = 0
> -[pid YYYYY] mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xXXXXX
>   [pid YYYYY] read(3, "[core]\n\trepositoryformatversion "..., 524288) = 257
>   [pid YYYYY] read(3, "", 524288)         = 0
>   [pid YYYYY] close(3)                    = 0
> -[pid YYYYY] munmap(0xXXXXX, 528384) = 0

... and in the working case it just gets 516 KB and releases it
shortly afterwards...

>   [pid YYYYY] stat(".", {st_mode=S_IFDIR|0755, st_size=907, ...}) = 0
>   [pid YYYYY] getcwd("/mnt/scratch/yoh/datalad", 129) = 25
>   [pid YYYYY] chdir(".")                  = 0
> @@ -3163,7 +3159,6 @@
>   [pid YYYYY] access(".git/config", R_OK) = 0
>   [pid YYYYY] open(".git/config", O_RDONLY) = 3
>   [pid YYYYY] fstat(3, {st_mode=S_IFREG|0644, st_size=257, ...}) = 0
> -[pid YYYYY] brk(0xXXXXX)         = 0xXXXXX
>   [pid YYYYY] read(3, "[core]\n\trepositoryformatversion "..., 524288) = 257
>   [pid YYYYY] read(3, "", 524288)         = 0
>   [pid YYYYY] close(3)                    = 0
> @@ -3180,245 +3175,48 @@
>   [pid YYYYY] read(0, "1f90ef474ee200befea19ba77242fa44"..., 4096) = 82
>   [pid YYYYY] open(".git/refs/", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
>   [pid YYYYY] fstat(3, {st_mode=S_IFDIR|0755, st_size=70, ...}) = 0
> -[pid YYYYY] brk(0xXXXXX)         = 0xXXXXX
> +[pid YYYYY] mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xXXXXX
>   [pid YYYYY] getdents(3, /* 5 entries */, 524288) = 136
>   [pid YYYYY] stat(".git/refs/heads", {st_mode=S_IFDIR|0755, st_size=24, ...}) = 0
>   [pid YYYYY] stat(".git/refs/remotes", {st_mode=S_IFDIR|0755, st_size=24, ...}) = 0
>   [pid YYYYY] stat(".git/refs/tags", {st_mode=S_IFDIR|0755, st_size=47, ...}) = 0
>   [pid YYYYY] getdents(3, /* 0 entries */, 524288) = 0
> +[pid YYYYY] munmap(0xXXXXX, 528384) = 0

... which is done in the non-working case as well, just a bit
later...

>   [pid YYYYY] close(3)                    = 0
>   [pid YYYYY] open(".git/refs/bisect", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
>   [pid YYYYY] open(".git/packed-refs", O_RDONLY) = 3
>   [pid YYYYY] fstat(3, {st_mode=S_IFREG|0644, st_size=5042, ...}) = 0
>   [pid YYYYY] fstat(3, {st_mode=S_IFREG|0644, st_size=5042, ...}) = 0
> -[pid YYYYY] read(3, "# pack-refs with: peeled fully-p"..., 524288) = 5042

... and it doesn't seem to reach the stage when the packed refs are read.

So the bad case has malloc() grab and never release one more megabyte.
Is there are a limit for Singularity containers?  Can you increase the
one for yours by 1 MB? :)

René

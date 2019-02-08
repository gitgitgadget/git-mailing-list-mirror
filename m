Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DFA1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 08:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfBHIcp (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 03:32:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:44329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfBHIcp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 03:32:45 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1Fe4-1h7cZ103qa-00tAMs; Fri, 08
 Feb 2019 09:32:35 +0100
Date:   Fri, 8 Feb 2019 09:32:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
In-Reply-To: <CAM0VKjkM-THZALy20VrZ-JSMyZjUXUqp1CAoCPrezXRsBfRJ2A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902080928500.41@tvgsbejvaqbjf.bet>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com> <CAM0VKjkM-THZALy20VrZ-JSMyZjUXUqp1CAoCPrezXRsBfRJ2A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-350591008-1549614756=:41"
X-Provags-ID: V03:K1:3EYdx5mVWxIhNNu0V4kAY33rCAh0oy+6x6mq9U7d5TIKvTdWN33
 SHxaF3PKrWnVSqDOGWslQPNJgjIrPvkp146/vLmOiEgS2fs1USs6ae3IStxsfwwKONJ9CNJ
 9lNsMLF2s9c0IpPSmoADbU3FCqsRjnhcxpcLKJ37dNv0WhwvaUm5ba44HHoE0A2XliH8EZm
 w+u9Yee45oJ9f22HQMlug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eJGSHWHwrFI=:2FpgIz/6vw4NbPfTPD3p2X
 vdnnbbvULhVXCoL4Zb3+ZHxM3T2xWXIAn0dzsmAgri+yWOxzkC7vflnqIDhxu85pOiI6q1FoJ
 O57I/WCfgi+g1jAgXAu9dK4u7oZztduUQ7L/vmzJMy3Ic5vfNN+cL2RqNdaMycgZDQqHSslbG
 HaZ2gmnT7BJjEEkp/QGQYCAvnQQpBUO4xI/sfN4EGs/DGY39FbIbMxejuWWLQuDmYLljrrUEN
 wbk4M7vNbYUp01anQ72V+BOeHbGignrtbRJDeX476L3K1/JxPLDOmP2jdRaFCZqw1sCqCtrAC
 vVIAhvnrq6Oe+TTKRrVQr8KR9EK7cX9IlD/iqYGo1T3/XKd8msA8ux6sK11/t0SX1pnj0I1fX
 /yXiuyaUD3aAcwREAbt+j70QG3ALNF6WmlDeWYmdd/nAOu7JDZvGavYvbLLEdBurFszwn61fn
 W8UjhPwjt4WCx84mugSS0NUFzT3DOOSy5VZbm8+GfxIadzAgKpDRLSHIKRCh9nHlpSncguH0P
 3y9uV1qVdulheHpCYaYG3UAerhEQ75Mw6VfGgQwhjITgQ3ckyfigBdRyf0FjwaNDNLAHzx6UE
 mw3edANInw+gDov7XAbnGriWlrp6nPryKr+MaZMPMHbPD+NRbd2Y2QsoVZi5VujlDIfpm/no8
 EcEHAfVf4tH99K/AF2QLA7xT4B+K4M6mKn2astZ01hASlj7dpnVDIhIrTKhDbiv76Jv+3GAMs
 tIwaS2AwRXjs+KT1MujZGWM9i+VkKPK4LQD337lbsPyH1pWO8Yf40Yt1bMykjHqxDj1VnXejG
 D2W7FXy/MVmp8vBE1SG4vQICM0k15lu2hJ5aZoD6MUJPH6ZFCbyr2OkprEme0LClCZTL3iQiU
 IqL82uPQP4BQIJQtpcI32M4x8439DSCxm3dipaKyF7vs75IHbtplECvF3t02t6Dc8VQAsf2tT
 HrEpTjVTIsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-350591008-1549614756=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Team,

On Mon, 6 Aug 2018, SZEDER Gábor wrote:

> [Resending with Clemens' last used email address.
> Clemens, please consider sending a patch to update our .mailmap file.]
> 
> 
> On Mon, Aug 6, 2018 at 5:11 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > Travis CI changed its default OSX image to use XCode 9.4 on 2018-07-31
> > [1].  Since then OSX build jobs fail rather frequently because of a
> > SIGPIPE in the tests 'fetch notices corrupt pack' or 'fetch notices
> > corrupt idx' in 't5570-git-daemon.sh' [2].  I think this is a symptom
> > a real bug in Git affecting other platforms as well, but these tests
> > are too lax to catch it.

I am seeing this very frequently now, as it feels like failing in the
Azure Pipeline about half of the time.

The symptom is this:

-- snip --
++ cp -R '/Users/vsts/agent/2.146.0/work/1/s/t/trash directory.t5570-git-daemon/repo/repo_pack.git' '/Users/vsts/agent/2.146.0/work/1/s/t/trash directory.t5570-git-daemon/repo/repo_bad2.git'
++ cd '/Users/vsts/agent/2.146.0/work/1/s/t/trash directory.t5570-git-daemon/repo/repo_bad2.git'
+++ ls objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
++ p=objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
++ chmod u+w objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
++ printf %0256d 0
++ dd of=objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx bs=256 count=1 seek=1 conv=notrunc
1+0 records in
1+0 records out
256 bytes transferred in 0.000018 secs (14316558 bytes/sec)
++ mkdir repo_bad2.git
++ cd repo_bad2.git
++ git --bare init
Initialized empty Git repository in /Users/vsts/agent/2.146.0/work/1/s/t/trash directory.t5570-git-daemon/repo_bad2.git/
++ test_must_fail git --bare fetch git://127.0.0.1:5570/repo_bad2.git
++ case "$1" in
++ _test_ok=
++ git --bare fetch git://127.0.0.1:5570/repo_bad2.git
[13879] Connection from 127.0.0.1:60504
[13879] Extended attribute "host": 127.0.0.1:5570
[13879] Extended attribute "protocol": version=0
[13879] Request upload-pack for '/repo_bad2.git'
[13879] error: non-monotonic index ./objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
[13879] error: non-monotonic index ./objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
[13879] error: non-monotonic index ./objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
[13879] error: non-monotonic index ./objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
[13879] error: refs/heads/master does not point to a valid object!
[13879] error: non-monotonic index ./objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
[13879] error: non-monotonic index ./objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
[13879] error: refs/heads/other does not point to a valid object!
[13879] error: non-monotonic index ./objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
[13879] error: non-monotonic index ./objects/pack/pack-b2175ab283c0abe358895777ca01c36e88a92e35.idx
[13879] fatal: git upload-pack: not our ref b5c2e4226db03597a64815fd226648510b22ba40
[11833] [13879] Disconnected (with error)
++ exit_code=141
++ test 141 -eq 0
++ test_match_signal 13 141
++ test 141 = 141
++ return 0
++ list_contains '' sigpipe
++ case ",$1," in
++ return 1
++ test 141 -gt 129
++ test 141 -le 192
++ echo 'test_must_fail: died by signal 13: git --bare fetch git://127.0.0.1:5570/repo_bad2.git'
test_must_fail: died by signal 13: git --bare fetch git://127.0.0.1:5570/repo_bad2.git
++ return 1
error: last command exited with $?=1
not ok 10 - fetch notices corrupt idx
#	
#		cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
#		(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
#		 p=$(ls objects/pack/pack-*.idx) &&
#		 chmod u+w $p &&
#		 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
#		) &&
#		mkdir repo_bad2.git &&
#		(cd repo_bad2.git &&
#		 git --bare init &&
#		 test_must_fail git --bare fetch "$GIT_DAEMON_URL/repo_bad2.git" &&
#		 test 0 = $(ls objects/pack | wc -l)
#		)
#	
-- snap --

Any ideas how to fix this test, anyone?

Ciao,
Dscho

> >
> > What it boils down to is this sequence:
> >
> >   - The test first prepares a repository containing a corrupt pack,
> >     ready to be server via 'git daemon'.
> >
> >   - Then the test runs 'test_must_fail git fetch ....', which connects
> >     to 'git daemon', which forks 'git upload-pack', which then
> >     advertises refs (only HEAD) and capabilities.  So far so good.
> >
> >   - 'git fetch' eventually calls fetch-pack.c:find_common().  The
> >     first half of this function assembles a request consisting of a
> >     want and a flush pkt-line, and sends it via a send_request() call.
> >
> >     At this point the scheduling becomes important: let's suppose that
> >     fetch is slow and upload-pack is fast.
> >
> >   - 'git upload-pack' receives the request, parses the want line,
> >     notices the corrupt pack, responds with an 'ERR upload-pack: not
> >     our ref' pkt-line, and die()s right away.
> >
> >   - 'git fetch' finally approaches the end of the function, where it
> >     attempts to send a done pkt-line via another send_request() call
> >     through the now closing TCP socket.
> >
> >   - What happens now seems to depend on the platform:
> >
> >     - On Linux, both on my machine and on Travis CI, it shows textbook
> >       example behaviour: write() returns with error and sets errno to
> >       ECONNRESET.  Since it happens in write_or_die(), 'git fetch'
> >       die()s with 'fatal: write error: Connection reset by peer', and
> >       doesn't show the error send by 'git upload-pack'; how could it,
> >       it doesn't even get as far to receive upload-pack's ERR
> >       pkt-line.
> >
> >       The test only checks that 'git fetch' fails, but it doesn't
> >       check whether it failed with the right error message, so the
> >       test still succeeds.  Had it checked the error message as well,
> >       we most likely had noticed this issue already, it doesn't happen
> >       all that rarely.
> >
> >     - On the new OSX images with XCode 9.4 on Travis CI the write()
> >       triggers SIGPIPE right away, and 'test_must_fail' notices it and
> >       fails the test.  I couldn't see any sign of an ECONNRESET or any
> >       other error that we could act upon to avoid the SIGPIPE.
> >
> >     - On OSX with XCode 9.2 on Travis CI there is neither SIGPIPE, nor
> >       ECONNRESET, but sending the request actually succeeds even
> >       though there is no process on the other end of the socket
> >       anymore.  'git fetch' then simply continues execution, reads and
> >       parses the ERR pkt-line, and then dies()s with 'fatal: remote
> >       error: upload-pack: not our ref'.  So, on the face of it, it
> >       shows the desired behaviour, but I have no idea how that write()
> >       could succeed instead of returning error.
> >
> > I don't know what happens on a real Mac as I don't have access to one;
> > I figured out all the above by enabling packet tracing, adding a
> > couple of well placed tracing printf() and sleep() calls, running a
> > bunch of builds on Travis CI, and looking through their logs.  But
> > without access to a debugger and netstat and what not I can't really
> > go any further.  So I would now happily pass the baton to those who
> > have a Mac and know a thing or two about its porting issues to first
> > check whether OSX on a real Mac shows the same behaviour as it does in
> > Travis CI's virtualized(?) environment.  And then they can pass the
> > baton to those who know all the intricacies of the pack protocol and
> > its implementation to decide what to do with this issue.
> >
> > For a mostly reliable reproduction recipe you might want to fetch this
> > branch:
> >
> >   https://github.com/szeder/git t5570-git-daemon-sigpipe
> >
> > and then run 'make && cd t && ./t5570-git-daemon.sh -v -x'
> >
> >
> > Have fun! ;)
> >
> >
> > 1 - https://blog.travis-ci.com/2018-07-19-xcode9-4-default-announce
> >
> > 2 - On git.git's master:
> >     https://travis-ci.org/git/git/jobs/411517552#L2717
> 
> 
--8323328-350591008-1549614756=:41--

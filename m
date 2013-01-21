From: Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 21 Jan 2013 11:14:35 -0500
Message-ID: <50FD696B.5000205@calculquebec.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil> <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil> <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com> <87a9s2o6ri.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, kusmabite@gmail.com,
	Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 21 17:15:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxK1U-0005YF-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 17:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab3AUQOi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 11:14:38 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:57612 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab3AUQOh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 11:14:37 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so6883043qaq.19
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 08:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=3XGLfZJFRel1b0zFn9CHOqRHP8/JG62Gh0ipz0NK6ok=;
        b=Im1VUGqtywFMu/FrXaSuz+DQbK7H8GDn9J1cTiO+DWk1FIEyQ6Ee7ZSxctLA5tKT9D
         kWJfnJRPgQSgTdYAio/m4wU3AB7rEqOwkBTx4A1LrCs3/xD5DKesuWv+j/IMmbj/wfeR
         8nhAf1somKpek0H3tIiqsJlQuHhQP/zkXw9Uio3/C+wLGTflw+uRTIO5T/iEwZC4SQmk
         YA9S64z7C1DO4XsM8oX8nACu3olsVio8jKqEspWbfeAMIaU4xx9tV/qHpGVrtQ20M5rb
         8hyQT3VnHK88PPZ1s5WQ6Z+j7/3i+9ehRGJ8ZMQH3AxJBe0Q1RQwdopOVyqYVOW7IWaa
         Po9g==
X-Received: by 10.224.175.82 with SMTP id w18mr13308094qaz.65.1358784876308;
        Mon, 21 Jan 2013 08:14:36 -0800 (PST)
Received: from dhcp-106-204.gel.ulaval.ca ([2620:0:1af0:f100:15d8:691d:a723:1ee1])
        by mx.google.com with ESMTPS id z5sm8861823qer.8.2013.01.21.08.14.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 08:14:35 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <87a9s2o6ri.fsf@pctrast.inf.ethz.ch>
X-Gm-Message-State: ALoCoQmDkiXiJcfb7b9UQHP6S1/eJpIvVb4jdGHVYOaR2YTpLPhQqf2eEOZKDL+eQHYxXQbTlZZG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214126>

Hi Thomas,
Can you tell me what is the version of the lustre servers and the lustr=
e=20
clients ?

Thanks,

Maxime Boissonneault
HPC specialist @ Calcul Qu=E9bec.

Le 2013-01-21 11:11, Thomas Rast a =E9crit :
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Fri, Jan 18, 2013 at 6:50 PM, Eric Chamberland
>> <Eric.Chamberland@giref.ulaval.ca> wrote:
>>> Good idea!
>>>
>>> I did a strace and here is the output with the error:
>>>
>>> http://www.giref.ulaval.ca/~ericc/strace_git_error.txt
>>>
>>> Hope it will be insightful!
>> This trace doesn't seem to contain child-processes, but instead havi=
ng
>> their stderr inlined into the log. Try using "strace -f" instead...
> I happen to have access to a lustre FS on the brutus cluster of ETH
> Zurich, so I figured I could give it a shot.
>
> What's odd is that while I cannot reproduce the original problem, the=
re
> seems to be another issue/bug with utime():
>
>    $ strace -f -o ~/gc.trace git gc
>    warning: failed utime() on .git/objects/68/tmp_obj_sCAEVc: Interru=
pted system call
>    warning: failed utime() on .git/objects/a6/tmp_obj_3cdB2c: Interru=
pted system call
>    warning: failed utime() on .git/objects/69/tmp_obj_lbU3Xc: Interru=
pted system call
>    warning: failed utime() on .git/objects/c3/tmp_obj_EU97Wc: Interru=
pted system call
>    warning: failed utime() on .git/objects/3e/tmp_obj_tb2j3c: Interru=
pted system call
>    warning: failed utime() on .git/objects/15/tmp_obj_e6zMXc: Interru=
pted system call
>    warning: failed utime() on .git/objects/54/tmp_obj_ExOJVc: Interru=
pted system call
>    warning: failed utime() on .git/objects/e3/tmp_obj_GtPw4c: Interru=
pted system call
>    warning: failed utime() on .git/objects/21/tmp_obj_Xex32c: Interru=
pted system call
>    warning: failed utime() on .git/objects/1a/tmp_obj_CzwsZc: Interru=
pted system call
>    warning: failed utime() on .git/objects/18/tmp_obj_o6fp3c: Interru=
pted system call
>    warning: failed utime() on .git/objects/32/tmp_obj_Ih0G4c: Interru=
pted system call
>    warning: failed utime() on .git/objects/41/tmp_obj_1RXV1c: Interru=
pted system call
>    Counting objects: 137744, done.
>    Delta compression using up to 48 threads.
>    Compressing objects: 100% (36510/36510), done.
>    Writing objects: 100% (137744/137744), done.
>    Total 137744 (delta 101591), reused 135512 (delta 99472)
>
> The trace is here (2.1MB compressed):
>
>    http://thomasrast.ch/download/gc.trace.bz2
>
> For the test I used a clone of another git.git I had around.  I think
> the error is from sha1_file.c:2564.  While that doesn't look too
> important (see ca11b212 for context), it does raise the question: wha=
t
> other system calls that we never expect to EINTR can do this on
> sufficiently arcane system/FS combinations?
>
>
> Peff's test ran without any apparent issue for a few minutes.  I also
> ran an extended version (at the end) that sets alarms, so as to actua=
lly
> get interrupted.  That proved more interesting.  I had to fix verify(=
)
> and write_in_full() to account for EINTR in read()/write(), as those
> seem likely to fail.  I also got link() to fail:
>
>    $ ~/lustre-peff-reproducer
>    unable to create hard link: Interrupted system call
>    unable to open index file: No such file or directory
>
> but it took a long time.  Unfortunately, when running it with strace =
I
> managed to panic the host I ran it on:
>
>    $ strace -o ~/peff-reproducer.trace ~/lustre-peff-reproducer
>
>    Message from syslogd@brutus1 at Jan 21 17:09:43 ...
>     kernel:LustreError: 37417:0:(osc_lock.c:1182:osc_lock_enqueue()) =
ASSERTION( ols->ols_state =3D=3D OLS_NEW ) failed: Impossible state: 4
>
>    Message from syslogd@brutus1 at Jan 21 17:09:43 ...
>     kernel:LustreError: 37417:0:(osc_lock.c:1182:osc_lock_enqueue()) =
LBUG
>
>    Message from syslogd@brutus1 at Jan 21 17:09:43 ...
>     kernel:Kernel panic - not syncing: LBUG
>
> Yay for now having to explain this to the cluster team.
>
>
> I tried finding a standard that limits the syscalls to which EINTR
> applies, without too much success.  I'm not sure how far I should tru=
st
> my manpages, but while some of them explicitly list EINTR as a possib=
le
> error (read, write, etc.) link() does not.  (And the linux manpages
> agree with the POSOIX ones for once.)
>
> If somebody finds such a standard, we could of course use it to blame
> lustre instead :-)
>
> In the absence of it, wouldn't we in theory have to write a simple
> loop-on-EINTR wrapper for *all* syscalls?
>
> Of course there's the added problem that when open(O_CREAT|O_EXCL) fa=
ils
> with EINTR, it's hard to tell whether a file that may now exist is
> indeed yours or some other process's.
>
> --- 8< ----
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/time.h>
> #include <signal.h>
> #include <errno.h>
>
> struct itimerval itv;
>
> static int randomize(unsigned char *buf, int len)
> {
>    int i;
>    len =3D rand() % len;
>    for (i =3D 0; i < len; i++)
>      buf[i] =3D rand() & 0xff;
>    return len;
> }
>
> static int check_eof(int fd)
> {
>    int ch;
>    int r =3D read(fd, &ch, 1);
>    if (r < 0) {
>      perror("read error after expected EOF");
>      return -1;
>    }
>    if (r > 0) {
>      fprintf(stderr, "extra byte after expected EOF");
>      return -1;
>    }
>    return 0;
> }
>
> static int verify(int fd, const unsigned char *buf, int len)
> {
>    while (len) {
>      char to_check[4096];
>      int got =3D read(fd, to_check,
>                     len < sizeof(to_check) ? len : sizeof(to_check));
>
>      if (got < 0 && errno =3D=3D EINTR)
>        continue;
>      if (got < 0) {
>        perror("unable to read");
>        return -1;
>      }
>      if (got =3D=3D 0) {
>        fprintf(stderr, "premature EOF (%d bytes remaining)", len);
>        return -1;
>      }
>      if (memcmp(buf, to_check, got)) {
>        fprintf(stderr, "bytes differ");
>        return -1;
>      }
>
>      buf +=3D got;
>      len -=3D got;
>    }
>
>    return check_eof(fd);
> }
>
> int write_in_full(int fd, const unsigned char *buf, int len)
> {
>    while (len) {
>      int r =3D write(fd, buf, len);
>      if (r < 0 && errno =3D=3D EINTR)
>        continue;
>      if (r < 0)
>        return -1;
>      buf +=3D r;
>      len -=3D r;
>    }
>    return 0;
> }
>
> int move_into_place(const char *old, const char *new)
> {
>    if (link(old, new) < 0) {
>      perror("unable to create hard link");
>      return 1;
>    }
>    unlink(old);
>    return 0;
> }
>
> void handle_alarm(int signal)
> {
> }
>
> int main(void)
> {
>    struct sigaction sa;
>
>    sa.sa_handler =3D handle_alarm;
>    sa.sa_flags =3D SA_RESTART;
>    sigaction(SIGALRM, &sa, NULL);
>
>    itv.it_interval.tv_sec =3D 0;
>    itv.it_interval.tv_usec =3D 10000;
>    itv.it_value.tv_sec =3D 0;
>    itv.it_value.tv_usec =3D 100000;
>    setitimer(ITIMER_REAL, &itv, NULL);
>
>    while (1) {
>      static unsigned char junk[1024*1024];
>      int len =3D randomize(junk, sizeof(junk));
>      int fd;
>
>      /* clean up from any previous round */
>      unlink("tmpfile");
>      unlink("final.idx");
>
>      fd =3D open("tmpfile", O_WRONLY|O_CREAT, 0666);
>      if (fd < 0) {
>        perror("unable to open tmpfile");
>        return 1;
>      }
>      if (write_in_full(fd, junk, len) < 0 ||
>          fsync(fd) < 0 ||
>          close(fd) < 0) {
>        perror("unable to write");
>        return 1;
>      }
>
>      if (move_into_place("tmpfile", "final.idx") < 0)
>        return 1;
>
>      fd =3D open("final.idx", O_RDONLY);
>      if (fd < 0) {
>        perror("unable to open index file");
>        return 1;
>      }
>      if (verify(fd, junk, len) < 0)
>        return 1;
>      close(fd);
>    }
> }


--=20
---------------------------------
Maxime Boissonneault
Analyste de calcul - Calcul Qu=E9bec, Universit=E9 Laval
Ph. D. en physique

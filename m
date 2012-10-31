From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 19:04:31 +0100
Message-ID: <CAMP44s2oKMog5GygrAag8SOdwhQJr4gCZxZAwWUo-ERDzni0ag@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
	<509149D9.3070606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 19:04:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTcen-0000J2-PT
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 19:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933617Ab2JaSEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2012 14:04:35 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60580 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933566Ab2JaSEc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2012 14:04:32 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1728587oag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=picF5ajZWn67zDaPJH0w0JiLwSFBL7rmO8xvEn28KHc=;
        b=iiq5pZWM75LkOuxzgXFJOiOF8Kkoja45rTa/qFeZ1otkCRBWdhFqF0d8/UKrsb/nQR
         ziyCgOzdJUMtF1IzUszORMceYJcpyjBMcSvFZccDsX5H3kYxjxo052ZrLD/uj1uwmx4I
         x5C3NkWP7HwaGXiO+qdQvgOBZztkFJpOM7R4cRU3/4XfiGwk0qQxU+m0S3CsngAf7Sl9
         tmQObl6uP7Tu/ahR7nsziIFU2Uft81L80FFiH6e0swlYpTYEsQINB5/RyeeZTukyEJxt
         /qHuFNgbYricpV934spi82FtgRk877spnULfg+MRfkMbGUogxn1RpYFiDDftqQ/ZPiFg
         k5HA==
Received: by 10.182.52.105 with SMTP id s9mr31240303obo.25.1351706671552; Wed,
 31 Oct 2012 11:04:31 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 11:04:31 -0700 (PDT)
In-Reply-To: <509149D9.3070606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208845>

On Wed, Oct 31, 2012 at 4:55 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 31.10.2012 16:39:

>> Didn't think so. The truth of the matter is that it doesn't matter
>> what I do code-wise.
>
> Just try, seriously.

All right.

=46irst of all, I clone the repositories pointed out:

git://github.com/fingolfin/git.git (remote-hg)
git://github.com/mjg/git.git (remote-hg)
git://github.com/msysgit/git.git (d3ac32c^..1e000d4)

I rebase them on top ov v1.8.0... all 3 branches are different from
each other. I'll pick yours.

% git clone hg::~/dev/hg
Cloning into 'hg'...
Traceback (most recent call last):
  File "/opt/git-2/libexec/git-core/git-remote-hg", line 101, in <modul=
e>
    sys.exit(HgRemoteHelper().main(sys.argv))
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/helpe=
r.py",
line 196, in main
    repo =3D self.get_repo(alias, url)
  File "/opt/git-2/libexec/git-core/git-remote-hg", line 35, in get_rep=
o
    if repo.capable('branchmap'):
AttributeError: 'mqrepo' object has no attribute 'capable'

Let's try msysgit... The same.

Max's? The same.

Maybe it's just the setup and the tests actually pass?

# failed 11 among 14 test(s)

Nope.

All right, it probably doesn't work with recent versions of mercurial.
Let's try with hg v2.2:

# failed 4 among 14 test(s)

All right, that's progress.

Can I clone now?

% git clone hg::~/dev/hg
Cloning into 'hg'...
progress Exported revision 0.
progress Exported revision 1000.
fatal: Missing space before < in ident string: Anupam
Kapoor<anupam.kapoor@gmail.com> <none@none> 1127407335 -0700
fast-import: dumping crash report to /tmp/hg/.git/fast_import_crash_181=
97
fatal: Error while running fast-import
Traceback (most recent call last):
  File "/opt/git-2/libexec/git-core/git-remote-hg", line 101, in <modul=
e>
    sys.exit(HgRemoteHelper().main(sys.argv))
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/helpe=
r.py",
line 204, in main
    more =3D self.read_one_line(repo)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/helpe=
r.py",
line 169, in read_one_line
    func(repo, cmdline)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/helpe=
r.py",
line 108, in do_import
    repo.exporter.export_repo(repo.gitdir, refs)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/ex=
porter.py",
line 27, in export_repo
    exporter.export_repo(refs)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 246, in export_repo
    exported =3D self.export_revision(ctx) or exported
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 215, in export_revision
    self.export_files(ctx)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 190, in export_files
    self.write_file(ctx, name, idnum)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 105, in write_file
    self.write_blob(data, idnum)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 99, in write_blob
    self.write_data(data)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 91, in write_data
    self.write(data, LF)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 52, in write
    sys.stdout.write(msg)
IOError: [Errno 32] Broken pipe

Nope.

All right, let's go back to hg v1.9 (Jun 2011).

# passed all 14 test(s)

Yay!

% git clone hg::~/dev/hg
Cloning into 'hg'...
progress Exported revision 0.
progress Exported revision 1000.
fatal: Missing space before < in ident string: Anupam
Kapoor<anupam.kapoor@gmail.com> <none@none> 1127407335 -0700
fast-import: dumping crash report to /tmp/hg/.git/fast_import_crash_186=
46
fatal: Error while running fast-import
Traceback (most recent call last):
  File "/opt/git-2/libexec/git-core/git-remote-hg", line 101, in
<module>
    sys.exit(HgRemoteHelper().main(sys.argv))
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/helpe=
r.py",
line 204, in main
    more =3D self.read_one_line(repo)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/helpe=
r.py",
line 169, in read_one_line
    func(repo, cmdline)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/helpe=
r.py",
line 108, in do_import
    repo.exporter.export_repo(repo.gitdir, refs)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/ex=
porter.py",
line 27, in export_repo
    exporter.export_repo(refs)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 246, in export_repo
    exported =3D self.export_revision(ctx) or exported
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 215, in export_revision
    self.export_files(ctx)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 190, in export_files
    self.write_file(ctx, name, idnum)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 105, in write_file
    self.write_blob(data, idnum)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 99, in write_blob
    self.write_data(data)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 91, in write_data
    self.write(data, LF)
  File "/opt/git-2/lib/python2.7/site-packages/git_remote_helpers/hg/hg=
export.py",
line 52, in write
    sys.stdout.write(msg)
IOError: [Errno 32] Broken pipe

Still doesn't work.

Let's try msysgit.

% git clone hg::~/dev/hg
Cloning into 'hg'...
progress Exported revision 0.
progress Exported revision 1000.
progress Exported revision 2000.
progress Exported revision 3000.
progress Exported revision 4000.
progress Exported revision 5000.
progress Exported revision 6000.
progress Exported revision 7000.
progress Exported revision 8000.
progress Exported revision 9000.
progress Exported revision 10000.
progress Exported revision 11000.
progress Exported revision 12000.
progress Exported revision 13000.
progress Exported revision 14000.
progress Exported revision 15000.
progress Exported revision 16000.
progress Exported revision 17000.

=46inally!

Let's run my tests:

test.sh:
# failed 1 among 1 test(s)

test-bidi.sh:
# failed 5 among 6 test(s)

test-hg-git.sh
# failed 9 among 10 test(s)

Other than the setup tests which really don't exercise any code, all
the tests fail.

And it's not only a silly error like couldn't find remote-hg; the
tests do really fail:

Traceback (most recent call last):
  File "/home/felipec/dev/git-other-remote-hg/git-remote-hg", line
101, in <module>
    sys.exit(HgRemoteHelper().main(sys.argv))
  File "/home/felipec/dev/git-other-remote-hg/t/../git_remote_helpers/b=
uild/lib/git_remote_helpers/helper.py",
line 204, in main
    more =3D self.read_one_line(repo)
  File "/home/felipec/dev/git-other-remote-hg/t/../git_remote_helpers/b=
uild/lib/git_remote_helpers/helper.py",
line 169, in read_one_line
    func(repo, cmdline)
  File "/home/felipec/dev/git-other-remote-hg/t/../git_remote_helpers/b=
uild/lib/git_remote_helpers/helper.py",
line 122, in do_export
    localrepo.importer.do_import(localrepo.gitdir)
  File "/home/felipec/dev/git-other-remote-hg/t/../git_remote_helpers/b=
uild/lib/git_remote_helpers/hg/importer.py",
line 27, in do_import
    processor.parseMany(sources, parser.ImportParser, procc)
  File "/home/felipec/dev/git-other-remote-hg/t/../git_remote_helpers/b=
uild/lib/git_remote_helpers/fastimport/processor.py",
line 219, in parseMany
    processor.process(parser.parse())
  File "/home/felipec/dev/git-other-remote-hg/t/../git_remote_helpers/b=
uild/lib/git_remote_helpers/fastimport/processor.py",
line 76, in process
    handler(self, cmd)
  File "/home/felipec/dev/git-other-remote-hg/t/../git_remote_helpers/b=
uild/lib/git_remote_helpers/hg/hgimport.py",
line 262, in commit_handler
    self.idmap[cmd.id] =3D self.putcommit(modified, modes, copies, cmt)
  File "/home/felipec/dev/git-other-remote-hg/t/../git_remote_helpers/b=
uild/lib/git_remote_helpers/hg/hgimport.py",
line 294, in putcommit
    self.repo.commitctx(ctx)
  File "/home/felipec/dev/hg/mercurial/localrepo.py", line 1112, in com=
mitctx
    user, ctx.date(), ctx.extra().copy())
  File "/home/felipec/dev/hg/mercurial/changelog.py", line 213, in add
    user, desc =3D encoding.fromlocal(user), encoding.fromlocal(desc)
  File "/home/felipec/dev/hg/mercurial/encoding.py", line 133, in froml=
ocal
    raise error.Abort("decoding near '%s': %s!" % (sub, inst))
mercurial.error.Abort: decoding near 'add =C3=A4lph=C3=A0
': 'ascii' codec can't decode byte 0xc3 in position 4: ordinal not in
range(128)!

Let's gather what we have:

* msysgit: works in hg v2.2, but not hg v2.3
* yours: kind of works on hg v1.9, but not really
* Max's: works on hg v2.2, but not hg v2.3

None of them pass even one of my tests.

Now lets remove all the supposed required patches to git core:

# passed all 14 test(s)

But that doesn't really say much, these tests are _really_ simple.

How about performance?

 Performance counter stats for 'git clone hg::~/dev/hg':

     241391.332748 task-clock                #    1.387 CPUs utilized
            53,357 context-switches          #    0.221 K/sec
             3,797 CPU-migrations            #    0.016 K/sec
         1,258,346 page-faults               #    0.005 M/sec
   433,914,358,895 cycles                    #    1.798 GHz
   185,410,787,111 stalled-cycles-frontend   #   42.73% frontend cycles=
 idle
   <not supported> stalled-cycles-backend
   581,663,561,600 instructions              #    1.34  insns per cycle
                                             #    0.32  stalled cycles =
per insn
   101,993,199,721 branches                  #  422.522 M/sec
     5,208,212,657 branch-misses             #    5.11% of all branches

     174.038642915 seconds time elapsed

Compared to;

 Performance counter stats for 'git clone hg::~/dev/hg':

     412892.981091 task-clock                #    1.211 CPUs utilized
           200,029 context-switches          #    0.484 K/sec
             9,288 CPU-migrations            #    0.022 K/sec
           632,783 page-faults               #    0.002 M/sec
   741,785,312,967 cycles                    #    1.797 GHz
   306,533,270,745 stalled-cycles-frontend   #   41.32% frontend cycles=
 idle
   <not supported> stalled-cycles-backend
 1,012,488,224,809 instructions              #    1.36  insns per cycle
                                             #    0.30  stalled cycles =
per insn
   168,056,255,731 branches                  #  407.021 M/sec
     9,528,432,325 branch-misses             #    5.67% of all branches

     340.976843750 seconds time elapsed

Looks like there's something to improve in this area, but I wouldn't
be surprised if the reason for the better performance is that
something is not being done. I'll investigate.

And all this for the low price of:

 .gitignore                                    |   1 +
 Makefile                                      |   1 +
 git-remote-hg.py                              | 101 +++++++++++
 git-remote-testgit.py                         | 295
++++++------------------------
 git_remote_helpers/fastimport/commands.py     | 469
+++++++++++++++++++++++++++++++++++++++++++++++
 git_remote_helpers/fastimport/dates.py        |  79 ++++++++
 git_remote_helpers/fastimport/errors.py       | 182 ++++++++++++++++++=
+
 git_remote_helpers/fastimport/head_tracker.py |  47 +++++
 git_remote_helpers/fastimport/helpers.py      |  88 +++++++++
 git_remote_helpers/fastimport/idmapfile.py    |  65 +++++++
 git_remote_helpers/fastimport/parser.py       | 621
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git_remote_helpers/fastimport/processor.py    | 222 ++++++++++++++++++=
+++++
 git_remote_helpers/git/importer.py            |  30 +--
 git_remote_helpers/git/repo.py                |   8 +-
 git_remote_helpers/helper.py                  | 207 ++++++++++++++++++=
+++
 git_remote_helpers/hg/exporter.py             |  29 +++
 git_remote_helpers/hg/hg.py                   | 126 +++++++++++++
 git_remote_helpers/hg/hgexport.py             | 280
++++++++++++++++++++++++++++
 git_remote_helpers/hg/hgimport.py             | 401
+++++++++++++++++++++++++++++++++++++++++
 git_remote_helpers/hg/importer.py             |  29 +++
 git_remote_helpers/hg/non_local.py            |  51 ++++++
 git_remote_helpers/hg/util.py                 |  14 ++
 git_remote_helpers/setup.py                   |   3 +-
 t/t5800-remote-helpers.sh                     |  19 ++
 t/t5801-remote-hg.sh                          | 143 +++++++++++++++
 25 files changed, 3242 insertions(+), 269 deletions(-)

Compared to:

 contrib/remote-hg/Makefile       |  13 ++
 contrib/remote-hg/git-remote-hg  | 780
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 contrib/remote-hg/test-bidi.sh   | 241 ++++++++++++++++++++++++
 contrib/remote-hg/test-hg-git.sh | 464
+++++++++++++++++++++++++++++++++++++++++++++
 contrib/remote-hg/test.sh        |  45 +++++
 5 files changed, 1543 insertions(+)

Now, sure, I am biased, but the truth is I don't know of a single
feature that this remote-hg supports that my version doesn't. If
there's any, I'm all ears; I'll implement it right away.

At no point in time did I ever suggested this code to be thrown away,
but if there's any possibility salvaging some of this code, they only
way I see it is if I myself do it, because nobody has stepped up to
work on this. And quite frankly, I think I've already done more than
enough, so...

Cheers.

--
=46elipe Contreras

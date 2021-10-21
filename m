Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A17C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBF960E8C
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhJUL7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:59:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:43545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231297AbhJUL7X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817427;
        bh=D4OfS2CSxkbKlVAAFrk/lrJwdJdLQqcmAYGc1iqv6vc=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=bf5ao8QF1zZGxabs2mU5/uABc+qtmJJV7U2rno7rhowIzQsDgxJ+H6DtE2qNRfsKf
         +1FV5MiVmzglBYkGT9zPFduh5PTS9gNQQnNVGIkRDyZXIljAVLeXA8g/9PTZDmG488
         HFDS+ABGXGDgfQFZGtEY8KM5NUJ7f+5wCqprPr8Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIx3I-1mOcTQ4BcA-00KNKX for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:57:07 +0200
Date:   Thu, 21 Oct 2021 13:57:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] Improving Git UX
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-841519636-1634817213=:56"
Content-ID: <nycvar.QRO.7.76.6.2110211357030.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:8z3/DK6YOLB595aqlEubrOvOF+YGGUTITqcKr98yt2VBFxg0+gP
 JAL8wlIIR44LidKoCRiqkklKs06X3R7gzD9UdMxd2qfdF/L6AABvga/6U9fl71YOFy9nZlX
 bc9aY9Gsy0tRirEFjOR+PX4BrPTeFaVDYODSGYtHCa2TWacAiAeYQeIs36BJORV6BJRMNmu
 yzCFZH+9T33cIDZU2rMQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n7OYWX80c9I=:DqB2pFwtoHsdfPGCrsKgAM
 zxE+qtOr01LgajN/66MOjphQo99uyuryI7/XZGAM12fbuFw1Wl5wkZFzThVSjQiGgtW96SZet
 BCnVFvLPuydqs/aIE3dyEAGZq8Y8MW9AYbbsvey21PjN0l2EEk8dnopSPgzC6Vdl4VIPbKbEV
 VG/4iftpkiwhAFUJJq5vbeqjijfR3dwo40ggtK4LpbNqQxNaPkCpNLVCX65gtZ9mYfMsQGj3k
 JRxzS8pMkdX4DGLn4VoXHSHXNqkZq9/0zOflTk4P3sAsBhCC4R6lzf+xt2Qv0Gwa6ita8F5pY
 U7uz5VCMvpO8alW+KMabtvcW3qB3j9N2Dmw+cdah0vKpoI47ARpJdXGvkAuRstv+bGQl+64QP
 glLJNWG13BCWPum4P/cqmDFgpZbR8k4WXpRX83LbriRdLptZ7WYxVWE8AYq4CdNTfhQkeNsXX
 CfgGFRgx4LSvWr6QiQVVJkzcLpht+KVBY8RwXzIsx7nSmulBDGrQ9uVfanVAYNRUoWwnDy0H/
 YT5cFBT07qLZtFI4gK2PrgVFOAoiCM2x12KIcLpq2nVYwL1/XA4r5dfk6Uaz6MPmJqXvNqm2i
 exQEAW8QDwEcE42WxPCrgLFEA1D9gQohNuapAcSdAnlezYHkcCbWztUOeJ+nGktpReURcNseI
 we0KzC4ArHX+ElaMU4swpqc8kte0hbydH57YLzDdp2UGVRZ7Mj9JJJh7Lr7vmBXvkXZqqw2EY
 upfT/BSHNXlIJTVGT/tWDW4nuLvPmNts4rP5ZJRrxPtfngMmxvb2sPKjZ3t2HrNN5RRDC1eQh
 AsIf3XpPVPrNFbleZgG//1BZE8O6NbkD8EGLWoGXqDk9mplLEODax3IA3sfmNQJwlbSO03wqi
 juKSeVZTAt+Gb7iaNnilr5neBV7IE4rsY45y4BQ/Dj9Qf3qKlXmJqBOQZ+5HY/WUlwhW1Qegf
 AJkoy88aScYz1xVlg2xVb80/Nw8rwuOx5lLvJAB+pUPKzohyoCIMo9BbmAkZWG2xdndEEdpZu
 n35TRB5Wa9JgIT03K8FnDUhysbagakRyu1SeW7DwXPjteeVEqtcOFBl4l82HRUn49+Zpn0UVr
 MWIYSx/EK0Arxo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-841519636-1634817213=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110211357031.56@tvgsbejvaqbjf.bet>

This session was led by Johannes "Dscho" Schindelin. Supporting cast:
Jonathan "jrnieder" Nieder, brian m. carlson, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason, CB
Bailey, Phillip Wood, and Emily Shaffer.

Notes:

 1.  A serious problem! ~=C2=BD of blog posts about Git start by ridiculin=
g the
     command-line interface of Git

 2.  Is very flexible, and that flexibility is reflected in the user inter=
face

 3.  On the other hand, it could be a lot easier to use. Example: GitHub C=
LI in
     Go, tries not to supplant Git but gives a really good user experience
     interacting with GitHub-specific entities like PRs and Issues. Everyt=
hing
     you can do day-to-day in the web UI you can do in the command line, a=
nd
     it=E2=80=99s scriptable

 4.  Excellent discoverability. Never needed to check the manual. Well des=
igned
     interface, good command line completion.

 5.  What would it take to revamp Git=E2=80=99s user interface?

 6.  =E2=80=9Cgit restore=E2=80=9D example

     1. Dscho doesn=E2=80=99t like it, feels wrong

     2. Designed by a software engineer, not a designer

     3. jrnieder: The manpage is pretty clear about =E2=80=9Cthis is exper=
imental,
        we=E2=80=99re willing to modify it based on feedback=E2=80=9D. Is =
there information we
        can gather and work with a designer to improve it?

     4. brian: =E2=80=9CI don=E2=80=99t know how to use it=E2=80=9D is val=
uable feedback. Maybe the
        documentation is failing? Etc

     5. Can be a sign of excessive complexity or of it relying on too much
        previous knowledge to use

 7.  =C3=86var: On switch/restore in particular, there was a recent discus=
sion.

     1. Ultimately came down to inconsistency with other commands in the s=
ame
        area

     2. I gave some suggestions

     3. Some patches started, there was some trepidation about making chan=
ges,
        though

 8.  Dscho: Is working one command at a time too incremental?

     1. Inconsistencies between different commands

     2. =E2=80=9Cgit add -A=E2=80=9D exists, =E2=80=9Cgit commit -A=E2=80=
=9D doesn=E2=80=99t

     3. Are those the most pressing problems? I don=E2=80=99t even know th=
at

 9.  Want guidance from user interface experts that work on the command li=
ne

 10. gh command involved contractors that are no longer with GitHub

 11. CB: The =E2=80=9Cpip=E2=80=9D project is doing UX research. I don=E2=
=80=99t know who commissioned
     it. Got UX experts to design study:
     https://pip.pypa.io/en/latest/ux_research_design/

 12. Phillip: The inconsistency between 'checkout -b' and 'switch -c' was
     deliberate in the hope that '-c' for 'create' would be easier for use=
rs to
     understand but ends up being confusing.

 13. jrnieder: we should not expect an =E2=80=9Cangel=E2=80=9D to swoop in=
 and solve all our
     problems for us. It=E2=80=99s more about how do we build this skill w=
ithin the Git
     project (by improving our own skills or attracting new contributors)

 14. We should also consider that there are many people on the mailing lis=
t
     with plenty of backgrounds, we might just need to band together to ge=
t it
     done

 15. Emily: maybe we can get some training (maybe the SFC could fund it, o=
r
     others in the Git ecosystem)

 16. jrnieder: training is easier to fund than a permanent engagement

 17. brian: if we had this expertise, we could probably make better decisi=
ons
     in the future

 18. =C3=86var: Conservancy could potentially find someone, but funding a =
different
     matter

 19. jrnieder: neutrality not all that important in this context, finding
     funding at Google or GitHub should be easy

 20. =C3=86var: often comes down to these consistencies. Getting anywhere =
with that
     might just be a long slog.

 21. Phillip Wood: checkout -b vs switch -c inconsistency was deliberate, =
in
     that =E2=80=9C-c=E2=80=9D for create is meant to be easier for a new =
user

 22. Dscho: Good first step is getting the UX design basics (training), I=
=E2=80=99ll
     look for funding

 23. Example: when I just run =E2=80=9Cgit=E2=80=9D with no other options,=
 can that output be
     more helpful? =E2=80=9Cgh=E2=80=9D has a nice overview when I run it.

 24. =C3=86var: That in particular was improved years ago

     1. Dscho: Oh! Good. Might be possible to keep improving along those l=
ines.

     2. Dscho: Sounds like we have a good path forward. \o/

 25. hallway conversation

     1. the index as a UI concept, what if we didn=E2=80=99t have it?

     2. learning curve design space

     3. how much does telemetry help us?

     4. popcon-style telemetry

     5. statistical rigor in surveys

--8323328-841519636-1634817213=:56--

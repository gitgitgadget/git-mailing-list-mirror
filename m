Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0CECAAD4
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 09:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiICJ3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Sep 2022 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiICJ3p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 05:29:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A71B7A7
        for <git@vger.kernel.org>; Sat,  3 Sep 2022 02:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662197375;
        bh=/vvwfwuAaM7lw7Uskj0QM6IdmXVriKsvoF4n7/kJB64=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SdAohklZ9pOK4QIIkiQi8nfDKKMulIRzJ3At9J8zGEqywaTX5dzG8rVDt4rXC6ljj
         U3azoP+WYcGpZvvJbzKqcek9M2nfqiMK3naqYdwIqpnTL+AllmhcFlAeE/HjHW+OI3
         DqqHOdcMHr4OSXatjYRnnWCGkGYY5YBf3rlrNmzY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QJJ-1oVEPi09WX-001SiE; Sat, 03
 Sep 2022 11:29:35 +0200
Date:   Sat, 3 Sep 2022 11:29:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH] embargoed releases: also describe the git-security list
 and the process
In-Reply-To: <xmqqwnal7gc9.fsf@gitster.g>
Message-ID: <161877q5-843n-q73q-6q3q-sq2664s6q340@tzk.qr>
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com> <xmqqwnal7gc9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KF+XsTz5iWRZBkXnaaCM6GujerVdaKzk+VPf77QOH7iKjssZxM3
 SahuhiSe05iQrHakMK55FLLWh9aBFCMu3u5DoJqUEQDi4yW9EfMgOu+ZuH3JKDuuVtBbRR8
 Sba1tKdtabr/bTgFN+l29LJJy4Lrze3/rjwjDGG7mZR+lEvia7ShPaDTD9oVmZD247R+oyq
 pd9lcUmofRkP8nT+kQhJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Y+k+lUUWDk=:5LvApDLJun5bWkrxSTtcNK
 0+7/1/6Iyv4fAo91paxd3JFsCorV6rM8a5JdNaLRUvfXj50U4e7Gjle3nXc3M0U0449SwNOoD
 743kSYbRmSi3GCiQLwMys1ekIof41cVEP8imLG9Ftfa7o00GyyKGDC8iZ0wy9lr0oRWw/AaAX
 xa5CDxq2Df7z2E2A0KQE7KMykroUNt2IqZIVLJBEqVsC2spsQ6+GD8cK0zrQauVmYFigFXwHh
 FqxQRB8DumSChyywOP7glzWhoFHUWhtWjLmfQJ/Rf6moJ2NvjEQWCm0dLXlCSIp4tXZM62wat
 D/vSMiTSJZCYdlMmvTrB45Dn7AzPMptUxaoGOmiKb5kyy5G7h7cFXfNpUbHFvLGVkMP4VzxvZ
 1F8FhOFyNLkrNAtwiSYrkcUjcupm2X64aNQiCCTUuHMorHWgw2FsDpImB5705xaUiCOp00IFM
 vKM7H8iqV6SrK1xU7gujE3D4CTV+pUzf7TIawWIppJpiGiWItbtSZZfFgyPiRmvW5P2nNegMX
 o0ye3y7K81oC86XIL+7N55eJPwe0UEu4FcUctrb3yluJTkgRoK7MAOqHmpCP02ThsmGvmgqcy
 +Vypo4C6s1WwTuLSXALD9RYSkHj4fOZ2JOtlYu6XhNy2bLq3kGexJmEAyL5jLyOE3cJiMWCkl
 SwNueE/VLK2iNHW9HmTyUNCPv9/enLTjfiQZmObmEwvO611MvmCbDEPdFM42Ii1u7kdly40kr
 oIYOT4hnnK5ZcS1Av3DASyVX6vieUBTDcIJM3ClrM2c5WHzfOwHjIu0Rn0zcL0bX4PkWKVT0H
 AoyTgC75bL0uEJ/EaDJQF3p8a4gfQ52cuBStRklB+o/rVYbmgAY4BNksLuMuHH6GoQCxOaQJ9
 tzsUJPkTuK7IKlV6oxzHr4xkWTxYI4XdHIx8iCokic5LD1MjI5+hjUyhPe8CTYYSy/QLAD4A8
 ofLGKcCmMjHw5dYhglFQs3gLkXaJnMWL/iysZEpeL9GKu+6xXsF5PU148P8CighM3rqgitS7p
 flW3LR8DTlli1C89oUYqWWFBvIda6R2O6icC5UxN1vLrq+X61HXKCZBvqbmELQ5mD/6ZUD2cb
 tZdZWrAVu280no+x+xyYJsoFCIUT3sskzDBuYJYOuSXY566CiWlYK4iO9pQ3WA2HvZpK7l6Rn
 ilP5yvgEQVexQ6dEwtS5lm4O35
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 2 Sep 2022, Junio C Hamano wrote:

> "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/D=
ocumentation/howto/coordinate-embargoed-releases.txt
> > index 601aae88e9a..43400fd6025 100644
> > --- a/Documentation/howto/coordinate-embargoed-releases.txt
> > +++ b/Documentation/howto/coordinate-embargoed-releases.txt
> > @@ -1,6 +1,121 @@
> >  Content-type: text/asciidoc
> > -Abstract: When a critical vulnerability is discovered and fixed, we f=
ollow this
> > - script to coordinate a public release.
> > +Abstract: When a vulnerability is reported, we follow these guideline=
s to
> > + assess the vulnerability, create and review a fix, and coordinate em=
bargoed
> > + security releases.
> > +
> > +The `git-security` mailing list
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> Dissapointingly, addition of these two new "=3D=3D=3D=3D=3D" underlined
> sections breaks the documentation build, which broke mi build
> locally as well as GitHub CI [*1*]
>
>  * https://github.com/git/git/runs/8162258928?check_suite_focus=3Dtrue#s=
tep:4:658
>
> Fix should hopefully be trivial, keep the original title line
>
>     How we coordinate embargoed releases
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> intact, and make these two new sections underlined with "-----",
> demoting their subsections one level down accordingly.

Here is a fixup, could you please apply this to the
`jr/embargoed-releases-doc` branch?

=2D- snip --
=46rom 32927af92e9ee7a0e22f90d8c162fca317ad6f6e Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 3 Sep 2022 11:23:03 +0200
Subject: [PATCH] fixup! embargoed releases: also describe the git-security
 list and the process

This fixes the build.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 .../howto/coordinate-embargoed-releases.txt    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/Docum=
entation/howto/coordinate-embargoed-releases.txt
index 43400fd6025..b6799647536 100644
=2D-- a/Documentation/howto/coordinate-embargoed-releases.txt
+++ b/Documentation/howto/coordinate-embargoed-releases.txt
@@ -4,7 +4,7 @@ Abstract: When a vulnerability is reported, we follow thes=
e guidelines to
  security releases.

 The `git-security` mailing list
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+-------------------------------

 Responsible disclosures of vulnerabilities, analysis, proposed fixes as
 well as the orchestration of coordinated embargoed releases all happen on=
 the
@@ -17,7 +17,7 @@ otherwise be made aware of attack vectors that could be =
exploited. "Lifting the
 embargo" refers to publishing the version that fixes the vulnerabilities.

 Audience of the `git-security` mailing list
=2D-------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Anybody may contact the `git-security` mailing list by sending an email
 to <git-security@googlegroups.com>, though the archive is closed to the
@@ -34,7 +34,7 @@ the timeline of the disclosure as well as aligning prior=
ities and
 requirements.

 Communications
=2D--------------
+~~~~~~~~~~~~~~

 If you are a stakeholder, it is a good idea to pay close attention to the
 discussions, as pertinent information may be buried in the middle of a li=
vely
@@ -46,7 +46,7 @@ mail threads are not usually structured specifically to =
communicate
 agreements, assessments or timelines.

 A bug's life: Typical timeline
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+------------------------------

 - A bug is reported to the `git-security` mailing list.

@@ -118,7 +118,7 @@ Note: The Git project makes no guarantees about timeli=
nes, but aims to keep
 embargoes reasonably short in the interest of keeping Git's users safe.

 How we coordinate embargoed releases
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+------------------------------------

 To protect Git users from critical vulnerabilities, we do not just releas=
e
 fixed versions like regular maintenance releases. Instead, we coordinate
@@ -127,7 +127,7 @@ date. That way, users will have a chance to upgrade on=
 that date, no matter
 what Operating System or distribution they run.

 Open a Security Advisory draft
=2D------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 The first step is to https://github.com/git/git/security/advisories/new[o=
pen
 an advisory]. Technically, this is not necessary. However, it is the most
@@ -135,7 +135,7 @@ convenient way to obtain the CVE number and it give us=
 a private repository
 associated with it that can be used to collaborate on a fix.

 Notifying the Linux distributions
=2D---------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 At most two weeks before release date, we need to send a notification to
 <distros@vs.openwall.org>, preferably less than 7 days before the release=
 date.
@@ -166,7 +166,7 @@ created using a command like this:
 	tar cJvf cve-xxx.bundle.tar.xz cve-xxx.bundle

 Example mail to distros@vs.openwall.org
=2D---------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 ....
 To: distros@vs.openwall.org
@@ -202,7 +202,7 @@ Thanks,
 ....

 Example mail to oss-security@lists.openwall.com
=2D-----------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 ....
 To: oss-security@lists.openwall.com
=2D-
2.37.0.rc2.windows.1.7.g45a475aeb84
=2D- snap --

> But I care more about procedural gap because this should have been
> something the submitter could have noticed at their end.  I somehow
> trusted that GitGitGadget would run preflight CI tests before
> accepting /submit, but if not, perhaps we should?

Sadly, our CI definitions are too flaky to enforce that. We had looked
into that, but even though the Perforce situation seems to be a _lot_
better these days than it used to be, even the several weeks of broken
FreeBSD builds simply preclude making them a prerequisite.

In this instance, it is still my fault that the breakage was ignored
before submitting: Julia had asked me whether she should wait for the PR
build to finish, and I claimed that there is no need to wait because it is
a documentation-only change (and I erroneously assumed that this document
would not be built because it is not shown on https://git-scm.com/docs).

Ciao,
Dscho

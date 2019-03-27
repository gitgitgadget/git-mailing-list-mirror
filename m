Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD0720248
	for <e@80x24.org>; Wed, 27 Mar 2019 22:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfC0WXR (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 18:23:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:59659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbfC0WXR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 18:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553725387;
        bh=2hzcO3igmJu1TSnz3VDWwbOGAOUyTR275xwHtvqEA+o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ljRJUJzCZZPpJ661DNFZRwRlnmxtFJoIpXfFfW+nuiQ6Scbfes8ibf1TMVwNTtXig
         yVUH3Y/44VHH/CaTbaCkhtjv9xerV35BKz+jaSXWT2MQkAb1NgJDue5Rj7VeLPImRd
         AfwJdp5jsKkCZa4WvA4lSIZMYlURsVLEi9r7yYuc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Le5bY-1gdBnb2ebs-00ppxd; Wed, 27
 Mar 2019 23:23:07 +0100
Date:   Wed, 27 Mar 2019 23:23:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] docs: do not document the `git remote-testgit`
 command
In-Reply-To: <87a7hhbszc.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903272317550.41@tvgsbejvaqbjf.bet>
References: <pull.162.git.gitgitgadget@gmail.com> <pull.162.v2.git.gitgitgadget@gmail.com> <810d2c5a94b40544652c97ffa644b29e0db8af82.1553550094.git.gitgitgadget@gmail.com> <87a7hhbszc.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1122868800-1553725389=:41"
X-Provags-ID: V03:K1:nlKiExfwUKnuncl8A1zzhpPE1jsMWJ+uOtYhSQQExXspXO5vB0L
 EGTDNmRiE2f64FMABSApvFAdqLjjdP3RPFvDo2UsmF2ARmxA88bEWG8hdR4+tNkUlNWagyS
 rrz+jteCiymvr78/Crg8Gc3PdfqDoY+W2I4vs5YXh9+2kmjma1Nrg0lIdDgL4Fk1p/YHWkx
 S6OZHt7lgZSK5ganTxs6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gIOR9hrDpSU=:2WfhCmkGELds9EGmdOeBzG
 VNuYQOVgZHSc2lTmAH9rIOvtv1+QCsY3ve3vrNrCqBLdiA3AgnV43wbc+FNoL3z/A7863qUhj
 LvOZt0nohwG7bfL/WYxqF6+aksXMHvogvhpDOeWM9u9hBfNahpm14MJ7947K7cAGCzsck9+33
 0epOjrQPFXF+BRdYMFGpkUaNHb2TDlv56ZkAMiAABOWFbYEFFMZJnKtCDHbNTbR4ambaQnxPY
 NOjmr3KWF3rrf4RDsSyy9XoLZxK832QSvYQzys1rqluPVL8GBpYx+ToFe8lfce/wfY0FES4Z7
 hTn1FKUEWzY5BL7ZjPzF0131rbWCbJRsEsBEKtHbJ0vaNhsgRP4uAK3AMGs4zAh42iWsMFm4a
 r7sk7lqvfIkUuK4EEHl43+GsOSPkGjXzfoOM7E5U7388v9HQMU7W41Id++wP4/vMjEvV6LCqQ
 O5xQzc97ofjpiGKTO8fgil1/Qy1046Sxe3Ug4vAHNkwZGnkbLTXWuArFlJgaSBW3EmD9nR3sW
 nr3n5ypSRFz0SW76PzDxjq5E6EmQ8exfMwR+Q5IbRYyajJsWQfIeJtE20FfiRLFJyNp+HNvbo
 Uw5Mm9iwFhkEMou4kxOj2h31fAnikMl3JMICWS+ULakrzNiLZPP0qNdR1fhGGBXvHD52SEgnr
 iCw0uGlz7FdN3p/5R4i1a/9zdBvct2eAg2RRe70TQZNJdwVQbwXh+En2HjVj+Q0KIw31wFLbO
 BGCWIn8ZwZfksohUKgFWnDzGRh/QXVia/TcdhAvScyXBPylWNbWCRDYkfwnC2pErvCzLASBNd
 k+zwPu66iON/pwy+6VpnXJTfNArCNwB9boitA5RcZYNpH3C36p8AQzvFJ9lsz8HlzCa+VbFkD
 GMCy6utqGPKG/6UJ6dw5LkrONR7ows4qtqRxQukZA3/CgySWUMRinbsx4+cQsUIxJYpktYRg4
 KahisstEGdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1122868800-1553725389=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 26 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Mon, Mar 25 2019, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Since 7ded055401 (build: do not install git-remote-testgit, 2013-06-07=
),
> > we do not install it. Therefore it makes no sense to document it,
> > either.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/git-remote-testgit.txt | 30 ---------------------------=
-
> >  Documentation/gitremote-helpers.txt  |  2 --
> >  2 files changed, 32 deletions(-)
> >  delete mode 100644 Documentation/git-remote-testgit.txt
> >
> > diff --git a/Documentation/git-remote-testgit.txt b/Documentation/git-=
remote-testgit.txt
> > deleted file mode 100644
> > index b45bfebba5..0000000000
> > --- a/Documentation/git-remote-testgit.txt
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -git-remote-testgit(1)
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -NAME
> > -----
> > -git-remote-testgit - Example remote-helper
> > -
> > -
> > -SYNOPSIS
> > ---------
> > -[verse]
> > -git clone testgit::<source-repo> [<destination>]
> > -
> > -DESCRIPTION
> > ------------
> > -
> > -This command is a simple remote-helper, that is used both as a
> > -testcase for the remote-helper functionality, and as an example to
> > -show remote-helper authors one possible implementation.
> > -
> > -The best way to learn more is to read the comments and source code in
> > -'git-remote-testgit'.
> > -
> > -SEE ALSO
> > ---------
> > -linkgit:gitremote-helpers[7]
> > -
> > -GIT
> > ----
> > -Part of the linkgit:git[1] suite
> > diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitre=
mote-helpers.txt
> > index 34a3e60d08..2fc4007525 100644
> > --- a/Documentation/gitremote-helpers.txt
> > +++ b/Documentation/gitremote-helpers.txt
> > @@ -513,8 +513,6 @@ linkgit:git-remote-ext[1]
> >
> >  linkgit:git-remote-fd[1]
> >
> > -linkgit:git-remote-testgit[1]
> > -
> >  linkgit:git-fast-import[1]
>
> I wonder if it should be moved into e.g. t/helper or somesuch at this
> point...

Sure.

One thing to keep in mind is that we cannot change the actual name of the
executable, as it needs to have the format `git-remote-*`, and cannot
require a first argument `testgit`, to be able to perform its purpose.

We do have a precedent for that kind of scenario: `test-fake-ssh`. It is
also not folded into `test-tool`, and it is copied while changing the name
to `ssh`, as required to fulfill its mission.

I am not totally enthusiastic about this because this is what prevents
Git's test suite from running in a RAM disk on Windows, IIRC: I have not
been able to convince my RAM disk provider to allow executables stored on
it to be executed.

Ciao,
Dscho

--8323328-1122868800-1553725389=:41--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA7F20281
	for <e@80x24.org>; Fri, 29 Sep 2017 12:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbdI2MPt (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 08:15:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:61967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbdI2MPq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 08:15:46 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCxfb-1e6OeB0c6N-009kkm; Fri, 29
 Sep 2017 14:15:36 +0200
Date:   Fri, 29 Sep 2017 14:15:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
In-Reply-To: <905a4adf-a6bd-7484-f81c-0381f7200cfc@suse.de>
Message-ID: <alpine.DEB.2.21.1.1709291402440.40514@virtualbox>
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com> <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com> <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709151816390.219280@virtualbox> <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709152214100.219280@virtualbox> <xmqq377nwtbe.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709181637420.219280@virtualbox> <xmqqbmm7s9ja.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709191733450.219280@virtualbox>
 <905a4adf-a6bd-7484-f81c-0381f7200cfc@suse.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1363798904-1506687336=:40514"
X-Provags-ID: V03:K0:6sRleSq1Yu9ZqrD/nH7g6K+ya2daXVC5UDhTUPigjh492u3OiU3
 mGX+QBA1/6HZRJWIXecNggyEwwn35dAEOhIIgg/tsaZO2Si0YmkIZ5PUCgkwu5ae8bdTEAu
 usu6lFe9Y4UzwuUyGfP23laMChZ/rV+1bWOQrg3ssk89w9+zUGsXv5be3HLFuPq1XRDgwlU
 dRWecX7RPEOGB6QlGV9tQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2LoKu3Vvb4Q=:mPBcARxxhKZAEn6m5IxVnA
 +OXe8Ohk5WLKm1E+T6gjQDKY6qQcsoW4gfjHiEQXXRO+4xF2YJPhYxksHN4uVMK3Zn+/M9gBP
 pbRsPZkpvJS4ep6rubwJgb7fUAxM92QyjZ+I4a8nB+PLungE+QPWW5NFkZUrB1w+GLGheqU2Z
 35n/wDFD3skd0kDRjUlaXEsKlfb2U+t2FYGOlSzfs9Uk6d60u5EkBR4Hl2XESyHtK55R2ZUNn
 lqIv/2KtA23AHxO0UZbCuFMj8MF8oCI0eq4gnpFxncMFhgmMvsfaz9hvNJNgHcShRdfv3Efef
 VWzJtyx3aGec4F7nmJFin1CwRIIzYo1pjV4/9yv52blhjTn5HA+7IyUGFlGpfQEMnj7Hoj/r1
 UJLrLx8mWWthBLL5/gUEWebrFV6wkoCZyRL4TKCBqHb+fEyYVLQDTgqRNalwdhblend+nYr16
 7i4dmBF8O8ULRSjOD4aDitBpfchGcPOAjPPgweCDV5NGBI8tzVlyglJpq07y1sEb4MUR+ly3e
 Fl8J7XQDLiY0aJ3RP5I3NGu04iztGg3RvPT0W+uk+woFdniOLhFlMUUYh7W2FGDWiunWWdsJq
 799OdDWzSAYvmoTM+pabCch3vE3UizxW+QUFptkzZyHz/Nk0H/wfxgs9lK1pfH2cWGFvJuEDh
 fh8SEDLvGtwyHzMW5ATjihZyRoJUWTdpnRp92XNCbhDDjgXR+xJl09IRFZVudNTuuEo9TLKfC
 JggXE73NapM9nN5nxqMayBWx0OTenNHdlZ4JW6ZC38f0xxu0NawORr+GWRyCcgv6KVj6hLvB0
 +WRgg8VS2Sz5RFhuenGIzIq9bIo/AKg14ifPAqKb2gF71pYH4U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1363798904-1506687336=:40514
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Nicolas,

On Tue, 19 Sep 2017, Nicolas Morey-Chaisemartin wrote:

> Le 19/09/2017 =C3=A0 17:43, Johannes Schindelin a =C3=A9crit=C2=A0:
> >
> > C'mon, don't *try* to misunderstand me.
> >
> > Of course there need to be updates as to the state of patch series.
> >
> > It's just that mails only go *so* far when you need to connect and
> > aggregate information. You need the connection between the original pat=
ch
> > series, the latest unaddressed reviews, links to the branches, history =
of
> > the patch series' iterations, and ideally links to the repositories of =
the
> > contributors with *their* branch names. And then, of course, your verdi=
ct
> > as to the state of the patch series and your expectation what happens
> > next.
> >
> > To relate that, you are using a plain text format that is not well defi=
ned
> > and not structured, and certainly not machine-readable, for information
> > that is crucial for project management.
> >
> > What you need is a tool to aggregate this information, to help working
> > with it, to manage the project, and to be updated automatically. And to
> > publish this information continuously, without costing you extra effort=
=2E
> >
> > I understand that you started before GitHub existed, and before GitHub =
was
> > an option, the script-generated What's cooking mail was the best you co=
uld
> > do.
>=20
> Would something like patchwork fix your need ?

Maybe. Here is the link, for other interested parties:
http://jk.ozlabs.org/projects/patchwork/ and
https://github.com/getpatchwork/patchwork

> They now seems to have a REST API, which means it could probably be
> pluggeg into Junio's scripts and work seemlessly for him (or any other
> happy ML user) while other people can browse through the web interface.

It seems that patchwork's design calls for the communication still being
performed as previously, and just providing a web interface to search a
little more efficiently through the mails containing patch submissions.

Git's mailing list, of course, poses the problem to patchwork that the
status of any patch series is opaque to any automatic system that does not
specifically try to connect the What's cooking dot to the patch mail dots.

Also, a point that came up in a private discussion with another core Git
contributor this week: how many reviewers actually even so much as
test-compile, let alone look at the code in context? I am fairly certain
that none do, *just* because of the shortcomings of the process.

Patchwork would not address this, of course.

In my ideal world (in which there would be world peace, too, so it would
be pretty boring, therefore you should not put much stock into what I am
saying next), the direction would be the other way round: the tool should
not scrape the mailing list and make the results accessible via web
interface. Instead, the tool would let me sidestep the mailing list
altogether, using it just as a lossy communication medium (and keep the
lost information accessible in different ways). SubmitGit "threatened" to
allow me to do this: I could open a PR at https://github.com/git/git and
then hit a button and off it goes. SubmitGit stops there, though; If it
would have continued from there (and did not make the initial step
difficult by requiring some registration not everybody is comfortable
with), it would have fulfilled my wishes. Alas, it is written in Scala,
using a framework I am utterly unfamiliar with, so I could not do anything
about it.

Ciao,
Dscho
--8323329-1363798904-1506687336=:40514--

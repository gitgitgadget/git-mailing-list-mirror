Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD781FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 08:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbcHPIma (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 04:42:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:50345 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbcHPIm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 04:42:28 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MNq4h-1bX62x2dhb-007Waq; Tue, 16 Aug 2016 10:42:20
 +0200
Date:	Tue, 16 Aug 2016 10:42:19 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly
 platform-independent
In-Reply-To: <alpine.DEB.2.20.1608161026110.4924@virtualbox>
Message-ID: <alpine.DEB.2.20.1608161035320.4924@virtualbox>
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de> <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com> <xmqqoa4tg2yi.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608161026110.4924@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1110773165-1471336940=:4924"
X-Provags-ID: V03:K0:W1Fk0Tdd+qwMyeFEOtX/oYslr/Aqq13mb4Zrh6vstXP88yiEquc
 +PWy9YmMJcSfeqb+1otX46EVxGgFbaNNLcM5sPfiJPAxxisEuPZ46tagLqL+0q1+zfPArx2
 o+CxHiZffQW2KIGIFXiP+cAC2jvw68adui7P0zFGnAkQRtXQosyh75C+W1f3IJKK/PXqahj
 eLQR1hKzxiw8u7GuiP7bA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:yXfXBw72oOo=:TcZ0u9AkHe5n8JsG9mqmYD
 FbhsomHe8XZz+l87mrOwO+fT79LVNf6IiiM1QJHVbxZDfA2koMxAIQniBd1GWNudOolHrhIK3
 r+h81ibmjnVRFzF7SFE1JHJPybg0G1QJntljw5Xb0zMfk8lZwMEhXoFzWmFEkUwmrxt9xFKco
 4o7iIaJmSqtaGWSBTDk2uR9jPnmmxilClFlCNSz0LXnMTqGyoyCxVKp5Ett5ds92+D+sbSIHb
 om8WRDiKpJ4Nb9Z+N/YRY2zu++R0aqq5MmxK8KBoejkdbcTB3CHMzSotlPzSc3XJ4Gt6XGe9Y
 yTJdCZ6sLAfPba1Nsihb0looALXNy0MtByO+9I5+gJq/6+dS/0Y3VlG1VeXGY5cpLYR9GIIxR
 NgprNj3i1Fwyc016hT1PdHXJS09sJwDyJV0IJPk5msoSYugm5+SvZNHXmGoKl5se/gY5gPACE
 XEA3j3wXhWVU6+IXOCz7FXrBqBbacp2iiScFOY7jNGKDkV/0OmaAV7/8K+gj0J6w5KCbLUfrt
 AjAMAf6PedTYLgrn93hDDYOZ8Pglx6HIk/tW9bEadaZwUpfsTEZQm0ZfOrLSKt2t9KZmjQwBI
 F66XYA0DGyTwfnWlrQr9mZPFd8EAPCznTzVSY9d9pZ1hxV1JJx24YFXwgTpb/OF+UAdFVpO6P
 zifoM4TzeMSN08jm5vH5vbhb6QhXiCCNoz4JpF+HbPH0e/W1nmqp/MZFDmmv9FrdP/gvKuIvM
 7prGG998sAlOMYoDob+gNiPTWGfO2fJ26a7LgtocLDXpTvlAtTcBZy8krt63ObS3G2qCUPDlI
 L43loi/
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1110773165-1471336940=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Tue, 16 Aug 2016, Johannes Schindelin wrote:

> On Mon, 15 Aug 2016, Junio C Hamano wrote:
>=20
> > Junio C Hamano <gitster@pobox.com> writes:
> >=20
> > >> +test-lint-filenames:
> > >> +=09@illegal=3D"$$(git ls-files | grep '["*:<>?\\|]')"; \
> > >
> > > This pattern must exclude questionables on either NTFS or HFS+; it
> > > is ironic that it is not even sufficient to limit ourselves to the
> > > Portable Character Set [*1*], but such is life.
> > >
> > > By the way, doesn't ls-files take pathspec glob, saving one extra
> > > process to run grep?
>=20
> I specifically did not do that, sorry for omitting the rationale from the
> commit message. The reason why I have that grep is so that the backslash
> can also catch non-ASCII characters, such as "Hell=C3=B6-J=C3=BCni=C3=B6"=
=2E

And there is another very good reason to keep the grep: the problem I just
reported is *caused* by your avoiding the grep call.

In my tests, at least, `git ls-files '*\*' lists *all* files in
subdirectories. In other words, it matches the *forward* slash. This also
happens when I run the command in cmd.exe instead of Git Bash, meaning
that it is *not* caused by some MSYS2 path conversion from pseudo-Unix to
Windows paths. That only leaves the conclusion that some of our pathspec
code tries to be helpful and takes a backslash for a directory separator.

In light of these problems, and also in light of the fact that the
test-lint-filenames code is hardly performance critical, I am strongly in
favor of reverting to using grep.

Ciao,
Dscho
--8323329-1110773165-1471336940=:4924--

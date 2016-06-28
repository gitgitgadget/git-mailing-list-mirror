Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CEDB1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 10:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbcF1KHG (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 06:07:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:63587 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229AbcF1KHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 06:07:05 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MRjd7-1ats4d2GLZ-00T0cz; Tue, 28 Jun 2016 12:06:46
 +0200
Date:	Tue, 28 Jun 2016 12:06:44 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Git Mailing List <git@vger.kernel.org>,
	David Turner <novalis@novalis.org>,
	Junio C Hamano <gitster@pobox.com>,
	Keith McGuigan <kamggg@gmail.com>,
	David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v13 21/20] unix-socket.c: add stub implementation when
 unix sockets are not supported
In-Reply-To: <CACsJy8A2i9enBUtK+jcJmnChTddJBjd6O9LZfU9Tj2ikn8JqRg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1606281206100.12947@virtualbox>
References: <1466914464-10358-19-git-send-email-novalis@novalis.org> <20160626120928.14950-1-pclouds@gmail.com> <alpine.DEB.2.20.1606271413350.12947@virtualbox> <CACsJy8A2i9enBUtK+jcJmnChTddJBjd6O9LZfU9Tj2ikn8JqRg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1050725386-1467108406=:12947"
X-Provags-ID: V03:K0:4o+8maJcUnpN9Yq2tZpQ4Q9DN5VWcLwGvl5Nh0NuTU/5nokorV6
 3vuxN7F0tqk2Wg5OpnauTq67pa74L2DAxcuWaTiCN0qqkVRseD/+BLoDVJw+vU+TYx+ZpXE
 vyCKMluekYELy07iEH74UuH0cXCI0BxqLiYXfmWj5hrx+HXCcPk99eOv/huK4cO8fC1mzRE
 2vG5YDZudueQ8Ej2VnS4g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QMGVMIXirHc=:ojvbkNl6btKt/l4h/Equ+t
 LYx58zK9Km6a6JM8xtYw1bIYryLyuZtLO6TXMnj5uPLcC5b5vhgk0PVsZ8zAJ0Bk2czF9BxD/
 8m5CCDOutPeAUCL2/R93ctmJ6sAWBgmIEM9N2EqNSWvORA6TpS0mbsyeiTnbJiX0FTydzhNvt
 TNf7eO8RZ65umdwdhKAHDittN6NxfIJlccUpcI4wqD/8NH/RIxUa1Vcygu0bG15hjonGDnq4S
 wd3Fo8ZUiv9E0RHX831ca6JmqLyXb7muWGVFhtQzmLVRiizsev/3UhOJ3JzQ9lJeS92oq7gjS
 3SwgPgzwG9DFYrz3vG4n5MTxh4UBHV/OII0oSbtQ2NiYemdWNJaC9rvtzdi4/4NyqmWijmr9Z
 rY5zdxmi6qHDiZkvBY4V4L1SnjXDKdK0ncSCXmAt8DiNU4vGsWS7WD5X79inB/Q7pUvhuOapb
 29PtFtPTXFCruXwe9Vn0UPd+2/2+4QC+RR0aK1OOPWBdCl/RGJ49xXKobuAMhm68EIOHHlklb
 EK2LarR6cFJfGKeBEVJ+XfB0FZ5j4C0+/TeD8aWcS1jWfxhttkssnlFtcG/hz5BEqqPPQuBTE
 lu39GXLiQ0jEFf4zyKE8Zud+6jRCbOfeDkpvNW0UB/YAI/93GYCBYJ6Xg8RVdRI348FTVh4nB
 tzIcYEPZZs6IJGOjPfBbNZL9P05hKnnAywj4DXxIaE30R8kZrut2DA7hCOcwi9k1mtdGl9mIC
 nvVLKqeopBNWkk/EzacFhnmdLh0Hs+0f6JLz7WhELzzxj6iL+Sso8HtD94l0uJHdLPey6jiaZ
 gKmPuJF
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1050725386-1467108406=:12947
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duym

On Mon, 27 Jun 2016, Duy Nguyen wrote:

> On Mon, Jun 27, 2016 at 2:14 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sun, 26 Jun 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >
> >> This keeps #ifdef at the callee instead of caller, it's less messier.
> >>
> >> The caller in question is in read-cache.c which, unlike other
> >> unix-socket callers so far, is always built regardless of unix socket
> >> support. No extra handling (for ENOSYS) is needed because in this
> >> build, index-helper does not exist, $GIT_DIR/index-helper.sock does
> >> not exist, so no unix socket call is made by read-cache.c in the first
> >> place.
> >>
> >> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
> >> ---
> >
> > Heh, I made something very similar (although I did not update the errno=
 as
> > your patch does): https://github.com/git-for-windows/git/commit/919cb1d=
79
>=20
> Yours lacks the important "else" line in Makefile, so pick mine! :-D

Oh, I definitely prefer your patch over mine. I just meant to concur that
this needs fixing.

Ciao,
Dscho
--8323329-1050725386-1467108406=:12947--

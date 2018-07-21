Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450241F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeGUXd1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 19:33:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:54775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbeGUXd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 19:33:27 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmrZY-1gExJ728dQ-00h7aU; Sun, 22
 Jul 2018 00:38:57 +0200
Date:   Sun, 22 Jul 2018 00:38:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
In-Reply-To: <20180720215220.GB18502@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
References: <20180609205628.GB38834@genre.crustytoothpaste.net> <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com> <20180720215220.GB18502@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-680322618-1532212737=:71"
X-Provags-ID: V03:K1:mK6CdoJicLM9Ok1xIXHnUNe/QPLX+Je5emyR1eNz5Lg0pUtMN0o
 usJLzCo6JmX5G+84J2HrmeUs4kvx73essZePQDOtMrkT4+xxhhTXenM/dYEjT0Q8oUoRTDk
 5tVIk5wYhg3Op7to9n6sSyYWJvU6D8EEEqzcS7imAnSRb+Fub6PECqo/Ew5ox28J3VP65mJ
 W1vYgqz8pxNspjMiAmr5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gIM88+wFPZ0=:gbS1VcMMyT3DX6mrNfxfP+
 NetIISQfBT0fwh3+mGh6I8qlKMqGaVxnzculjp6ElQzgHnIiY+WNd1DlBnf8Qxj+brZ5UWVHc
 P7TctHEuoL92R2uwvWY2a6633jguOwEIZhMGDOlXVvDlmeEHB0DGyhgIb8m9hI2G4HZGpxG/V
 qM4RGafeCWpNf8PsSz6+tqb6qRKOMcJ+sR0xKRHRKIU8qlpaHAvUPuv6QIhVYYOtyo7AtskcJ
 UttJQt8pNv3YAhToXcB5XlDnvMs8cvJx9NzWW+E0yh+FctVPaodCg7YtZU6hU6CJXhyvDscN8
 9Zu6MZYu7XQYEBMnywGdyJe9NH2DODSCm9NXydSWPdDaa4iMVlAL5NP9X4vOpHKPjYQlhvRyi
 qVE8QgJRor9zAGfEszXRc2pyiMxc4khQjfAdHiHFqjztiTC8SO8MDTFxWwHJSZH/o8Cw9g+rc
 Nv4gkUZ989lcU+v5pCraa21xXUwHuq2+Rs71gqXpYnIOacs4pHG2Al6k0vvZ+oL3pOgsLOSAH
 bbYdpwWMVR+T95KQYEUCFuMhCeGLZ5Bjc7k4O4qsuLu0m5Doq+yzgzE8XNcVMTRD+U3PRqgoS
 7rb9MkFHbREOS73tu1+5XmEiN6O5f8o2rCYzbu8Fd4INr6KIzCgRKdXf5z/Q5jh93lD0GsUDC
 KYHfH5MoIi2KVdfEiAmvE0fjK5I7anDSOgOfmmyvsdy8hmqMSzgtINryoM9VoLa/+m+ongd9s
 z7fivMgCUHfssJ5mBabAjlHBOUrCA89rmGiv9fA1olQUYxtWoQmQXgfwWYbln+tdToGvO4nus
 7g8XN2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-680322618-1532212737=:71
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Brian,

On Fri, 20 Jul 2018, brian m. carlson wrote:

> On Mon, Jun 11, 2018 at 12:29:42PM -0700, Jonathan Nieder wrote:
> > My understanding of the discussion so far:
> >=20
> > Keccak team encourages us[1] to consider a variant like K12 instead of
> > SHA3.
> >=20
> > AGL explains[2] that the algorithms considered all seem like
> > reasonable choices and we should decide using factors like
> > implementation ease and performance.
> >=20
> > If we choose a Keccak-based function, AGL also[3] encourages using a
> > variant like K12 instead of SHA3.
> >=20
> > Dscho strongly prefers[4] SHA-256, because of
> > - wide implementation availability, including in future hardware
> > - has been widely analyzed
> > - is fast
> >=20
> > Yves Orton and Linus Torvalds prefer[5] SHA3 over SHA2 because of how
> > it is constructed.
>=20
> I know this discussion has sort of petered out, but I'd like to see if
> we can revive it.  I'm writing index v3 and having a decision would help
> me write tests for it.
>=20
> To summarize the discussion that's been had in addition to the above,
> =C3=86var has also stated a preference for SHA-256 and I would prefer BLA=
KE2b
> over SHA-256 over SHA3-256, although any of them would be fine.
>=20
> Are there other contributors who have a strong opinion?  Are there
> things I can do to help us coalesce around an option?

Do you really want to value contributors' opinion more than
cryptographers'? I mean, that's exactly what got us into this hard-coded
SHA-1 mess in the first place.

And to set the record straight: I do not have a strong preference of the
hash algorithm. But cryprographers I have the incredible luck to have
access to, by virtue of being a colleague, did mention their preference.

I see no good reason to just blow their advice into the wind.

Ciao,
Dscho
--8323328-680322618-1532212737=:71--

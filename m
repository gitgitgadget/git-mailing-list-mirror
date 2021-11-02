Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7980EC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6236E610FC
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhKBOh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:37:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:41825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhKBOhy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635863704;
        bh=iejApT9Wj9/KGc1WJOgOzHmQbY1q1otV2ZyJKRrHDJk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GZS9sKTk0Wj3B0GcOba9nHytKQCxUqh3bprDuLjrxBLQMlj9zS3yKiL28Valmdzk6
         D4w7ma2JGAu7Dt/ghsHsslgTueRI79m5N971gG6f2euwcy15Fgau68EG16fcIw4lGA
         3s5f2QbTYqXqTsNG3dt7QM3OXXKzWF1bi7rx/fPY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDIu-1mHgoS2gOu-00iFKO; Tue, 02
 Nov 2021 15:35:04 +0100
Date:   Tue, 2 Nov 2021 15:35:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/8] test-lib: add prerequisite for 64-bit platforms
In-Reply-To: <xmqqtugzh29w.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111021531070.56@tvgsbejvaqbjf.bet>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com> <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com> <489500bb1dcaffecab42672658990cfc26d52d7c.1635515959.git.gitgitgadget@gmail.com> <xmqqtugzh29w.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1221349285-1635863554=:56"
Content-ID: <nycvar.QRO.7.76.6.2111021534140.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:AIWqYwOZB1J0TsYEzIZLD58X6mzRt1+mReXhOFpN3zZ1GK5Olt6
 eSxP9axsY7DyUZM7OTJue8apbWY3EY4M0FTuQcNUBTed8HBsLx8W9JvXEGI+AdPdG8+ONos
 GFeeYWb8TqtWp0yoeXqnbvYq2dOxAnEzUHgjBUtzoCEDZe2X/m5TNO3Ic6+4T6zKb9dYvtK
 2kSaExt8OXldJhAcB5svg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q3d6lmGL2ZE=:UUcoxm5vMKdG6G/ebzCVSP
 yH+fr4YURtB6rhTINoR4nIrL6G/bqBVca9R5+MgdBooZgB4VBmnlSToen08ZfgxWJNf2KG+AB
 zlQNlG7lUOoMw1xzJV8LD3ZnvQaMk+Bt1rKN5hDwID8+qiCdSTgz1S5/e1jSa8XyAGti+lejY
 TXsFmPxX3Bn4Rod2T/NqcNOUAh91OmaYBaNRSJAjA8VZ7kt77cDHViOYmigz3OuX3aIf2RtRt
 hQzfNCU9cLg6X/IhL6ZXYakPE5k9+ftvE21mxH7lapeVcaQ6e9IO8cW1A+CFRoldzM0lDPSHu
 wkPGMFXqDb9ZqkEcsqnf7hM+/psTw2q3kEbinz+beoK36ktQn71RKrmhBvvaprSC8Ji1ZtVP/
 NRlx59orlNI7JbBq9s2QeVNb1iu4cBbZjldvigxC/PO3t3v0JX9AOZjWwg8SfInfdK/1MtyCj
 UuVDwCW6fh84yNOJb2uKLwmOv1WCB9C4bvcRXFpfsf95VRxE+OSZ/AQlxwZn1nWnU0tZY3oNW
 wrXfOSLIeoblnoE0RTRO+Rj6sI0Qo5i/fhYeogkxp1r8MB48Nl8ACipp5iy5ZtieTVzbsAnb+
 HQg9/TXqRPPtcl+hzfBa/jYptRSKWxnPBC7Fi4h/1TDUAwENetDjLUa0adG7I0Oc6Rl5GLusY
 jvAQ0Khulvhh6bHAAnBfruD8Jwsm8POk0Mvo9xM1deFYrV3V0/4QQrBx3FWaI73xonw4cqspT
 P3SMQYqZpgp93lW/oayGHqV51XClcD6e2z2t+lqu/2pk/dlLPMtIaxhRr2UrbtJ2/3wsX40YX
 AmUkcqNyxNRBwp2D9ncG1Xpid5Ik4d2A0SuzMbMXwao6t7Xbio4NMBf21BXYKVtT8ofc5zooJ
 BZBv4xVP5wI1xl3aFhcwFhbusJuqKazrlSnhSRIfMmD67Y+M88TmDr3WVvVqaefbtPKFMcXUI
 MeGlAGvjxH4ewapmoImnSASrQycV4VMzbxziiudNAP3dg2L6oAumxkriNHx2Zoj8b+RIZJHry
 Lxfoiq3iCMcnGIUrTaOqirElslpKA0YHOSXhidCPjZXo1A9avT3uODt8cEbNvDy0VPCRddkDD
 JhRYe9uuG8BhG8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1221349285-1635863554=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2111021534141.56@tvgsbejvaqbjf.bet>

Hi Junio,

On Fri, 29 Oct 2021, Junio C Hamano wrote:

> "Carlo Marcelo Arenas Bel=C3=B3n via GitGitGadget"
> <gitgitgadget@gmail.com> writes:
>
> > +test_lazy_prereq SIZE_T_IS_64BIT '
> > +	test 8 -eq "$(build_option sizeof-size_t)"
> > +'
> > +
> >  test_lazy_prereq LONG_IS_64BIT '
> >  	test 8 -le "$(build_option sizeof-long)"
> >  '
>
> In the longer run, LONG_IS_64BIT wants to be renamed to indicate
> that it is at least 64-bit long.  LONG_HAS_64BIT, perhaps?

Or `LONG_AT_LEAST_64BIT`. It does look as if the current users are asking
for that, not for precisely 64-bit.

> Obviously it can be left outside the scope of this series.

Definitely. The patch series already grew from 5 to 8 patches. We really
need to be more conscious of scope here.

Ciao,
Dscho

--8323328-1221349285-1635863554=:56--

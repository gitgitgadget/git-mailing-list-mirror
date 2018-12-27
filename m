Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E24211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 17:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeL0Ro7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 12:44:59 -0500
Received: from sonic312-25.consmr.mail.gq1.yahoo.com ([98.137.69.206]:39835
        "EHLO sonic312-25.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbeL0Ro6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Dec 2018 12:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1545932697; bh=5B88bTY2yqf8yExQpm2VK+VUOQCP9fbFITRsDDHAInQ=; h=From:To:Cc:References:In-Reply-To:Subject:Date:From:Subject; b=PkS0vqeedkSuQnJ+7L1h+JnxIeYTlRxn04zOl+fFZFRO0qzpisZOsxNEb/nxavV0xlVVJbXVK4UG2/inqt7D2lnMicvasApo3uqwmzxR6uffszKPIZiEBRNm3opbZxd5dL/WnIsQDsk1a4m3sPgrDbiZoDyjzptHY0OHaRuG9TFvRDGKR7q6bRpH+F3eRPz31dV6bGTV8jA0pp04aBNym2cAM8QsKJvOgKpE2KOG2WPCZuqSHOiwYcmHcBSJZbEMqm2ExzlwT4aDPtVsknJZ8e2E6p2kpRptJCIOPhum6E+vs1aQNCUzDuHk14iDjdgRxKJ3RfheKcH0ZNgaZhmjfw==
X-YMail-OSG: dROh2LkVM1nDdW.hatt9ky9cQvQjC1Mo8RK0EwmZZSAdI3kbv5a.z1jBXciE_Qq
 BNfVYBxLfpJ_7sSN1XRBrtJPDkPXn8gzIkPElB_QQuLNEX3o7OyUzqrvozpHNJqWMSzfk5k_.mFM
 iUBP8ewHvYKpSCITeaT3qQ.ro32Oq8LOyWSh332CBFDfPhla3oaLheSw5mdYEnmNMmeiy8nPOgqx
 4Q_rWsR4QGevv4zYI.UOA.OcQZPvSGRe8MXG6cRHNkxgQVPZ8i9AhVa6K3dQHP1j3toIDJRvhTpX
 AHALzooVr2VQUPwdqqUiFtRkxZWcL3OQqbLWgE9wq8A0dKFIwwBtMdsZPwUzIvNss2Eiotk6Va_Y
 JhOtX3iLA.ij6tugOxevWaZTU4pmwAJXM3YO4iMpVuSZAjwkuSK6QD2rMnKDL.Q.VuGFAvdpEHvi
 TPasi1emttc0SJpaTsT4Bq8KR1XpyKB0mMA7FE1bn6t5qfHd7okMRQrqkoJJHzl7xjnrNIVS71.P
 2l2zQxT5oXv0sbxXozoXq8rUYYCTd2_Sc09CCucsnUKBK0.NJ6vV2mDGcKJmOlFpjIsKt4GB102B
 R4Ve8jzWHhXbU09MxEco_dcMEv8UWt0LfOLAzsRVbuUMqD1J4sh47fGoNYAiXJAKq4gHQqL4_OQM
 585fPf3r8zdecEufc_ZPrawvBps8LFwSjH9XrdAU1rsupkg73sz4MQLQq8kEdUmfFx6zKgx3vxmV
 NCesUfvOHT53b7sF9wISeDPFmfB_Ordz7dO0AxXlZCaDbDVSORQ7lv2Cjod0xm_T0SaCr2ICf4UB
 WZhb0J89_K25ywCRTvYLdOPL.Wx2QgkAybe2QlfMkUYYacd_JCQmuHWMOyw6aIJF9UNRojRYAqn7
 bIMZEvA63DxMi6TKSFTBNaL6.xzVEAqp9ySug1sZ8qipJlJQ0C7l1EfjAwxm4gP5S2Qz1X4GYqpf
 0kh6VbY0p7ZAgHdVEoBcgJA785XvhXQBf2B2.M0QxYysOVE.KF38Bn1UmcbNbVf652Y2QWmMISUb
 BeYfOhfJ1JK_sUcNG11C2ZV5vQ1GUulMDROQKFt.mw2IRx46.mhRppKSh6M1k00MPVIk_ClTHLgL
 5T2hz9VpomTm1HcebxI0ImonzKQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 27 Dec 2018 17:44:57 +0000
Received: from 99.229.179.249 (EHLO pangea) ([99.229.179.249])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 72e7a684989156e2f12b51c3bd57d635;
          Thu, 27 Dec 2018 17:44:55 +0000 (UTC)
From:   "Randall S. Becker" <randall.s.becker@rogers.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.com>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "'Randall S. Becker'" <rsbecker@nexbridge.com>
References: <20181226230523.16572-1-randall.s.becker@rogers.com> <20181226230523.16572-3-randall.s.becker@rogers.com> <CAPig+cQ4p8kgAWji3r6WnudZdT4TOG15s1ip6p5SXmTec25mPw@mail.gmail.com>
In-Reply-To: <CAPig+cQ4p8kgAWji3r6WnudZdT4TOG15s1ip6p5SXmTec25mPw@mail.gmail.com>
Subject: RE: [PATCH v1 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Thu, 27 Dec 2018 12:44:54 -0500
Message-ID: <000601d49e0b$e11d7520$a3585f60$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHP6M3TTaFeK+MquD7CewJFvBAGhQLF2eaCAnfCWWilclXzkA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 27, 2018 12:03, Eric Sunshine wrote:
> On Wed, Dec 26, 2018 at 6:05 PM <randall.s.becker@rogers.com> wrote:
> > A number of configuration options are not automatically detected by
> > configure mechanisms, including the location of Perl and Python.
> > [...]
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> > diff --git a/config.mak.uname b/config.mak.uname @@ -441,26 +441,45
> @@
> > ifeq ($(uname_S),NONSTOP_KERNEL)
> >         # Our's are in ${prefix}/bin (perl might also be in =
/usr/bin/perl).
> > -       PERL_PATH =3D ${prefix}/bin/perl
> > -       PYTHON_PATH =3D ${prefix}/bin/python
> > +       PERL_PATH =3D /usr/bin/perl
> > +       PYTHON_PATH =3D /usr/bin/python
>=20
> Is the in-code comment about ${prefix} still applicable after this =
change?

The ${prefix} is not applicable on this platform for perl and python. =
Those locations must be in /usr/bin and are managed by the Operating =
System vendor not by customers. The change is wrapped in an IF so is =
only applicable to NonStop.
>=20
> > +       # The current /usr/coreutils/rm at lowest support level does =
not work
> > +       # with the git test structure. Default to the older rm.
> > +       RM =3D /bin/rm -f
>=20
> This comment would be far more helpful if it explained in what way =
'rm'
> actually fails with the test suite. Without that information, the =
comment is
> effectively useless.

There is a temporary failure in the vendor supplied rm. The cause we =
never disclosed to my team. Honestly, it created a large amount of angst =
that should be gone but there are still old OS versions that have this =
issue. This is as much as we know.

>=20
> >         # As detected by './configure'.
> >         # Missdetected, hence commented out, see below.
> >         #NO_CURL =3D YesPlease
> >         # Added manually, see above.
> > +       # Missdetected, hence commented out, see below.
> > +       #NO_CURL =3D YesPlease
> > +       # Added manually, see above.
>=20
> These added lines are just duplicating the existing line immediately =
above. That's weird. I'll fix it. Thanks for the catch.
>=20
> > +       # Not detected by ./configure. Add manually.
> > +       NEEDS_SSL_WITH_CURL =3D YesPlease
> > +       NEEDS_CRYPTO_WITH_SSL =3D YesPlease
> > +       HAVE_DEV_TTY =3D YesPlease
>=20
> I find these comments about 'configure' "misdetecting" or "not =
detecting"
> features confusing. The point of config.mak.uname is to provide sane
> defaults for people building without using the 'configure' script, so =
it feels
> weird to be talking about 'configure'
> here. Also, what does it mean to say that 'configure' "misdetects"?
> Does that mean that it fails to write assignments such as "NO_CURL =3D
> YesPlease" to config.autogen or does it mean that it writes incorrect
> assignments to that file?

This came from another team. We can't currently use config.autogen =
anyway on the platform - this came from the prior attempt at porting. By =
misdetect I mean just that, however. We do not get good values.
>=20
> > @@ -470,8 +489,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> > +       ifdef NO_PTHREADS
> > +       else # WIP, use of Posix User Threads is planned but not =
working yet
> > +               PTHREAD_CFLAGS =3D -D_PUT_MODEL_ -I/usr/include
> > +               PTHREAD_LIBS =3D -lput
> > +       endif
>=20
> Why not a simpler 'ifndef'?

Another team is current working on the PTHREAD implementation and wanted =
this. I think what happened was that we have non-pthread requirements =
under development. I can remove this.


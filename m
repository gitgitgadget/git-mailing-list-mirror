Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CCE91F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeCORED (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:04:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:35219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751535AbeCOREC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:04:02 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mbxdm-1fEjMh1nhW-00JNfy; Thu, 15
 Mar 2018 18:03:49 +0100
Date:   Thu, 15 Mar 2018 18:03:34 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Johannes Sixt <j6t@kdbg.org>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>
Subject: Re: [PATCH 3/3] Makefile: optionally symlink libexec/git-core binaries
 to bin/git
In-Reply-To: <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1803151757240.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180313203935.5084-1-avarab@gmail.com> <20180313203935.5084-4-avarab@gmail.com> <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1226669551-1521133432=:64"
X-Provags-ID: V03:K0:PJa5dBkf/hUx3uc0WXD//Xm/m6rPs6E8WQ6orK4KDn76s+9lMc7
 5OZn1NDkDly/0X86NTQ3Mn1t81gxE1AIyyow9P0/CCwbrGdFSuyuy0No2jjEQ3ssuHR8g4I
 O6of5yw5iFhc0+DymA+C6yZIUlKj4dhUMXuW9eCvRKoaOEgf7qbin4JsDmC8uuLL6uqkhe2
 zxh3vAc/dNkobK4ibou9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gh0eQNv/p00=:dU8f+u9F0TKM69tw4wXBKy
 /Mc82QRKNJkBCnSl6IS5qf1rSpPsGUhvLutSTznvYQV/2mCh5j+b9LeYIRv2JXiwN+caBr4uX
 meqwiu4fH2ara+/XSYPTsyaK5WxfQ/3md6UcUwffbcYRsUmlgYQI0NkafTnakzMZloa2IEoBO
 SFShXt2RBKTCt7JLStsKWMR+3qqWQmt8JtGNoHzg5GfdN+eEFLhbJ0eaTki365NgmHe6ksYep
 8Az1JB80C7rWJH2D1rkQkLVNRXlRR5UUlnkXn60BlLZGk/cztdRopp/M6Z+UaIwkeUTqizBFQ
 8V06n/CWx5GI4j1PVyGo4w4tw4NgZRA68xJaMaG1U54yJqjN+dWV4kXJFfqHiGg+bWg5FYPbN
 zYSLX9Om7vo5YDf5srjhU+hYV8iVwjuKBtoefDVX+kqae4QETOYoz6dvEYSy7mTaO10/2FnLp
 X3En7S7yzWBFcVFIyUqP/FWUY+iAGq63w+Kwj4bYzbht1uzbgttfdGSu/Rw6JNbY/e8XE8INT
 GntUWXlodKJDSLNiEyiwf86JZWEp8WKz2Cwbc8SlQmoos8ST0qM4joMEyebq2y9EBwNptu5SV
 jAFcECo3UmQCHswIvpUfzSMh53tYqaUW/mKIHegm0nXwFrI7uQK7oLxlxBmhwcJhS1gjgFycz
 9o3qRiZv5O+ZTcOiTvDuW0erEU/C0T20DscOTqePhEJi3x2NC0eyd3wJ4HCiuGpM6hqtbCtlT
 iMsnA7p7XdMemV+CaAxM9I5E6sdQlrCbuJpXAfhNLyZqTjc5+Cfx7d5dvy+whgfDAXfflXHBB
 ejclJccsxf1np4/EurECUWZ95BJnowAu6TSVIyygBPIKU4lH18=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1226669551-1521133432=:64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 14 Mar 2018, Johannes Sixt wrote:

> Am 13.03.2018 um 21:39 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> > Add a INSTALL_SYMLINKS option which if enabled, changes the default
> > hardlink installation method to one where the relevant binaries in
> > libexec/git-core are symlinked back to ../../bin, instead of being
> > hardlinked.
> >=20
> > This new option also overrides the behavior of the existing
> > NO_*_HARDLINKS variables which in some cases would produce symlinks
> > within to libexec/, e.g. "git-add" symlinked to "git" which would be
> > copy of the "git" found in bin/, now "git-add" in libexec/ is always
> > going to be symlinked to the "git" found in the bin/ directory.
>=20
> It is important to leave the default at hard-linking the binaries, becaus=
e on
> Windows symbolic links are second class citizens (they require special
> privileges and there is a distinction between link targets being files or
> directories). Hard links work well.

To clarify: symbolic links do not exist in Windows Vista and earlier.
(There exists a concept called Junction points, but it has subtly
different semantics than symbolic links, different enough that we cannot
emulate symbolic links via Junctions).

Windows 7 and later do have symbolic links, but they require elevated
privileges to be created, as Hannes pointed out.

Since Windows 10 version 1703 (Creators Update), enabling Developer Mode
will disable this restriction and allow creating symlinks without UAC
elevation. See
https://blogs.windows.com/buildingapps/2016/12/02/symlinks-windows-10/ for
details.

In Git for Windows, I originally missed the memo and forgot to add support
for the special flag, but since Git for Windows v2.13.1, users can create
symbolic links without administrators' privileges on Windows 10 (Creators
Update or later) in Developer Mode.

Of course, we still support Windows all the way back to Vista, so the
default is still: no symbolic links.

Thanks for your attention,
Dscho
--8323329-1226669551-1521133432=:64--

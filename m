Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7431F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfEHLdT (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:33:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:60205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHLdR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557315188;
        bh=jaDKwziMfilY6Ie3I4Y5XR0nbjztpiehBjL74dhsaQw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=apPJLi1m5b5o14xADRRkYxRU1/Ig2UYUPki9bTBGUyT+NEp8g7WBnOnAcP2vrbYkw
         F91hd74OtXGC4dAdZDBNDjgzSlyHZ02E12sM46UieyxipA1WL2ATeT1QeG4qx3z9e+
         eZMBIVt2YKgB+t17VP2FixkyVgl5qXPYlcSy9ZOs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lv9lm-1gfgNa1rTG-010OMr; Wed, 08
 May 2019 13:33:08 +0200
Date:   Wed, 8 May 2019 13:33:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C4=B0smail_D=C3=B6nmez?= <ismail@i10z.com>,
        =?UTF-8?Q?=C4=B0smail_D=C3=B6nmez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mingw: enable DEP and ASLR
In-Reply-To: <2e7be484-74d7-7258-954e-3a4a34a36c01@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905081331060.44@tvgsbejvaqbjf.bet>
References: <pull.134.git.gitgitgadget@gmail.com> <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com> <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org> <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
 <2e7be484-74d7-7258-954e-3a4a34a36c01@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-590037512-1557315189=:44"
X-Provags-ID: V03:K1:IeAdoerpNfzYkUAnuL4ID+tHct2VH3whCL9NyyUsuEehEZN5Qi/
 pB8H0uocK9jbsIHz7VOL1V/uvkpQ1HuNUetDqMkSI0oRpan4OPCtEmER0d38iHl7+rqnDq4
 0wI+jEf0/yo6+pQTA2aZfdHKUVwMveml1/kOamj4/yr6NrI1IUsBhSZOkjpxxNwfUMcyqhl
 Nqj3e8nvjSbXSWyeTdnTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yajNZVYbWQM=:zsizQq37UNH1rLJATi9j5p
 THTDTFyGaFxWI6LAKFmBftj5ag0wNvdxoUtiLs7rIELLblBwIFcntWrmO/O81IuZmRaTMTSHQ
 8BGomGtK9Y/0wkPwEuBn3xwnaq8P2T6MouGo8+yAkYzIm8PR6HKoLsJb6Rgz756U1BFSFRQjW
 EhRdsgFkxbNXQ+PABSKf6JvUtdjka00ZlQ0stLuRtHtoVRpKDQhXpq2jqeotmHnlzbDYYyS17
 zviIWdu7VgIzbuXi3+hIM89y8KYQDFlK4h1pcoROx8ReV9/RxPDl9tSdJKQgU3r5lnUD4sAFs
 2/Xs0iWt68sIdTuxBlhSsetDYOCvWZwknR5JHqbjWuR8F9xjJ9wTgtOdc5mlcALyc1cz5paLN
 mMxvWN/6ey05GO0WD32WAQ+vzKCMH0IxpQplZ0DDYFWt91TXo3sSc24I82CQdVuU6PEyu6aUW
 Z26J76saQRMasgR9iwohGatkmWl0BNxovbhLAeDXpzHMd2peM1ubrTXfOmSKZ2aICUA6SO1Oe
 srfq7D8QH56DD+Y1HJiMPRUhcpZgCNDmsMFcHxDGYAH+kbtoChwpYDZm9qYtzLWRKRiHnO9YX
 OykVwmDyf2VN8RJFsqoWkQJjI6nh3Ka1038sZ0lcSJY+4WmNi7SVpUVvUsBAxtgjNXbbWl2+M
 oZrCjuXnq7+ldGzWiFMRb90VZRJiY0ypujO9QTZ/58ruU+bGqua7U0FpkBdnmqZyuZDh+v4iT
 nFoPnYnkAeWtLENNeTFM93SRUMNCUjBg70IhErShsbLihzKEMSIiQDNUP68Jcui9xjy6/mHvF
 iGwB46NIOWKtFfxoBhvhTtp7XWzOTW1RKe6M4yVDRA6d9g1QyoTnzq5XpmnEBbyWDjrdP84F5
 MNivsg/Jw6y0/D4y621BWE6I6aPHxInH+hxcYjQ9OZlb4B1ncr03ybReJKO6py9P7a5aE+FpL
 qrbH1mkWiUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-590037512-1557315189=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alban,

On Wed, 1 May 2019, Alban Gruin wrote:

> Le 01/05/2019 =C3=A0 00:41, Johannes Schindelin a =C3=A9crit=C2=A0:
> >
> > On Tue, 30 Apr 2019, Johannes Sixt wrote:
> >
> >> [had to add Dscho as recipient manually, mind you]
> >
> > I usually pick up responses to GitGitGadget patch series even if I am =
not
> > on explicit Cc: (but it might take a couple of days when I am too busy
> > elsewhere to read the Git mailing list).
> >
> >> Am 29.04.19 um 23:56 schrieb =C4=B0smail D=C3=B6nmez via GitGitGadget=
:
> >>> From: =3D?UTF-8?q?=3DC4=3DB0smail=3D20D=3DC3=3DB6nmez?=3D <ismail@i1=
0z.com>
> >>>
> >>> Enable DEP (Data Execution Prevention) and ASLR (Address Space Layou=
t
> >>> Randomization) support. This applies to both 32bit and 64bit builds
> >>> and makes it substantially harder to exploit security holes in Git b=
y
> >>> offering a much more unpredictable attack surface.
> >>>
> >>> ASLR interferes with GDB's ability to set breakpoints. A similar iss=
ue
> >>> holds true when compiling with -O2 (in which case single-stepping is
> >>> messed up because GDB cannot map the code back to the original sourc=
e
> >>> code properly). Therefore we simply enable ASLR only when an
>
> I don=E2=80=99t know if it stands true when combined with something like=
 -ggdb3,
> but I may be very wrong.  Feel free to correct me.

Possibly, but that makes my job here harder, so I won't even try right now
;-)

> >>> optimization flag is present in the CFLAGS, using it as an indicator
> >>> that the developer does not want to debug in GDB anyway.
> >>>
> >>> Signed-off-by: =C4=B0smail D=C3=B6nmez <ismail@i10z.com>
> >>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>> ---
> >>>  config.mak.uname | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/config.mak.uname b/config.mak.uname
> >>> index e7c7d14e5f..a9edcc5f0b 100644
> >>> --- a/config.mak.uname
> >>> +++ b/config.mak.uname
> >>> @@ -570,6 +570,12 @@ else
> >>>  	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
> >>>  		# MSys2
> >>>  		prefix =3D /usr/
> >>> +		# Enable DEP
> >>> +		BASIC_LDFLAGS +=3D -Wl,--nxcompat
> >>> +		# Enable ASLR (unless debugging)
> >>> +		ifneq (,$(findstring -O,$(CFLAGS)))
> >>> +			BASIC_LDFLAGS +=3D -Wl,--dynamicbase
> >>> +		endif
> >>>  		ifeq (MINGW32,$(MSYSTEM))
> >>>  			prefix =3D /mingw32
> >>>  			HOST_CPU =3D i686
> >>>
> >>
> >> I'm a bit concerned that this breaks my debug sessions where I use -O=
0.
> >> But I'll test without -O0 before I really complain.
> >
> > Weird. Jameson Miller also mentioned this very concern in an internal
> > review.
> >
> > I guess I'll do something like
> >
> > 	ifneq (,$(findstring -O,$(filter-out -O0,$(CFLAGS))))
> >
>
> -Og also exists to debug[0], even if it=E2=80=99s far less known.

Good point.

> Perhaps it=E2=80=99s better to check for -g (and its variants[1]) as the=
 user
> clearly states their intent to debug the resulting binary, rather than
> checking for special cases.

I don't think we can use that, as we specifically build Git for Windows
with optimization *and* with debug symbols (and then use cv2pdb to extract
those debug symbols into external .pdb files for use with advanced
post-mortem tools, i.e. we do *not* need to single-step).

Thanks,
Dscho

--8323328-590037512-1557315189=:44--

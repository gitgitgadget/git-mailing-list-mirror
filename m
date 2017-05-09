Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59CA520188
	for <e@80x24.org>; Tue,  9 May 2017 10:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdEIKlG (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 06:41:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:53885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbdEIKlF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 06:41:05 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDhGw-1dGIQp2rxm-00H3n1; Tue, 09
 May 2017 12:40:41 +0200
Date:   Tue, 9 May 2017 12:40:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
In-Reply-To: <20170509003714.ylwn5ezvu5h36kj7@genre.crustytoothpaste.net>
Message-ID: <alpine.DEB.2.21.1.1705091234210.146734@virtualbox>
References: <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com> <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com> <alpine.DEB.2.21.1.1705041104070.4905@virtualbox>
 <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com> <alpine.DEB.2.21.1.1705041328190.4905@virtualbox> <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com> <xmqqpofj7rim.fsf@gitster.mtv.corp.google.com>
 <20170508233224.udpuuzlygjpsjogt@genre.crustytoothpaste.net> <CACBZZX4G_ThE55Gi53QJt1=9K4jQXqJ3QL8JSGpiSSSDRrKeNA@mail.gmail.com> <20170509003714.ylwn5ezvu5h36kj7@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1187481368-1494326441=:146734"
X-Provags-ID: V03:K0:MJvDph51diFpuFqQ4aTcg+zxs77h6JRL/JQ6CS67dMGhsxZXuWT
 l0wBtlfsiQ7NHbyHfJ1HFd/qLlqqauQRG9/iUDZqvmxLgqJbcZ0Cm6NJjrqls5HD25zCylS
 Dba+HyH0RBBf0U5JCzD75ii6S8rivMvpZDP3kBl4Ofib6AbBrMkJn6AUA882SoCf5C8HTSs
 m2c5U0QHjNk6xoV/bGIZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:thpesmDcm9A=:wewGslOEPuVUrMNgFcoh2G
 ooGA7eAtZ0eRlq5t6+Fa1Kj9C+iZRZesMH6EEVLlzcjVV9T16T2/5TjwNUNHd5jbc9Icr0gQQ
 9SK8nVLK63l078nvXKHabeFt90TwlgCzC3v7L+Y8DhvjufXeNu6sRyhSTd7v2LO8//j7cL1ij
 TLnQhZrbNOqWB/3x06T/7xGik9SWemwDddV8w3lk8VdXVbT+MQmy0zBYPXRqkuXMvdf3zmuw/
 /lFvMCjk6dkXq0XPP7XXNBWxII0GEpMpyh7rJFu5m30meponLqCXMYFRli9E9+s0Q32ExYkoN
 fvnOZuV40OPosh83Cbasv9RZj/3cwn02xn3J3hhpuwiJfjCbDpL+jJJh8EhX5ifm8B49ik1Fy
 v8bFMp/jphBqNIr3/JiGU5QZAvHTZddYBp1btED5esRw0+5lAN7a2im6qQ2pU2higbOzFOOvk
 3XMsOEf7XKdP3bWuqpioC4mJ9Kj040xEoCoZs8+ihBqKnUXnpZ1ZMktnx0ZBIYgbd4WhW9yuB
 F4Vo49hju3nKMIj0LHLrlAgWF+ot2lT0THWLj6mwBncsV5/lylp8IaVkzEdefpS7JMfD/99b6
 qbA0AOPAYQlLVNpotRAZvY65Nk7qVussp8Pu4+9xfcobxvF+0g7r1cfORGtLCRjIeGVSiZZkN
 fEWuBNmiUdfuCiBCwb08QcijlvUeHP8yrZH+9V36OouTZ9zVU0OxY8td6+NT+BFCokWQeS8RW
 raRnYfULphamAy5wFmVN+/tB2JssjUfrL0/XjgLt9+8JluHS0fTbiw2z+50PPr3y89SvQAquv
 1qs41mP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1187481368-1494326441=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 9 May 2017, brian m. carlson wrote:

> On Tue, May 09, 2017 at 02:00:18AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> > On Tue, May 9, 2017 at 1:32 AM, brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > PCRE and PCRE2 also tend to have a lot of security updates, so I
> > > would prefer if we didn't import them into the tree.  It is far
> > > better for users to use their distro's packages for PCRE, as it
> > > means they get automatic security updates even if they're using an
> > > old Git.
> > >
> > > We shouldn't consider shipping anything with a remotely frequent
> > > history of security updates in our tree, since people very
> > > frequently run old or ancient versions of Git.
> >=20
> > I'm aware of its security record[1], but I wonder what threat model
> > you have in mind here. I'm not aware of any parts of git (except maybe
> > gitweb?) where we take regexes from untrusted sources.
> >=20
> > I.e. yes there have been DoS's & even some overflow bugs leading code
> > execution in PCRE, but in the context of powering git-grep & git-log
> > with PCRE this falls into the "stop hitting yourself" category.
>=20
> Just because you don't drive Git with untrusted regexes doesn't mean
> other people don't.

Or other applications.

> It's not a good idea to require a stronger security model than we
> absolutely have to, since people can and will violate it.  Think how
> devastating Shellshock was even though technically nobody should provide
> insecure environment variables to the shell.
>=20
> And, yes, gitweb does in fact call git grep. That means that git grep
> must in fact be secure against untrusted regexes, or you have a remote
> code execution vulnerability.

And not only grep is affected. Think HEAD^{/<regex>}. There are plenty of
sites where you are allowed to specify revs in a freer form than SHA-1s.

Having said that, I do like the prospect of a faster git grep.

Hopefully there will be a way to make use of PCRE that can be switched
off? Like, a compile-time replacement of the regex API backed by PCRE v2
*iff* PCRE v2 is used for building?

Ciao,
Dscho
--8323329-1187481368-1494326441=:146734--

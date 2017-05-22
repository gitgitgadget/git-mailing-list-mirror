Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DED772023D
	for <e@80x24.org>; Mon, 22 May 2017 12:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933437AbdEVM6q (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 08:58:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:51121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933259AbdEVM6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 08:58:45 -0400
Received: from virtualbox ([95.208.58.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2LZc-1e4U052pXA-00sAPT; Mon, 22
 May 2017 14:58:33 +0200
Date:   Mon, 22 May 2017 14:58:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mingw: simplify PATH handling
In-Reply-To: <f4119dba-0e25-0a0b-0796-dc4c3d4d1cc5@web.de>
Message-ID: <alpine.DEB.2.21.1.1705221457520.3610@virtualbox>
References: <c5b7292f-6367-e4a9-2ee0-96b93b1b587f@web.de> <f4119dba-0e25-0a0b-0796-dc4c3d4d1cc5@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-774337645-1495457913=:3610"
X-Provags-ID: V03:K0:7UgVFPYtm2Iefz82/FctMfu5vnurtpcB2HPKUyCxIkN1WScvDse
 EpPi/M+Es7O5tLbti0+RM6tVTt/SVxnIA3FIjYqrY/yy5xubPBaDHsWw5rktDO2qMkPv3Ie
 7oGkwekX2mzAAZARHniqz2wepHCxFrPzNYyibgr5/mh9qkkYJHNBcCeZTVJor639DcCvUYl
 LBN8wbg0RUfaKJPOVauDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LDLfA2d1IkQ=:RcJzUZVothVpGoxXbBpXp8
 c/+6asX3ddGS5ywp6ovOUvvIZRt5M1OXjIAsOk4Ub+8W7ohU6Kukg7HPQxzu6UwNV3gct/6mS
 OkX5F0Coie1hpeZseURM5oVLxv0UWuIBB2OZzF76KBjGBl98B+iBZK708DapPjQeDPtfEGS0o
 rmvBeshp2air/nTxDqrg4Kfd4p0ZtECPkysSJUlsv2fgiqZthVkjFocV3bPZQ3yKAGlwHKYcf
 i6h1AhVtmA9gRVDXGexndZuBNlkLC2PLOrhJY7ZtD73tX4jHY5nTtXyf1S7j9ROo9FteBqRL/
 A4Y0g4RUpvuk23VkdMzZLUOMWcbe8fZHraUsx/OVOA/ASmKZCuwKzlMw8pEgNJvBXVIVugzCK
 QC337oEXGiXEnlgJ4KuqczUJeV4emk2kSA40B8E6THe7LJ+wKWti0l6fNoRyUoN8dO8GQNG3l
 Opdi6fohS1fWgcXtgbtkTrYkDZXyD63P4JuOhfL2h3puWmwrddQ+8brnS+Sm46SMas4gL8Xef
 vXq13ixYykm158CpHycAlybl5UwJrVagMwl0hZKLkMPwLP0KLNl46Z/LRnHWiivbYe5I7rXX7
 cmcBkH0cmrXxl6jnKAZKYO6iyOkyvOymZ5DAyr/7TKMnd31I9tOfKEUgEJERY9uQd55AkyXxG
 2SNHgn1kEdkpvDRRp7bRXxfYVyIAxBPNp94NWlWdPinSbsL4zjyhjIvAi1JfUepCzvU5OBo8q
 0eKDtsN5kTW4K5FcTtKFu7OvCHfeqUaahkBiTmGI43G9N0LgviuGTv0VmAt65ccPeN8ogwJbB
 d+ORaRo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-774337645-1495457913=:3610
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sat, 20 May 2017, Ren=C3=A9 Scharfe wrote:

> On Windows the environment variable PATH contains a semicolon-separated
> list of directories to search for, in order, when looking for the
> location of a binary to run.  get_path_split() parses it and returns an
> array of string copies, which is iterated by path_lookup(), which in
> turn passes each entry to lookup_prog().
>=20
> Change lookup_prog() to take the directory name as a length-limited
> string instead of as a NUL-terminated one and parse PATH directly in
> path_lookup().  This avoids memory allocations, simplifying the code.
>=20
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

ACK.

> Rebased against Junio's master, fixed string overrun.  Can hold and
> resubmit in a few months if it gets in the way right now.

I am in favor of getting this in as soon as possible.

Ciao,
Dscho
--8323329-774337645-1495457913=:3610--

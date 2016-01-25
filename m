From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] merge-file: let conflict markers match end-of-line
 style of the context
Date: Mon, 25 Jan 2016 09:59:47 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601250958330.2964@virtualbox>
References: <cover.1453632296.git.johannes.schindelin@gmx.de> <cover.1453709205.git.johannes.schindelin@gmx.de> <26c973eb3414a8634d515f3621c0ded77cf030ed.1453709205.git.johannes.schindelin@gmx.de> <56A5DDA8.1030404@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1180049043-1453712388=:2964"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Beat Bolli <dev+git@drbeat.li>, Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 10:00:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNd0O-0006fg-3q
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 10:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbcAYJAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 04:00:09 -0500
Received: from mout.gmx.net ([212.227.17.22]:55773 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521AbcAYJAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 04:00:06 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MUUWN-1aWbRf1sln-00RLXT; Mon, 25 Jan 2016 09:59:48
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56A5DDA8.1030404@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:FNGx4fxf1RXwMrnLXoiuVy40/wG7oO+z/h+/qDPMUex7jkMoDdt
 hjhKeunq+H9qlgx1UUx8LSNAuYtqGwkx04MhLPmZgB9j4lgHhTl+nlqbEoNMEiyg/eeHAv9
 XX6orvRAwfXmSowKtbJap0gMTZ0taTiD03W6DMrjlewq2vgYHBZFPiJBp/gjBFKUj4Bzdz3
 JaX8b5rgZAzlgxJump0tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o2JYwBv8W28=:kYZRLkfSeQZpun3+KpOxZ8
 ZePVeoTnLUxK6hSn/JU/DUhgozzwQOJVtS5bdhKmUxOUxdJc2zgfU9x7wpQ52qY/MGFmdRfln
 tW1P/DtDTNCv9Uta0ObYUq3d+leTE+hat/cFFLoOX0LtnSen7ktr8Gto4ynr0IB9NJDaNBGWr
 GvkExHvckdnpBz/FpIqUwMQFiqoMJKzbMC2uPruMTh3kSQBJqXk93krYyrzy5DI6X3C3ZWn1a
 S2aoGNHQXG8KW5SJtXNqno4CZmAIcaApr8R5Q4fatPKF2sIviTgKElTFQ44nB2iOJhzjCt2uA
 ajTOFFO/AZQE6l1GH7jwLT36dNCzVJjpuOaw86m6tNOIqmWFglLQYBXvrj2gj1b66Am/iVCHp
 PDOQSgUS3ZLexsc0SSRoz6eZn73leYlTxdx2xIORJU9rEjFEwy5/3XHqhh3EhE4zshYA1odEc
 PmxOmN+rdA+kUPislp+86DRBZZVsD6/oEro641yraSw9WayZw1xKTQbHUcjPfwf20nhdPD0Ju
 nXtRxwdm5r1imjTqQf6pxTUn3Izqwb3oYPaSwB4bT5EzI4ZvPwkVaxOL6nGMoxdS42J4rxHEW
 nJ4qOD++P6nwPmcEVWMMHcP+7MTCuGXrIEZTdLmALTEtMf27UcLycT0DzVM4vnDVr4jVCiCZt
 lG1sWzy0twmVolCgoY6b9khoJ/2TT+G00QAgb064hCqJyXjSkxhQruwA9rjDSrccQUJnyRIxS
 8BOrnN6Lh6u8RGm3EeER7C8Fnn+acl6JfyDAl5XtdYppKiFOysby191Abdiq2nqAGUxo3Lm+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284727>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1180049043-1453712388=:2964
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Mon, 25 Jan 2016, Torsten B=F6gershausen wrote:

> On 25.01.16 09:07, Johannes Schindelin wrote:
> []
> > diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> > index 625198e..c852acc 100644
> > --- a/xdiff/xmerge.c
> > +++ b/xdiff/xmerge.c
> > @@ -143,6 +143,35 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int =
count, int add_nl, char *dest)
> >  =09return xdl_recs_copy_0(1, xe, i, count, add_nl, dest);
> >  }
> > =20
> > +/*
> > + * Returns 1 if the i'th line ends in CR/LF (if it is the last line an=
d
> > + * has no eol, the preceding line, if any), 0 if it ends in LF-only, a=
nd
> > + * -1 if the line ending cannot be determined.
> > + */
> > +static int is_eol_crlf(xdfile_t *file, int i)
> Minot nit: Could that be=20
> is_eol_crlf(xdfile_t *file, int lineno)
> (or may be)
> is_eol_crlf(const xdfile_t *file, int lineno)
> (or may be)
> has_eol_crlf(const xdfile_t *file, int lineno)

The surrounding code consistently uses i, and not lineno. The reason (I
guess) is that i starts at 0 whereas lineno would have to start at 1, and
we can easily avoid adding and subtracting 1 all the time.

Ciao,
Dscho
--8323329-1180049043-1453712388=:2964--

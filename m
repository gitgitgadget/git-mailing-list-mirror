From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Mon, 29 Feb 2016 05:18:08 -0500
Message-ID: <20160229101808.GD2950@sigill.intra.peff.net>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
 <56D078F3.9070905@web.de>
 <xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
 <56D0D2DF.1040807@web.de>
 <xmqqtwkvhwpd.fsf@gitster.mtv.corp.google.com>
 <20160227032907.GB10313@sigill.intra.peff.net>
 <56D14C56.6070306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 29 11:18:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaKuD-00088w-0C
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 11:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbcB2KSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 05:18:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:51274 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752119AbcB2KSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 05:18:11 -0500
Received: (qmail 11414 invoked by uid 102); 29 Feb 2016 10:18:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 05:18:11 -0500
Received: (qmail 24503 invoked by uid 107); 29 Feb 2016 10:18:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 05:18:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 05:18:08 -0500
Content-Disposition: inline
In-Reply-To: <56D14C56.6070306@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287820>

On Sat, Feb 27, 2016 at 08:12:22AM +0100, Torsten B=C3=B6gershausen wro=
te:

> > Torsten, what is the compiler version (I don't have Apple compilers=
, but
> > it seems plausible that older clang might have the same problem).
>
> That's machine is running Mac OS X 10.6, which is no longer supported
> with updates.
>=20
>  gcc --version
> i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1 (Apple Inc. build 5666) (do=
t 3)
> Copyright (C) 2007 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There =
is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE.

Thanks. Out of curiosity, I tried to reproduce by with a build of gcc
4.2.1, to see if I could bisect. But it seems the toolchain is quite
complex. After much munging, I managed to build a broken compiler (whic=
h
I think is due to a much too-new version of bison, but I stopped
digging).

Your suggestion elsewhere in the thread to just use clang instead sound=
s
good to me. :)

-Peff

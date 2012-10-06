From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] gitignore.txt: suggestions how to get literal # or !
 at the beginning
Date: Sat, 6 Oct 2012 11:40:36 -0400
Message-ID: <20121006154036.GA14119@sigill.intra.peff.net>
References: <20121006132127.GC11712@sigill.intra.peff.net>
 <1349531484-5938-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 17:40:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKWUl-00063m-Pr
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 17:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959Ab2JFPkl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 11:40:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43000 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584Ab2JFPkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 11:40:40 -0400
Received: (qmail 7199 invoked by uid 107); 6 Oct 2012 15:41:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 11:41:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 11:40:36 -0400
Content-Disposition: inline
In-Reply-To: <1349531484-5938-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207150>

On Sat, Oct 06, 2012 at 08:51:24PM +0700, Nguyen Thai Ngoc Duy wrote:

> We support backslash escape, but we hide the details behind the phras=
e
> "a shell glob suitable for consumption by fnmatch(3)". So it may not
> be obvious how one can get literal # or ! at the beginning of pattern=
=2E
> Add a few lines on how to work around the magic characters.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Sat, Oct 6, 2012 at 8:21 PM, Jeff King <peff@peff.net> wrote:
>  > It works fine for me with asciidoc 8.6.7. <sigh>
>=20
>  8.6.5 works. I don't care deeply as I read .txt anyway. Here it goes
>  again with examples.

I'd be slightly worried that we are hurting other people who do care an=
d
are on older versions of asciidoc. It would be nice if we actually knew
the cause of the different behaviors we saw and if there was a way to
work around it (it might not even be old asciidoc, but rather old
docbook).

Part of me wants to just take the change and see if anybody complains.
But that is probably the wrong thing to do, and just my general
frustration with our doc toolchain talking.

-Peff

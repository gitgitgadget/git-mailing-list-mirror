From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git.txt: document GIT_TRACE_PACKET
Date: Sun, 9 Jun 2013 01:55:10 -0400
Message-ID: <20130609055509.GA17617@sigill.intra.peff.net>
References: <20130609053621.GA1854@sigill.intra.peff.net>
 <1370757210-2994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 07:55:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlYb1-0000ic-8G
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 07:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab3FIFzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 01:55:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:60424 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab3FIFzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 01:55:12 -0400
Received: (qmail 14714 invoked by uid 102); 9 Jun 2013 05:56:01 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 00:56:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 01:55:10 -0400
Content-Disposition: inline
In-Reply-To: <1370757210-2994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226889>

On Sun, Jun 09, 2013 at 12:53:30PM +0700, Nguyen Thai Ngoc Duy wrote:

> "This can help with debugging object negotiation or other protocol
> issues."
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  >> +'GIT_TRACE_PACKET'::
>  >> + =C2=A0 =C2=A0 If this variable is set, it shows a trace of all =
packets
>  >> + =C2=A0 =C2=A0 coming in or out of a given program. This can hel=
p with
>  >> + =C2=A0 =C2=A0 debugging object negotiation or other protocol is=
sues.
>  >
>  > This is not quite true. It stops showing packets after it sees a p=
acket
>  > starting with "PACK" (optionally with a sideband prefix). So you w=
ould
>  > miss, for example, a sideband error that came after the pack had
>  > started. So it is really only useful for looking at the ref and ob=
ject
>  > negotiation phases.
>=20
>  I blindly copied the first paragraph from bbc30f9 (add packet tracin=
g
>  debug code - 2011-02-24) and missed the "PACK" bit in the second one=
=2E
>  How about this?

Hmm, what do you know, I sort-of documented it already. I think I just
never guessed that anybody but people reading "git log" would actually
need to use TRACE_PACKET. :)

Thanks, the patch looks fine to me.

-Peff

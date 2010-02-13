From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -p: make the beginning of the hunk easier to see
Date: Sat, 13 Feb 2010 06:55:12 -0500
Message-ID: <20100213115512.GA5472@coredump.intra.peff.net>
References: <4B768807.3030003@gmail.com>
 <20100213112342.GA1299@coredump.intra.peff.net>
 <6672d0161002130333m55372972x909234cae7bd0d82@mail.gmail.com>
 <6672d0161002130342h348765a0j76f63972c4bbe060@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 12:55:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgGar-0004Zv-9v
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 12:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab0BMLzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 06:55:13 -0500
Received: from peff.net ([208.65.91.99]:33008 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795Ab0BMLzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 06:55:12 -0500
Received: (qmail 13830 invoked by uid 107); 13 Feb 2010 11:55:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 13 Feb 2010 06:55:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2010 06:55:12 -0500
Content-Disposition: inline
In-Reply-To: <6672d0161002130342h348765a0j76f63972c4bbe060@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139789>

On Sat, Feb 13, 2010 at 12:42:56PM +0100, Bj=C3=B6rn Gustavsson wrote:

> As an alternative to my patch, the color coding could be changed.
> The beginning of a chunk is now marked with a faint bluish color (the=
 part
> that looks like "@@ -42,9 +43,8 @@").

You can tweak that color with the color.diff.frag config variable.

> Giving the "Stage this hunk..." prompt some noticeable color (such as=
 red),
> could make it easier to the see beginning of the hunk. Or
> simply doing a form-feed (but I suppose not everyone would
> like that).

If you are using color.interactive (or color.ui), that should already b=
e
"bold blue". You can change it to red with color.interactive.prompt.

Personally, I prefer the color approach. It's less ugly looking (IMHO),
and it is configurable, so people who don't like it don't have to see
it. It's also already implemented, though one could perhaps make an
argument for changing the defaults.

-Peff

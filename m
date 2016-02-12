From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Fri, 12 Feb 2016 17:16:39 -0500
Message-ID: <20160212221639.GA27974@sigill.intra.peff.net>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <xmqqsi0xu2ac.fsf@gitster.mtv.corp.google.com>
 <20160212224048.Horde.IpOeDKLAMM4a11F2xyIeY4M@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, tr@thomasrast.ch
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Feb 12 23:16:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUM1A-0008Vw-34
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 23:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbcBLWQo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 17:16:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:41223 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751452AbcBLWQn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 17:16:43 -0500
Received: (qmail 22767 invoked by uid 102); 12 Feb 2016 22:16:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 17:16:43 -0500
Received: (qmail 19825 invoked by uid 107); 12 Feb 2016 22:16:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 17:16:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Feb 2016 17:16:39 -0500
Content-Disposition: inline
In-Reply-To: <20160212224048.Horde.IpOeDKLAMM4a11F2xyIeY4M@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286079>

On Fri, Feb 12, 2016 at 10:40:48PM +0100, SZEDER G=C3=A1bor wrote:

>  * It would swallow even those errors that we are interested in,
>    e.g. (note the missing quotes around $foo):
> [...]
>  * I often find myself tracing/debugging the completion script
>    through stderr by scattering
>=20
>       echo >&2 "foo: '$foo'"

One alternative to deal with these would be to add a flag to
conditionally turn off stderr, and then leave it on during normal
operation and disable it (letting everything through, including whateve=
r
random cruft git commands produce) for debugging.

But...

>  * I have a WIP patch series that deals with errors from git
>    commands.

I'm happy to wait and see what this patch looks like (and generally
happy to defer to you on maintenance issues for completion, as you are
much more likely than me to be the one fixing things later on :) ).

-Peff

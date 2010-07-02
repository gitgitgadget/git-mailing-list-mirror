From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/8] Improvements for t/README
Date: Fri, 2 Jul 2010 03:28:03 -0400
Message-ID: <20100702072803.GB1812@sigill.intra.peff.net>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 09:28:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUafZ-0000EI-EL
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 09:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab0GBH2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 03:28:08 -0400
Received: from peff.net ([208.65.91.99]:41430 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866Ab0GBH2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 03:28:06 -0400
Received: (qmail 18357 invoked by uid 107); 2 Jul 2010 07:29:00 -0000
Received: from ip98-166-72-212.hr.hr.cox.net (HELO sigill.intra.peff.net) (98.166.72.212)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 02 Jul 2010 03:29:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jul 2010 03:28:03 -0400
Content-Disposition: inline
In-Reply-To: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150111>

On Thu, Jul 01, 2010 at 08:17:50PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> This is v2 of the t/README series. It should address the concerns
> Junio and Jeff had about it.
>=20
> Jeff:
>=20
>   - Keep the ./ way of running tests, but elaborate a bit in the
>     commit message
>=20
>   - Mention --root's effects on the trash directory location

Thanks. On the first point, I agree with Junio that dropping patch 1 is
probably the best thing. For the second, your changes to patch 2 look
good to me.

The rest look OK from my cursory read. I like the "do's and don'ts"
list, which is a good way of communicating the little bits of wisdom
(btw, I saw your post a few weeks ago about shell portability in git,
and I think a list of known-bad constructs would be a good idea. Making
a list from our previous fixes is on my todo list, but I haven't
actually started on it. :) ).

One nit:

> +   You can gleam some further possible issues from the TAP grammar
> +   (see http://search.cpan.org/perldoc?TAP::Parser::Grammar#TAP_Gram=
mar)
> +   but the best indication is to just run the tests with prove(1),
> +   it'll complain if anything is amiss.

I think you mean "glean".

-Peff

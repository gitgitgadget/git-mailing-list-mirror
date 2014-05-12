From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive: Preserve diff heading when
 splitting hunks
Date: Mon, 12 May 2014 17:12:35 -0400
Message-ID: <20140512211235.GA4705@sigill.intra.peff.net>
References: <1399824596-4670-1-git-send-email-avarab@gmail.com>
 <20140512183955.GB31164@sigill.intra.peff.net>
 <xmqqvbtapuyk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 23:12:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjxWb-0004Y3-O5
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 23:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136AbaELVMi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 17:12:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:50205 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753729AbaELVMh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 17:12:37 -0400
Received: (qmail 25507 invoked by uid 102); 12 May 2014 21:12:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 May 2014 16:12:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 May 2014 17:12:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbtapuyk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248735>

On Mon, May 12, 2014 at 02:07:15PM -0700, Junio C Hamano wrote:

> > And figuring out "B" here
> > would be prohibitively difficult, I would think, as it would requir=
e
> > applying the funcname rules internal to git-diff to a hunk that git=
-diff
> > itself never actually sees.
>=20
> You can actually apply a split hunk being proposed to a temporary
> file and then ask "git diff" about it, so I do not think difficult
> is too much of an issue,

True, I didn't think of that.

> but I doubt we would want to see header_B,
> exactly because when the user says "Split this hunk", s/he is very
> well aware that the second one is artificial and was split from the
> original hunk whose header said header_A.

Right, that's along the lines of the "you could make the argument" I wa=
s
thinking of. Since you are thinking it, too, I'm definitely in favor of
stopping at =C3=86var's patch and seeing if anybody even notices or
complains.

Thanks.

-Peff

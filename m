From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Mon, 27 Jul 2009 10:26:24 +0200
Message-ID: <20090727082623.GB18268@laphroaig.corp>
References: <20090723074104.GI4750@laphroaig.corp>
 <7veis7yxwx.fsf@alter.siamese.dyndns.org>
 <20090724193207.6117@nanako3.lavabit.com>
 <7v8wienk07.fsf@alter.siamese.dyndns.org>
 <20090725145237.GB18545@artemis.corp>
 <20090726153950.GA16780@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 27 10:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVLYM-0004KX-FZ
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 10:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050AbZG0I0a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2009 04:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbZG0I03
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 04:26:29 -0400
Received: from pan.madism.org ([88.191.52.104]:52796 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900AbZG0I01 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 04:26:27 -0400
Received: from laphroaig.corp (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by hermes.madism.org (Postfix) with ESMTPSA id D132A42385;
	Mon, 27 Jul 2009 10:26:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090726153950.GA16780@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124156>

On Sun, Jul 26, 2009 at 11:39:50AM -0400, Jeff King wrote:
> Is this really that different from what you proposed?

No it's not, in the sense that what I propose is a subset of your
proposal, functionaly speaking ;)

> No, I don't really think so in terms of implementation, but it is
> really about a different mental model:
>=20
>   1. You never delete things. You only copy or move them into registe=
rs.
>=20
>   2. The interface should be the same whether you are moving between
>      registers, or to/from the working tree.
>=20
>   3. It extends naturally to multiple registers.

I like the general idea, I'm unsure what the UI for such tools would
look like though.
--=20
Intersec <http://www.intersec.com>
Pierre Habouzit <pierre.habouzit@intersec.com>
T=C3=A9l : +33 (0)1 5570 3346
Mob : +33 (0)6 1636 8131
=46ax : +33 (0)1 5570 3332
37 Rue Pierre Lhomme
92400 Courbevoie

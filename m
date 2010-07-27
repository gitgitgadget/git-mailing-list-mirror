From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC PATCH 0/2] Allow detached forms (--option arg) for git
 log options.
Date: Tue, 27 Jul 2010 16:46:39 +0200
Message-ID: <20100727144639.GU2504@madism.org>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
 <20100726193109.GA1043@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 16:46:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdlQe-0004iW-Cj
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 16:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306Ab0G0Oqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 10:46:44 -0400
Received: from pan.madism.org ([88.191.52.104]:33070 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756146Ab0G0Oqm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 10:46:42 -0400
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 2A30D4E954;
	Tue, 27 Jul 2010 16:46:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D54A61D8; Tue, 27 Jul 2010 16:46:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100726193109.GA1043@burratino>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151946>

On Mon, Jul 26, 2010 at 02:31:09PM -0500, Jonathan Nieder wrote:
> Hi Matthieu,
>=20
> Matthieu Moy wrote:
>=20
> >                    is there any reason why "git log" hasn't been
> > migrated to parse-option? Or is it only that nobody did it yet?
>=20
> Please go ahead. :)

I started it in the past, but never went around to actually do it.

I started to get rid of most of the bitfields to use explicit or-ed
fields, but stopped at that, I don't even remember if those patches got
merged or not.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g

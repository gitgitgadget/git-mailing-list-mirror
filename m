From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [PATCH] show-branch: fix segfault when showbranch.default
	exists
Date: Tue, 9 Jun 2009 10:06:13 +0200
Message-ID: <20090609080612.GG9993@laphroaig.corp>
References: <7vfxe9udln.fsf@alter.siamese.dyndns.org> <4A2E0C88.70805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDwVm-0008ID-7G
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 10:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759229AbZFIIQB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 04:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758760AbZFIIQA
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 04:16:00 -0400
Received: from pan.madism.org ([88.191.52.104]:33376 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbZFIIP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 04:15:59 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jun 2009 04:15:58 EDT
Received: from laphroaig.corp (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by hermes.madism.org (Postfix) with ESMTPSA id 0DCD03C5DF;
	Tue,  9 Jun 2009 10:06:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A2E0C88.70805@gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<
	;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u
	*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121151>

On Tue, Jun 09, 2009 at 12:17:28AM -0700, Stephen Boyd wrote:
> Junio C Hamano wrote:
> > I am not sure if this is a bug in parse_options(), or a bug in the =
caller,
> > and tonight I do not have enough concentration to figure out which.=
  In
> > any case, this patch works the issue around.
>=20
> I am low on concentration tonight as well, but this looks right to me=
=2E
> Parse options is expecting the regular old argv and argc. I overlooke=
d
> this code path during the conversion (though I remember figuring out
> what this path was doing). Faking the argv and argc a little more
> accurately, like you do, should work fine.

yes, that's it.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g

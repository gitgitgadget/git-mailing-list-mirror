From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH v2] status: display "doing what" information in git status
Date: Fri, 6 May 2011 20:44:03 +0200
Message-ID: <20110506184403.GC2872@madism.org>
References: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
 <1304667535-4787-1-git-send-email-madcoder@debian.org>
 <vpqei4bwu4b.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 06 20:44:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIQ0Z-00075g-Q1
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 20:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531Ab1EFSoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 14:44:06 -0400
Received: from pan.madism.org ([88.191.52.104]:41928 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212Ab1EFSoF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 14:44:05 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 14A22518A8;
	Fri,  6 May 2011 20:44:04 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5AF572B0E2; Fri,  6 May 2011 20:44:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqei4bwu4b.fsf@bauges.imag.fr>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172999>

On Fri, May 06, 2011 at 08:40:04PM +0200, Matthieu Moy wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > +	const char * const merge_advice =3D
> > +		_("use \"git reset --hard\" to abort, or resolve conflicts and c=
ommit");
>=20
> I think that should be "git reset --merge" (which preserves files not
> touched by the merge, and makes sure "git merge; git reset" doesn't
> permanently loose data).

Wow, I didn't know about that one, so /maybe/ the hint isn't that
useless after all :)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g

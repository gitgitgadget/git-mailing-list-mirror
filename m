From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/1] status: display "doing what" information in git
 status
Date: Fri, 6 May 2011 01:51:29 +0200
Message-ID: <20110505235129.GG636@madism.org>
References: <1304632126-16733-1-git-send-email-madcoder@debian.org>
 <7vbozg67oj.fsf@alter.siamese.dyndns.org>
 <20110505233925.GE636@madism.org>
 <7vr58c4sip.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:51:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI8KW-00044H-PA
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 01:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab1EEXvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 19:51:32 -0400
Received: from pan.madism.org ([88.191.52.104]:39029 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754300Ab1EEXvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 19:51:32 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id CE75751AD4;
	Fri,  6 May 2011 01:51:30 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E28AD1A81; Fri,  6 May 2011 01:51:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172930>

On Thu, May 05, 2011 at 04:49:50PM -0700, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >> As the "You are in middle of" information is useful mostly when yo=
u are on
> >> detached head, I would have expected that the call would be inside=
 the
> >> if/elif chain near the top of wt_status_print() where we say "On b=
ranch"
> >> vs "Not currently on...", to replace that information that comes f=
rom that
> >> on_what variable.
> >
> > It's also useful when you're in the middle of a rebase or during a =
merge
> > conflict who aren't on a detached head.
>=20
> What I would expect in such a case would be like:
>=20
> 	# On branch master (resolving merge with ph/status)
>=20
> instead of wasting an extra line like:
>=20
> 	# Resolving a merge conflict
>         # On branch master
>=20
> That is what I meant "to replace".

okay it's really late, sorry, I read too fast, I'll work on something
like that, doesn't looks too complicated ;)

I'll post an updated patch on tomorrow.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g

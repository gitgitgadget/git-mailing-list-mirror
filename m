From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/1] status: display "doing what" information in git
 status
Date: Fri, 6 May 2011 10:04:46 +0200
Message-ID: <20110506080446.GA26842@madism.org>
References: <1304632126-16733-1-git-send-email-madcoder@debian.org>
 <BANLkTi=teRP8cMJeDC+khUtYD61SmeSdLA@mail.gmail.com>
 <20110505232650.GD636@madism.org>
 <4DC3A7E4.30204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git ML <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 06 10:05:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIG1y-0003yj-Df
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 10:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab1EFIEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 04:04:52 -0400
Received: from pan.madism.org ([88.191.52.104]:47042 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327Ab1EFIEt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 04:04:49 -0400
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7F5084F443;
	Fri,  6 May 2011 10:04:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id AFBE81A87; Fri,  6 May 2011 10:04:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC3A7E4.30204@drmicha.warpmail.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172954>

On Fri, May 06, 2011 at 09:48:52AM +0200, Michael J Gruber wrote:
> Pierre Habouzit venit, vidit, dixit 06.05.2011 01:26:
> > On Fri, May 06, 2011 at 01:06:45AM +0200, Sverre Rabbelier wrote:
> >> Heya,
> >>
> >> On Thu, May 5, 2011 at 23:48, Pierre Habouzit <madcoder@debian.org=
> wrote:
> >>> This provides the same information as the git bash prompt about t=
he
> >>> current operation that is going on: rebase, merge, am, cherry-pic=
k or
> >>> bisect.
> >>
> >> Can you show how this will look like?
> >=20
> > Sure, it adds a line on the top with the same color as "not on any
> > branch" iff there is an ongoing operation.
> >=20
> > Of course in this setup it makes no sense since my shell shows it
> > already, but I'm frustrated when I use git on a remote machine wher=
e I
> > don't have zsh installed or configured, and at work many people wou=
ld
> > like to know where they left stuff before they grabbed coffee and t=
alked
> > for 1h instead of taking 5 minutes ;)
>=20
> I think this is useful and nice in the compactified version suggested=
 by
> Junio. Be prepared for someone requesting it with "status -s -b" :)

Well, I've written the logic, it's easy to use :P

> What became of the colouring of the git-prompt, btw? I see you're usi=
ng
> some, and I remember a stalled effort to have this in our shipped
> completion. Do have something shareable in that respect?

My git prompt predates the bash one, it's here
http://madism.org/~madcoder/dotfiles/config/zsh/60_prompt you're
free to do what you want with that.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g

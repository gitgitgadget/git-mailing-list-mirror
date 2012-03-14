From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Wed, 14 Mar 2012 15:27:52 +0100
Message-ID: <20120314142752.GD28595@in.waw.pl>
References: <20120313232256.GA49626@democracyinaction.org>
 <7vobrzst7n.fsf@alter.siamese.dyndns.org>
 <20120314121434.GB28595@in.waw.pl>
 <vpqobrzgww9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christopher Tiwald <christiwald@gmail.com>,
	git@vger.kernel.org, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 14 15:28:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7pBI-0000aa-0K
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030694Ab2CNO1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 10:27:55 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55777 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754931Ab2CNO1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:27:54 -0400
Received: from zbyszek by kawka.in.waw.pl with local (Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S7pBA-0008QC-Ej; Wed, 14 Mar 2012 15:27:52 +0100
Content-Disposition: inline
In-Reply-To: <vpqobrzgww9.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193113>

On Wed, Mar 14, 2012 at 02:00:38PM +0100, Matthieu Moy wrote:
> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>=20
> > I think that having three different config keys for the three
> > different advices makes sense, because the advices will be displaye=
d
> > at different times.
>=20
> I don't think it really makes sense to be such fine-grained. We alrea=
dy
> have 6 different advices, so an advance user who do not want them nee=
d
> to set these 6 variables. I think we want to keep this number relativ=
ely
> low.
>=20
> The advice messages do not point explicitely to the way to disable th=
em,
> so users who know how to set advice.* are users who know a little abo=
ut
> configuration files, and who read the docs.=20

Elsewhere in this thread it was proposed to add an actual 'git config'
command to the advice.

> Instead of having too
> fine-grained configuration variables, we can have a better doc,
> explaining shortly the 3 possible cases under advice.nonfastforward i=
n
> config.txt. The user who disable the advice can read the doc (I usual=
ly
> think that "users don't read documentation" is a better assumption, b=
ut
> since the user knows about the name of the variable, it is OK here).
>=20
> Also, if I read correctly the patch, the old variable is left in the =
doc
> and in advice.{c,h}, but is no longer used. This means old-timers who
> have set it will see the message poping-up again after they upgrade,
> which I think is inconveinient for them.

So it seems that the old variable should be respected, not to annoy
"old-timers".

Zbyszek

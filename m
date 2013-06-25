From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: Another core.safecrlf behavor with git diff/git status
Date: Tue, 25 Jun 2013 10:52:10 +0200
Organization: OPTEYA
Message-ID: <48dfe0b092fdf977a823725ddbc91e32@meuh.org>
References: <866f886ef5e48ba22eec0f67203666bb@meuh.org>
 <7v7ghjbg8i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 10:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrOzD-0005UO-Pa
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 10:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab3FYIwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 04:52:16 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:63484 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab3FYIwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 04:52:14 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1UrOyx-000ERC-78; Tue, 25 Jun 2013 10:52:11 +0200
In-Reply-To: <7v7ghjbg8i.fsf@alter.siamese.dyndns.org>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.9.2
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228947>

Hi,

Le 24.06.2013 18:55, Junio C Hamano a =C3=A9crit=C2=A0:
> Yann Droneaud <ydroneaud@opteya.com> writes:
>=20
>> - Why git diff does not always report the CRLF/LF mismatch ?
>=20
> Most likely because you are telling safecrlf not to error out but
> just warn, and then you are not fixing the cause of the warning?  So
> diff would say "Ok, you must know what you are doing, so I trust
> what is in the index", perhaps?
>=20
>> - Why git status does not report about the CRLF/LF mismatch before
>> updating the index:
>=20
> My suspicion is the same as "diff".

I'm ok with theses answers regarding the test case provided first:
the warning was emitted when the files were commited.

(But still I would like git diff/git status to behave the same regardin=
g=20
the "index":
  emit the warning and update the index,
  I suppose it's not related to core.safecrlf but inner Git way of=20
working).

Could you have a look at the other test case I've sent later in this=20
thread / the rebase problem I've sent earlier in another thread.

Regards.

--=20
Yann Droneaud
OPTEYA

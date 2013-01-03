From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH V2] t9810: Do not use sed -i
Date: Wed, 2 Jan 2013 22:08:11 -0500
Message-ID: <20130103030811.GA30979@padd.com>
References: <201301020020.38535.tboegi@web.de>
 <20130102224446.GA12363@padd.com>
 <7vhamz18y3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 04:08:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqbAf-0007ct-HX
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 04:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab3ACDIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 22:08:16 -0500
Received: from honk.padd.com ([74.3.171.149]:49327 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab3ACDIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 22:08:14 -0500
Received: from arf.padd.com (unknown [50.55.142.135])
	by honk.padd.com (Postfix) with ESMTPSA id 6FAB41E43;
	Wed,  2 Jan 2013 19:08:13 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 47C7022AF0; Wed,  2 Jan 2013 22:08:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vhamz18y3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212568>

gitster@pobox.com wrote on Wed, 02 Jan 2013 15:06 -0800:
> Pete Wyckoff <pw@padd.com> writes:
>=20
> > tboegi@web.de wrote on Wed, 02 Jan 2013 00:20 +0100:
> >> sed -i is not portable on all systems.
> >> Use sed with different input and output files.
> >> Utilize a tmp file whenever needed
> >>=20
> >> Added missing && at 2 places
> >>=20
> >> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
> >
> > One more teensy fix is needed in this hunk, following Junio's
> > comment about redirections going at the end:
>=20
> I've already pushed out the previous one on 'pu' after fixing it up
> like this.
>=20
> Thanks.  Anything I missed?

I should have guessed that you would just silently fix it.
Thanks!

		-- Pete

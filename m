From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 00:15:31 +0200
Message-ID: <20120416221531.GA2299@goldbirke>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:15:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuCx-0002km-N9
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab2DPWPf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 18:15:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51076 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab2DPWPe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 18:15:34 -0400
Received: from localhost6.localdomain6 (p5B130635.dip0.t-ipconnect.de [91.19.6.53])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Lj4vO-1RhoZJ0drS-00dCKq; Tue, 17 Apr 2012 00:15:31 +0200
Content-Disposition: inline
In-Reply-To: <20120415213718.GB5813@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:f7iVccdnqGk2Z/dm3sy3FzPlcTMQ1Qej1Nn937MEi6o
 ra0t7Hv0+PG7HuwnhV329tgKw75Wbb+EszcL3qNrMU7jztZUeF
 L+/NoTwk5I5ibto89ZqFL8CH2mYOhrYyXiKYd2QgOcqJ13W4fV
 ipW7ThnPrWmJgcnQYgV5czcB09TuTES0ZMUDq3RbzIoYBIFnjh
 p8jHY/8pnZm3tSWsftm0KNl7FYBek51xoCo5zdSjo7hIbj0QJj
 2xVhrlXodh0OtGmTjsz0dsL2BBHjaL7bCdWOMf6+9S2CMLpZak
 U8fRQP9vbewGuRDp9T3c2B2yC/+WL6eggoSE61nI8BzmJr9Ply
 m8CcEcCbkffC+1qlg48I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195712>

Hi,

On Sun, Apr 15, 2012 at 04:37:18PM -0500, Jonathan Nieder wrote:
> Felipe Contreras wrote:
>=20
> > This simplifies the completions, and makes it easier to define alia=
ses:
> >
> >  git_complete gf git_fetch
>=20
> Sounds neat.  Unfortunately users could already be using a function
> with some other purpose named git_complete in their .profile and this
> would override it.  The completion script has so far stuck to a
> limited namespace:
>=20
> 	_git_*	(completion functions)
> 	__git_*	(everything else, including public interfaces like __git_ps1=
)

Don't forget the oddball __gitdir() function ;)

> A name like __git_complete should work, presumably.

And foo_wrap() should also fit into those namespaces.


Best,
G=E1bor

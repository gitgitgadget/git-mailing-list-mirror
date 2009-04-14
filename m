From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-shell: Add 'git-upload-archive' to allowed
	commands.
Date: Tue, 14 Apr 2009 08:09:27 +0200
Message-ID: <20090414060927.GA3948@atjola.homenet>
References: <49DE537C.8070907@ripe.net> <7v3acff10x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Broes <erikbroes@ripe.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 08:11:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtbrP-0004TS-M8
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 08:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbZDNGJb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 02:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbZDNGJb
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 02:09:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:58950 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750983AbZDNGJa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 02:09:30 -0400
Received: (qmail invoked by alias); 14 Apr 2009 06:09:28 -0000
Received: from i59F5BDC9.versanet.de (EHLO atjola.local) [89.245.189.201]
  by mail.gmx.net (mp016) with SMTP; 14 Apr 2009 08:09:28 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19cMTwBV3tcRYf1xN6DFO+lPF6X9dUMsaQsomMNOU
	m3MyvWNNrzfIoi
Content-Disposition: inline
In-Reply-To: <7v3acff10x.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116517>

On 2009.04.11 12:22:54 -0700, Junio C Hamano wrote:
> Erik Broes <erikbroes@ripe.net> writes:
>=20
> > This allows for example gitosis to allow use of 'git archive --remo=
te' in a
> > controlled environment.
> >
> > Signed-off-by: Erik Broes <erikbroes@ripe.net>
> > ---
> >
> > There were some questions on IRC raising (valid) concerns about sec=
urity.
> > If there is a dangling commit on the remote end and any user would =
know
> > or guess the SHA, it could be retrieved where git-upload-pack will =
not
> > allow so.
> >
> > We were unable to find out if this was the original reason git-shel=
l was
> > never extended with git-upload-archive functionality or if it was a=
 simple
> > oversight. If it was the reason I'm not sure there is an easy way o=
ut.
>=20
> Can't the "security concern" be addressed by whatever creates the
> controlled environment (e.g. gitosis)?  For example, git-daemon can b=
e
> configured to service upload-archive request, so I do not think it is=
 such
> a bad idea to make this available if the site owner wants to use it.

But what about users that just have their shell set to git-shell? IIRC
around 1.6.0 we had some reports about broken setups because git-shell
had been moved to libexec. So apparently there are such setups, and the
change would weaken the restrictions for them.

Hm?
Bj=F6rn

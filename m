From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Thu, 15 Mar 2012 09:54:26 +0100
Message-ID: <20120315085426.GA11003@ecki>
References: <20120313232256.GA49626@democracyinaction.org>
 <7vobrzst7n.fsf@alter.siamese.dyndns.org>
 <20120314121434.GB28595@in.waw.pl>
 <vpqobrzgww9.fsf@bauges.imag.fr>
 <20120314142752.GD28595@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Christopher Tiwald <christiwald@gmail.com>,
	git@vger.kernel.org, peff@peff.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 15 09:55:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S86Ss-0000J1-FG
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 09:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760734Ab2COIzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 04:55:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:12770 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756888Ab2COIzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 04:55:10 -0400
Received: from localhost (p5B22C057.dip.t-dialin.net [91.34.192.87])
	by bsmtp.bon.at (Postfix) with ESMTP id CD1A0CDF91;
	Thu, 15 Mar 2012 09:55:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120314142752.GD28595@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193203>

On Wed, Mar 14, 2012 at 03:27:52PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:
> On Wed, Mar 14, 2012 at 02:00:38PM +0100, Matthieu Moy wrote:
> > Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
> >=20
> > > I think that having three different config keys for the three
> > > different advices makes sense, because the advices will be displa=
yed
> > > at different times.
> >=20
> > I don't think it really makes sense to be such fine-grained. We alr=
eady
> > have 6 different advices, so an advance user who do not want them n=
eed
> > to set these 6 variables. I think we want to keep this number relat=
ively
> > low.
> >=20
> > The advice messages do not point explicitely to the way to disable =
them,
> > so users who know how to set advice.* are users who know a little a=
bout
> > configuration files, and who read the docs.=20
>=20
> Elsewhere in this thread it was proposed to add an actual 'git config=
'
> command to the advice.

The proposed command does not turn off the advice. It only changes
push.default. The advice about push.default is effectively disabled onc=
e
they change push.default, but the other warnings are still in effect.

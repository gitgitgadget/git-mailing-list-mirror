From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 2/3] branch: suggest how to undo a --set-upstream when
 given one branch
Date: Wed, 11 Jul 2012 16:24:55 +0200
Message-ID: <1342016695.6458.14.camel@centaur.cmartin.tk>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
	 <1341939181-8962-3-git-send-email-cmn@elego.de>
	 <7va9z7ikfi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 16:25:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soxqv-00054c-6k
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 16:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914Ab2GKOYf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jul 2012 10:24:35 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:49230 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757695Ab2GKOYe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 10:24:34 -0400
Received: from [192.168.1.5] (p4FC5CD3B.dip.t-dialin.net [79.197.205.59])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 4E74C46149;
	Wed, 11 Jul 2012 16:24:29 +0200 (CEST)
In-Reply-To: <7va9z7ikfi.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201302>

On Tue, 2012-07-10 at 10:40 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > This interface is error prone, and a better one (--set-upstream-to)
> > exists. Suggest how to fix a --set-upstream invocation in case the
> > user only gives one argument, which makes it likely that he meant t=
o
> > do the opposite, like with
> >
> >     git branch --set-upstream origin/master
> >
> > when they meant one of
> >
> >     git branch --set-upstream origin/master master
> >     git branch --set-upstream-to origin/master
> >
> > Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>=20
> The new code does not seem to depend on the value of "track" (which
> is set by either -t or --set-upstream) in any way.  Shouldn't it be
> done only when it is set to track-override?

Yes, yes it should.

>=20
> Doesn't "git branch [-f] frotz" without any other argument trigger
> the warning?

It does. Oops. Fixed.

   cmn

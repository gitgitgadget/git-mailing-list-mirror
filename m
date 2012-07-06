From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] branch: make --set-upstream saner without an explicit
 starting point
Date: Fri, 06 Jul 2012 10:03:29 +0200
Message-ID: <1341561809.10752.61.camel@flaca.cmartin.tk>
References: <1341480589-1890-1-git-send-email-cmn@elego.de>
	 <7vd34arvhu.fsf@alter.siamese.dyndns.org>
	 <7vtxxmqezp.fsf@alter.siamese.dyndns.org>
	 <1341559103.10752.59.camel@flaca.cmartin.tk>
	 <7vpq89ny8q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 10:03:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn3W1-0005yN-Ae
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 10:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab2GFIDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jul 2012 04:03:42 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:57367 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062Ab2GFIDk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 04:03:40 -0400
Received: from [192.168.42.201] (unknown [176.5.191.32])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 3C5EE46149;
	Fri,  6 Jul 2012 10:03:32 +0200 (CEST)
In-Reply-To: <7vpq89ny8q.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201091>

On Fri, 2012-07-06 at 00:29 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > Yep, this seems good. Now that you mention the <name> existing, I w=
onder
> > if letting --set-upstream create the branch as well wasn't another =
bad
> > decision, as the name suggests it's for setting that information af=
ter
> > the branch has already been created.
>=20
> You should be able to correct that for --set-upstream-to=3D<upstream>=
=2E
> It is clearly about setting upstream for an existing branch, right?

Yeah, it's for changing the tracking information and should refuse to d=
o
so if the branch doesn't exist yet.

   cmn

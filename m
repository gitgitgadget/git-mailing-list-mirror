From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 3/3] branch: add --unset-upstream option
Date: Thu, 12 Jul 2012 12:27:46 +0200
Message-ID: <1342088866.6458.24.camel@centaur.cmartin.tk>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
	 <1341939181-8962-4-git-send-email-cmn@elego.de>
	 <7v629vijf2.fsf@alter.siamese.dyndns.org>
	 <1342016087.6458.10.camel@centaur.cmartin.tk>
	 <7vfw8yfde4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 12:27:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpGcL-0005Hc-OF
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 12:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933601Ab2GLK1Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jul 2012 06:27:24 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:55770 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932983Ab2GLK1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 06:27:23 -0400
Received: from [192.168.1.5] (p57A1FFA4.dip.t-dialin.net [87.161.255.164])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 975D746149;
	Thu, 12 Jul 2012 12:27:18 +0200 (CEST)
In-Reply-To: <7vfw8yfde4.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201355>

On Wed, 2012-07-11 at 09:53 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > I've added a bit of code to also remove branch.foo.rebase, which
> > I'd also consider to be part of the upstream information.
>=20
> If "git branch -t" or "git branch --set-upstream" took another
> option "--integrate-with=3D[rebase|merge]" to set the variable, I
> would agree that removing branch.$name.rebase would be the right
> thing to do, but because it is not, I do not know if it is sensible
> to remove it upon --unset-upstream.

I'll drop it then.

   cmn

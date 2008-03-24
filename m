From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 3/2] parse-options.c: introduce OPT_DATE
Date: Mon, 24 Mar 2008 22:18:43 +0100
Message-ID: <200803242218.44026.barra_cuda@katamail.com>
References: <200803232150.29971.barra_cuda@katamail.com> <200803241502.21465.barra_cuda@katamail.com> <7vwsnrubmd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jduj9-0002Et-DW
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbYCXWA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 18:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbYCXWA3
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:00:29 -0400
Received: from smtp.katamail.com ([62.149.157.154]:33986 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753068AbYCXWA2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 18:00:28 -0400
Received: (qmail 26331 invoked by uid 89); 24 Mar 2008 21:04:31 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host193-56-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.193)
  by smtp1-pc with SMTP; 24 Mar 2008 21:04:30 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <7vwsnrubmd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78105>

On Monday 24 March 2008, Junio C Hamano wrote:
> Michele Ballabio <barra_cuda@katamail.com> writes:
>=20
> > +int parse_opt_approxidate_cb(const struct option *opt, const char =
*arg,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int unset)
> > +{
> > +=A0=A0=A0=A0=A0*(unsigned int *)(opt->value) =3D approxidate(arg);
>=20
> Doesn't approxidate return ulong, not uint?

Yes, you're right.

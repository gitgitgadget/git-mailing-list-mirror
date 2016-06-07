From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 17:18:45 -0400
Message-ID: <20160607211845.GA7696@sigill.intra.peff.net>
References: <20160607195608.16643-1-santiago@nyu.edu>
 <20160607210856.GA6807@sigill.intra.peff.net>
 <20160607211313.GD24676@LykOS.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:18:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAOOj-00023l-C6
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933196AbcFGVSt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 17:18:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:50812 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932773AbcFGVSs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:18:48 -0400
Received: (qmail 8691 invoked by uid 102); 7 Jun 2016 21:18:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 17:18:48 -0400
Received: (qmail 1703 invoked by uid 107); 7 Jun 2016 21:18:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 17:18:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 17:18:45 -0400
Content-Disposition: inline
In-Reply-To: <20160607211313.GD24676@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296726>

On Tue, Jun 07, 2016 at 05:13:14PM -0400, Santiago Torres wrote:

> >   2. What do we do for non-annotated tags? Is it always a failure?
>=20
> Right now, verify-tag fails with non-annotated tags like this:=20
>=20
>     santiago at ~/.../git =E2=9C=94 ./git-verify-tag master
>     error: master: cannot verify a non-tag object of type commit.
>=20
> Although we could change this behavior. I would have to check how git
> tag -v works as this behavior might change.

Oh, right. That makes sense. I think it's not worth worrying about that
case, then.

-Peff

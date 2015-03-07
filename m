From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: use strbuf for hostname info
Date: Fri, 6 Mar 2015 20:08:33 -0500
Message-ID: <20150307010832.GB8202@peff.net>
References: <54F96BF2.5000504@web.de>
 <20150306210627.GA24267@peff.net>
 <54FA4446.5050103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 07 02:08:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU3EP-0004Gl-19
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 02:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbbCGBIg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 20:08:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:57574 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751346AbbCGBIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 20:08:36 -0500
Received: (qmail 13282 invoked by uid 102); 7 Mar 2015 01:08:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Mar 2015 19:08:36 -0600
Received: (qmail 23786 invoked by uid 107); 7 Mar 2015 01:08:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Mar 2015 20:08:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2015 20:08:33 -0500
Content-Disposition: inline
In-Reply-To: <54FA4446.5050103@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264983>

On Sat, Mar 07, 2015 at 01:20:22AM +0100, Ren=C3=A9 Scharfe wrote:

> > Not a big deal, but do we want to rename sanitize_client_strbuf to
> > sanitize_client? It only had the unwieldy name to distinguish it fr=
om
> > this one.
>=20
> A patch would look like this.  The result is shorter, but no win in
> terms of vertical space (number of lines).

IMHO this is an improvement, though whether it is enough to merit the
code churn I dunno. So I'm in favor, but don't mind dropping it if
others disagree.

-Peff

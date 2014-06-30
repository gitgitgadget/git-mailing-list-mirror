From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] sha1_file: use strncmp for string comparison
Date: Mon, 30 Jun 2014 12:46:00 -0400
Message-ID: <20140630164600.GA7641@sigill.intra.peff.net>
References: <53AED59B.1020209@web.de>
 <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com>
 <53AFA775.1090900@web.de>
 <53AFAA89.6050200@web.de>
 <20140630134317.GB14799@sigill.intra.peff.net>
 <53B191E6.7010509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:46:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1eiW-0004Ef-4V
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbaF3QqD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 12:46:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:53624 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751017AbaF3QqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:46:01 -0400
Received: (qmail 6917 invoked by uid 102); 30 Jun 2014 16:46:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 11:46:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 12:46:00 -0400
Content-Disposition: inline
In-Reply-To: <53B191E6.7010509@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252681>

On Mon, Jun 30, 2014 at 06:35:50PM +0200, Ren=C3=A9 Scharfe wrote:

> > It's probably not a big deal, as we don't expect random
> > junk in the pack directory, but I wonder if it would be better to b=
e
> > explicit, like:
>=20
> <snip>
>=20
> Here's a simpler approach:

I agree that solves the problem. However, I'm about to post an
alternative series that also replaces has_extension with strip_suffix,
which I think ends up a bit nicer.

-Peff

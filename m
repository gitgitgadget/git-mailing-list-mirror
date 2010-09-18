From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t7300: workaround ancient touch by rearranging
 arguments
Date: Fri, 17 Sep 2010 23:46:19 -0400
Message-ID: <20100918034619.GA18343@sigill.intra.peff.net>
References: <i6Vnwbi85zvoD6Nzpw2lc1cAb4fZRJiU13x2r3wnIFnHDZWo9gkMwp9pRXJjgiXl4Ce-ERc-tvc@cipher.nrlssc.navy.mil>
 <20100916003117.GA2527@sigill.intra.peff.net>
 <AANLkTinKxSugWedXxLPkSUKyRBBkTimawVY23+A5nzsZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 18 05:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwoNC-0000LN-8K
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 05:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab0IRDpp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 23:45:45 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48838 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934Ab0IRDpo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 23:45:44 -0400
Received: (qmail 30635 invoked by uid 111); 18 Sep 2010 03:45:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 18 Sep 2010 03:45:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Sep 2010 23:46:19 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinKxSugWedXxLPkSUKyRBBkTimawVY23+A5nzsZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156426>

On Sat, Sep 18, 2010 at 01:26:25AM +0200, Sverre Rabbelier wrote:

> On Thu, Sep 16, 2010 at 02:31, Jeff King <peff@peff.net> wrote:
> > Hmm, this seemed eerily familiar, and sure enough:
> >
> > =C2=A0http://article.gmane.org/gmane.comp.version-control.git/10127=
0
>=20
> Does this call for a git_touch which does a regular 'touch' for each
> of its arguments?

I don't know the broken touch's behavior, and I don't have it handy. It
might handle "touch 1" fine or it might interpret it as "touch at time
1, no file arguments". Brandon's solution is good enough for a test
script.

If you really wanted a portable git_touch, you would spell it ">>$file"=
=2E

-Peff

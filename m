From: Jeff King <peff@peff.net>
Subject: Re: Wishlist: git commit --no-edit
Date: Fri, 2 Nov 2012 05:59:54 -0400
Message-ID: <20121102095954.GB30221@sigill.intra.peff.net>
References: <nntxt8ice9.fsf@stalhein.lysator.liu.se>
 <vpqfw4sgx33.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Niels =?utf-8?Q?M=C3=B6ller?= <nisse@lysator.liu.se>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:00:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUE2r-0005aD-4h
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 11:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761140Ab2KBJ75 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2012 05:59:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54211 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760698Ab2KBJ74 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 05:59:56 -0400
Received: (qmail 2292 invoked by uid 107); 2 Nov 2012 10:00:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 06:00:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 05:59:54 -0400
Content-Disposition: inline
In-Reply-To: <vpqfw4sgx33.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208916>

On Fri, Nov 02, 2012 at 10:42:24AM +0100, Matthieu Moy wrote:

> nisse@lysator.liu.se (Niels M=C3=B6ller) writes:
>=20
> > I'd like to have a git commit option which is the opposite of --edi=
t, to
> > use the selected commit message as is, without invoking any editor.
> >
> > Main use case I see would be
> >
> >   git commit --amend --no-edit
>=20
> Err, isn't this already working? (maybe your version of Git is too ol=
d,
> but my 1.7.9.5 does this at least)

Yup, should be working since 1.7.9.

  $ git tag --contains ':/commit: honour --no-edit' |
    sort -V |
    head -1
  v1.7.9

-Peff

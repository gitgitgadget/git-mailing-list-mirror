From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Mon, 24 Sep 2007 08:20:41 +0200
Message-ID: <200709240820.45185.simon@lst.de>
References: <119022570352-git-send-email-git@davidb.org> <7vfy17iuu9.fsf@gitster.siamese.dyndns.org> <20070921212443.GA14983@old.davidb.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5083495.X2xE6nnONL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 08:21:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZhJc-0005Vh-Qe
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 08:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXIXGVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 02:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbXIXGVB
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 02:21:01 -0400
Received: from verein.lst.de ([213.95.11.210]:41642 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbXIXGVA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 02:21:00 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l8O6KoA5016429
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 24 Sep 2007 08:20:53 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <20070921212443.GA14983@old.davidb.org>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59020>

--nextPart5083495.X2xE6nnONL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 21 September 2007 23:24:43 David Brown wrote:
> On Fri, Sep 21, 2007 at 02:15:10PM -0700, Junio C Hamano wrote:
> >Simon Hausmann <simon@lst.de> writes:
> >> On Friday 21 September 2007 00:53:52 Junio C Hamano wrote:
> >>> David Brown <git@davidb.org> writes:
> >>> > On Wed, Sep 19, 2007 at 09:03:50PM +0200, Simon Hausmann wrote:
> >>> >>On Wednesday 19 September 2007 20:15:03 David Brown wrote:
> >>> >>> git-p4 was missing the execute bit setting if the file had other
> >>> >>> attribute bits set.
> >>> >>> ---
> >>> >>
> >>> >>I'm fine with this, so unless you find a better way:
> >>> >>
> >>> >>Acked-By: Simon Hausmann <simon@lst.de>
> >>> >
> >>> > I sent out an improved version of this patch yesterday
> >>> > <1190232768445-git-send-email-git@davidb.org> that I'd like to get
> >>> > approved.  I guess I'm not quite sure what happens at this point with
> >>> > a patch.
> >>>
> >>> I still have that *768445* message as "the last one proposed as
> >>> better than previous ones" in my mbox.
> >>>
> >>> Simon?
> >>
> >> Indeed, the new improved version is much better :)
> >>
> >> Acked-By: Simon Hausmann <simon@lst.de>
> >
> >Thanks.  This should go to 'maint' (part of v1.5.3.3) right?
>
> Sounds good by me.  I've been using it on a few other repos, and haven't
> had any problems.

Agreed.


Simon

--nextPart5083495.X2xE6nnONL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG91c9WXvMThJCpvIRAnHZAJ9mux2ZrIriqIR9zw8QjIw9exppoQCfWUh9
zeyx/nHuYqFfpS0bJU+OPYI=
=bXxo
-----END PGP SIGNATURE-----

--nextPart5083495.X2xE6nnONL--

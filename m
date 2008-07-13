From: Simon Hausmann <simon@lst.de>
Subject: Re: tests for git-p4
Date: Sun, 13 Jul 2008 14:26:03 +0200
Message-ID: <200807131426.09688.simon@lst.de>
References: <e48c5e540807120524rabdcfa6vd91c16ef1b0f80a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2391188.oej0GxzuYn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matt McClure" <mlm@aya.yale.edu>
X-From: git-owner@vger.kernel.org Sun Jul 13 14:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI0iV-0003aO-5A
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 14:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYGMM3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 08:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYGMM3Q
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 08:29:16 -0400
Received: from hoat.troll.no ([62.70.27.150]:47776 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbYGMM3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 08:29:15 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 3E61D20E5C;
	Sun, 13 Jul 2008 14:29:10 +0200 (CEST)
Received: from rani.local (unknown [172.20.1.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 2B1BD20B80;
	Sun, 13 Jul 2008 14:29:10 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <e48c5e540807120524rabdcfa6vd91c16ef1b0f80a0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88308>

--nextPart2391188.oej0GxzuYn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 12 July 2008 14:24:10 Matt McClure wrote:
> I'm planning to write a "p4-fast-export" that will facilitate using
> Bazaar on projects maintained in Perforce.  I'd like to reuse code
> from git-p4 since it appears to have much of the functionality I want.
>  In fact, the main reason I can't just use git-p4 today is that it
> does too much: it pushes the Perforce fast-export representation
> directly into Git.  I'm going to work on covering the existing
> functionality in tests before I start modifying the code, and I could
> try to write those tests such that they'll be useful to the Git
> project as well.
>
> Would my tests be of interest to git-p4's authors?  Is there any
> existing test framework for git-p4 that I missed?

There are currently no automated tests for git-p4. I would certainly be=20
interested, but I forsee difficulties testing the interaction with p4 in a=
=20
general way independent from a specific server setup.


Simon

--nextPart2391188.oej0GxzuYn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIefRhWXvMThJCpvIRAgqkAKCE94dv3oV6BKfGMTqsheCwobgocACePnWx
XweLvZpXUk9kF7e0E/WcVFI=
=3jxj
-----END PGP SIGNATURE-----

--nextPart2391188.oej0GxzuYn--

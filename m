From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Bug? - Unexpected lock file error
Date: Sat, 6 Sep 2008 04:12:23 +0200
Message-ID: <20080906021222.GY16514@genesis.frugalware.org>
References: <279b37b20809051622q6b3ab37tec3f1726c71952e4@mail.gmail.com> <7v63paupd8.fsf@gitster.siamese.dyndns.org> <7vtzcut9s3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m5R8f+g8StfRwQ/I"
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 04:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbnIv-0007Ya-C9
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 04:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbYIFCM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 22:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbYIFCM0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 22:12:26 -0400
Received: from virgo.iok.hu ([193.202.89.103]:34223 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886AbYIFCMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 22:12:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F27281B252E;
	Sat,  6 Sep 2008 04:12:23 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8A8164465E;
	Sat,  6 Sep 2008 04:12:23 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 49AF01190009; Sat,  6 Sep 2008 04:12:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzcut9s3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95056>


--m5R8f+g8StfRwQ/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2008 at 05:09:32PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > I think it is a bug in the git-merge rewritten in C, in "Already
> > uptodate!" codepath.

I can't reproduce it with master, so I don't think this problem was
introduced by the C rewrite.

> Try reverting 18668f5 (builtin-merge: avoid run_command_v_opt() for
> recursive and subtree, 2008-08-28).  That patch seems to be seriously
> broken.

Yes, that works around the problem. I'll try to send a fix later today.

--m5R8f+g8StfRwQ/I
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjB5wYACgkQe81tAgORUJZ+YQCfXCjegpkh1ImTYXvs7nZpvld1
bp4An0k+k5Gt4bLK97jyF/dXbHmGRfwo
=lZS0
-----END PGP SIGNATURE-----

--m5R8f+g8StfRwQ/I--

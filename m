From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH 0/2] Set Makefile variables from configure
Date: Wed, 04 Nov 2009 14:47:45 -0500
Message-ID: <1257363937-sup-5123@ntdws12.chass.utoronto.ca>
References: <20091103222123.GA17097@progeny.tock> <1257357960-12763-1-git-send-email-bwalton@artsci.utoronto.ca> <7v7hu6gjzz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1257364070-27458-21017-3297-24-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
Cc: jrnieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:48:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lpn-0007uh-DT
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758036AbZKDTrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758033AbZKDTrr
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:47:47 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:49721 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757970AbZKDTrq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:47:46 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:50181 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N5lpe-0001mh-Mh; Wed, 04 Nov 2009 14:47:50 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N5lpe-00045S-J7; Wed, 04 Nov 2009 14:47:50 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id nA4Jlo9u015710;
	Wed, 4 Nov 2009 14:47:50 -0500
In-reply-to: <7v7hu6gjzz.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132120>


--=-1257364070-27458-21017-3297-24-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Junio C Hamano's message of Wed Nov 04 14:36:32 -0500 2009:

> I am a bit puzzled about the "warning" logic.  Is this because you expect
> variables we typically give YesPlease/NoThanks as their values will not be
> handled with this new PARSE_WITH_SET_MAKE_VAR() macro?

No, this is because it's perfectly acceptable, in my opinion for a
user to say:

--with-pager=no
or
--with-editor=yes

Neither of those are smart things to do, but they're not necessarily
wrong, either.  I'm open to bailing on error for these, but I thought
leaving these as unvalidated, but with a warning, was more
flexible...if say a user wanted to have a pager called 'no' or
something.

For the variables that are accepting YesPlease/NoThanks, I think it's
more suitable to use the standard autoconf header/function/library
detection as it stands now.  This macro is more for 'oddball'
variables like DEFAULT_PAGER, DEFAULT_EDITOR, etc that aren't
necessarily easily detectable.  In some cases, even if it were
detectable, the detection might not be right.

Thanks
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1257364070-27458-21017-3297-24-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFK8dpl8vuMHY6J9tIRAsMAAJ9ogkZiJp9TwvSYL4Zrz1SC67gkwACfZWSF
rZOSB7GQ+ztlBQxjOjXFPzI=
=Z2y2
-----END PGP SIGNATURE-----

--=-1257364070-27458-21017-3297-24-=--

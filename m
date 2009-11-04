From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH 0/2] Set Makefile variables from configure
Date: Wed, 04 Nov 2009 15:16:40 -0500
Message-ID: <1257364915-sup-9761@ntdws12.chass.utoronto.ca>
References: <20091103222123.GA17097@progeny.tock> <1257357960-12763-1-git-send-email-bwalton@artsci.utoronto.ca> <7v7hu6gjzz.fsf@alter.siamese.dyndns.org> <1257363937-sup-5123@ntdws12.chass.utoronto.ca> <7vy6mmf4hi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1257365805-521962-21017-3767-25-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
Cc: jrnieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:16:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5mHm-0005cu-Sm
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 21:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbZKDUQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 15:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbZKDUQm
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 15:16:42 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:49868 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287AbZKDUQl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 15:16:41 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:51121 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N5mHd-0001x2-N3; Wed, 04 Nov 2009 15:16:45 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N5mHd-0004FF-Kd; Wed, 04 Nov 2009 15:16:45 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id nA4KGjND016317;
	Wed, 4 Nov 2009 15:16:45 -0500
In-reply-to: <7vy6mmf4hi.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132139>


--=-1257365805-521962-21017-3767-25-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Junio C Hamano's message of Wed Nov 04 14:56:57 -0500 2009:

> What puzzled me was not "why is it not an error but just a warning?", which
> is what you just explained, but "why should we even care what value is
> being given to begin with?".

I'm sorry.  I misunderstood then.  I think that in most cases, setting
either 'yes' or 'no' is wrong, but I wanted to leave the door open for
it for the 1%.  I thought that a warning message might be noticed and
cause someone to rethink.

> I am guessing from this description of 'oddball variables' that your
> answer to my question is yes.  That is, configure.ac writers are
> strongly discouraged from using this new macro for variables that
> would usually get YesPlease/NoThanks kind of values.

Yes, that's correct.  This new macro is for variables that are not a
simple toggle.  It is also distinct from the mechanism used to specify
a path for perl, tcl/tk, etc, in that for those, we do want to error
out on no.

Thanks
-Ben

-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1257365805-521962-21017-3767-25-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFK8eEt8vuMHY6J9tIRAoAHAJ9V0hTjgfXtsKdiaEAqF+6mchAjKQCglXLb
dZ5Am5hfjuom0NMmIVoJgiM=
=hLLc
-----END PGP SIGNATURE-----

--=-1257365805-521962-21017-3767-25-=--

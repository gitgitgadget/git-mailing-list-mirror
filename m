From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH 0/2] Set Makefile variables from configure
Date: Tue, 03 Nov 2009 12:25:48 -0500
Message-ID: <1257269082-sup-5056@ntdws12.chass.utoronto.ca>
References: <1257021695-21260-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1257269154-116413-21017-856-19-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
To: gitster <gitster@pobox.com>, jrnieder <jrnieder@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 18:26:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5N8t-00009W-SK
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 18:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbZKCRZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 12:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbZKCRZv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 12:25:51 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:46157 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbZKCRZv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 12:25:51 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:35743 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N5N8k-0005rp-8a; Tue, 03 Nov 2009 12:25:54 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N5N8k-00084j-60; Tue, 03 Nov 2009 12:25:54 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id nA3HPs1b031041;
	Tue, 3 Nov 2009 12:25:54 -0500
In-reply-to: <1257021695-21260-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131981>


--=-1257269154-116413-21017-856-19-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Ben Walton's message of Sat Oct 31 16:41:33 -0400 2009:

Ping?  Is this useful or should I drop it?

Thanks
-Ben

> These patches add support for setting the newly created DEFAULT_EDITOR
> and DEFAULT_PAGER from the configure script.  I also tacked in
> ETC_GITCONFIG, since I can't currently toggle this without setting a
> command line value when building, but have need to alter it.
> 
> The function added is generic, and will allow for setting new
> variables as needed in the future.  No validation is done on the
> values.  It is less specific than the *_PATH setting functions that
> already exist.
> 
> Ben Walton (2):
>   configure: add function to directly set Makefile variables
>   configure: allow user to set gitconfig, pager and editor
> 
>  configure.ac |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1257269154-116413-21017-856-19-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFK8Gei8vuMHY6J9tIRAkMLAKDt1RkPWR/qQh6HQofBXDsmSu0QUQCeMYOb
TMKfeoNj0sGJ7rnhSOsCD8w=
=spEk
-----END PGP SIGNATURE-----

--=-1257269154-116413-21017-856-19-=--

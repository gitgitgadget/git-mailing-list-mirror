From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Move read_revisions_from_stdin from builtin-rev-list.c
	to revision.c
Date: Sat, 5 Jul 2008 22:48:49 +0200
Message-ID: <20080705204849.GJ4729@genesis.frugalware.org>
References: <7vod5crydx.fsf@gitster.siamese.dyndns.org> <1215290434-27694-1-git-send-email-adambrewster@gmail.com> <1215290434-27694-2-git-send-email-adambrewster@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kgkihKxW3Un7xdgA"
Cc: git@vger.kernel.org, gitster@pobox.com, mdl123@verizon.net,
	Johannes.Schindelin@gmx.de, jnareb@gmail.com,
	Adam Brewster <asb@bu.edu>
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 22:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFEhb-00087y-BI
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 22:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYGEUsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 16:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbYGEUsw
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 16:48:52 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60271 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbYGEUsv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 16:48:51 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E59D21B251D;
	Sat,  5 Jul 2008 22:48:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0CDC54465E;
	Sat,  5 Jul 2008 22:17:32 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2F83711901F1; Sat,  5 Jul 2008 22:48:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1215290434-27694-2-git-send-email-adambrewster@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87465>


--kgkihKxW3Un7xdgA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 05, 2008 at 04:40:32PM -0400, Adam Brewster <adambrewster@gmail.com> wrote:
> Some other commands might like to support the --stdin option like
> git-rev-list.  Since they don't want to depend on builtin-rev-list, the
> function has to be somewhere else.

I think it's fine to move such a function, but this is a false commit
message, you can use read_revisions_from_stdin() from builtin-bundle if
it lives in builtin-rev-list.c as well.

>  mode change 100644 => 100755 builtin-rev-list.c
>  mode change 100644 => 100755 revision.c

Hm? ;-)

--kgkihKxW3Un7xdgA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhv3jEACgkQe81tAgORUJYz6wCcC0QUJt5d2jQ+zgJMu4PhGVWL
gjAAnRg7gjWM1MRLYll5n0AfH/0OtVoC
=2Mzg
-----END PGP SIGNATURE-----

--kgkihKxW3Un7xdgA--

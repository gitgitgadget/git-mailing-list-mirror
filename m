From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Newbie question about making a bare repository
Date: Mon, 16 Jun 2008 22:57:19 +0200
Message-ID: <20080616205719.GI29404@genesis.frugalware.org>
References: <4856B7A6.50508@et.gatech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7Pp9tnCne2IvLqV9"
Cc: git@vger.kernel.org
To: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:58:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8LmL-0004Jt-MM
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 22:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbYFPU5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 16:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754081AbYFPU5W
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 16:57:22 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54047 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbYFPU5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 16:57:21 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B80511B254B;
	Mon, 16 Jun 2008 22:57:19 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E1F1A44699;
	Mon, 16 Jun 2008 22:36:45 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 53CCD11901F0; Mon, 16 Jun 2008 22:57:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4856B7A6.50508@et.gatech.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85232>


--7Pp9tnCne2IvLqV9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2008 at 02:57:42PM -0400, "D. Stuart Freeman" <stuart.freeman@et.gatech.edu> wrote:
> I have a repository that I made with 'git-svn clone' that I'd like to
> make bare but retain the svn info.  Would I just change the "bare" in
> .git/config to true?  Is there anything I have to do to remove the
> working copy info?

change it in foo/.git/config and mv foo/.git foo.git

also don't forget that you'll need 'git --bare svn foo' instead of 'git
svn foo' from now.

--7Pp9tnCne2IvLqV9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhW068ACgkQe81tAgORUJZ/6gCdGBAxCTyb84jwZAv4ZiSl0tNY
uQgAoISe+6VVEn6BTTScR+p33VHmrU+d
=1yVj
-----END PGP SIGNATURE-----

--7Pp9tnCne2IvLqV9--

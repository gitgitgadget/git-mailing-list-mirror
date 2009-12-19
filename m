From: "James P. Howard, II" <jh@jameshoward.us>
Subject: Re: Delete a commit
Date: Sat, 19 Dec 2009 18:43:27 -0500
Message-ID: <20091219234327.GA45385@byzantine.jameshoward.us>
References: <20091219233957.GC29111@marge.bs.l>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=x-unknown;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 01:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM9TW-0003Vk-F8
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 01:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbZLTAQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 19:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbZLTAQh
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 19:16:37 -0500
Received: from byzantine.jameshoward.us ([204.109.63.101]:29707 "EHLO
	byzantine.jameshoward.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbZLTAQh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 19:16:37 -0500
X-Greylist: delayed 1990 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Dec 2009 19:16:37 EST
Received: from byzantine.jameshoward.us (localhost [127.0.0.1])
	by byzantine.jameshoward.us (8.14.3/8.14.3) with ESMTP id nBJNhRdX045417
	for <git@vger.kernel.org>; Sat, 19 Dec 2009 23:43:27 GMT
	(envelope-from jh@jameshoward.us)
Received: (from howardjp@localhost)
	by byzantine.jameshoward.us (8.14.3/8.14.3/Submit) id nBJNhRaS045416
	for git@vger.kernel.org; Sat, 19 Dec 2009 18:43:27 -0500 (EST)
	(envelope-from jh@jameshoward.us)
X-Authentication-Warning: byzantine.jameshoward.us: howardjp set sender to jh@jameshoward.us using -f
Content-Disposition: inline
In-Reply-To: <20091219233957.GC29111@marge.bs.l>
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135510>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 20, 2009 at 12:39:57AM +0100, Bertram Scharpf wrote:

> I fetched a line from the shell's history and accidentally hit
> enter before editing it. Then I had commited some work that was
> not completed. Is there a way to get rid of that commit as if it
> never were there?

If you have committed nothing else in the interim,=20

  git reset HEAD~1

James

--=20
James P. Howard, II, MPA MBCS
jh@jameshoward.us

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJLLWUeAAoJEHPMAEw+5CSeuccIAI8LVzeUoveBOV/yvt0NbtBq
nbNKHVlgsNGrW9c7r5dbbFmtguqhdMEdh8qQ9xDH+4DQgkZjrVzNzzHjOg6leB1v
j7bAXzRcSVBe+LILLdp1CX+rCJyGvyY5u5navoLW9nrZqKN6BFa/DgIlr0/3+OGF
zRMJ80Gv09QMyiMUVE5hctNoPko4i7x1TIufn+kkpkJZ3KfBJVeYm1QUnefuGjb+
hZQWFdpAPtJhT/rmc88a9FDEpyDZYBU9e9cOac4R++RGLoIVw9Z3oF582ILQ4Z0q
r+N8W7K5/RFjsGKeMxg4+Mbs4LZpyQhKeUPUEE5uZCpaY867DqIXCt9+eJwXWXg=
=dxIH
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

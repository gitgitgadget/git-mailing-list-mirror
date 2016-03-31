From: Miklos Vajna <vmiklos@collabora.co.uk>
Subject: Re: Signed-off-by vs Reviewed-by
Date: Thu, 31 Mar 2016 16:35:02 +0200
Message-ID: <20160331143501.GE19857@collabora.co.uk>
References: <20160331123507.GC19857@collabora.co.uk>
 <CAFZEwPMzcqrd8NEP6MH5saXL2KdUKAyN51uuoS5=aeU0aPWjJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:35:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldgo-0008N7-59
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbcCaOfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:35:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48173 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbcCaOfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 10:35:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: vmiklos)
	with ESMTPSA id 5CBE32613C4
Content-Disposition: inline
In-Reply-To: <CAFZEwPMzcqrd8NEP6MH5saXL2KdUKAyN51uuoS5=aeU0aPWjJQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290391>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

On Thu, Mar 31, 2016 at 07:54:47PM +0530, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Are you suggesting to use a different email address for commiting,
> signing off and reviewing?

Let's say project A has a workflow where patch authors and maintainers
add a "Signed-off-by: A B <a@example.com>" line. This is well-supported
by git, various commands have a -s option to add that line.

However, if project B has a workflow where patch authors add no such
line, and reviewers add a "Reviewed-by: A B <a@example.com>" line, then
you have to add that line manually when you do a review.

I suggest to give a bit more support to this workflow in git. One way of
doing that would be to make the Signed-off-by string configurable. I can
look into implementing that, but first I wanted to discuss the idea here
on the list -- perhaps there is a better way to support that. :-)

Typing that line (including copy&pasting your name + email all the time)
is a bit boring.

Regards,

Miklos

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlb9NZUACgkQe81tAgORUJbQBACeOdi99as1JuNMnvGtzh9D7v36
c/YAn2l9HHh4MaiZ3GlFkOeuZlFObVcd
=NDU2
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--

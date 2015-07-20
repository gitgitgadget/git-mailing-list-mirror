From: Bryan Jacobs <b@q3q.us>
Subject: git-subtree with log.date=relative
Date: Sun, 19 Jul 2015 20:03:50 -0400
Message-ID: <20150719200350.10ae4534@q3q.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Vs1VWkk+p3udv1kfl4ycf8a"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 02:12:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGyhJ-0000Mm-5c
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 02:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbbGTAMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 20:12:40 -0400
Received: from mail.q3q.us ([209.40.103.103]:38407 "EHLO mail.q3q.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbbGTAMk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 20:12:40 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jul 2015 20:12:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=q3q.us; s=dkim2;
	t=1437350648; bh=aHfmAz7UD4U38/nDyx0S+FbpNSye4QkyoK46JqtuZcU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=iueTMPkG2SEocxtoPlY0fOkxCRS5ieg6ECgAZIdeHNaUwknqzX5hNWgaKx0dEoSkx
	 nOAHdd41EKjWhRFKg7uSZKtMJjd1fNdBNadpAXQQ9b49LKRONljWnCXtUIUl+Ha49v
	 aR0SYJlaRlSf5GQovnF/4oYUmoRvuBLysgH3aH4nmUN703GVn0tI0BpHc0zWO5dfS1
	 LmIq+tY2Q+huRuDToMDkAscIIhGLzZDhJ592HeR18UzkCjfsAQEjCKrtnwvLnqkdp4
	 sdAmW4jlUkukrSZaUZVYfmPE8qkAIu0Nu8xkQsOC42WnqXPc8LGEiT239YZFlc4XOY
	 VpdH6RCYvpZ827A8dqWm5VLNnkyYEL4PN5a28lgMlNfyFprboMRDwHaJd44jp6xw5g
	 vSP12DGPbeXPGTs2jdCqhIZ3G7aQqmM2RV1UcvwOdAs17Qg6vsgEwVhzu293Y6VzP1
	 HJukhOlRpyktJrveuigh9+729TSp5AmI/K5TZJ4x+mLVfoYKqSnYZMrZk90g/LeOM9
	 qn+nkcnUO4pH7/ttkLAlpHOnbVS54T3gkxeSXhjHKqx9rjtVKuZ81VlmpqA3auFZHq
	 PxnPPstGpAvF4rhGXGSwTSOwirUUawa1lKOmHes4oCIHGvH4dMiOY9LTyFAsI8kqm+
	 f/bfIBpWK+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274301>

--Sig_/Vs1VWkk+p3udv1kfl4ycf8a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear git Developers,

When setting log.date=3Drelative in ~/.gitconfig, all "git subtree push"
commands fail with errors like this:

git push using:  ../../repos/second master
fatal: invalid date format: 8 minutes ago
Can't copy commit 10827bbf18aa17108e07039d9c125000889a4365

I believe git subtree is making a call to git log and relying on the
dates in the output being machine-readable instead of human-readable.
It should pass --date=3Ddefault if it wants to ensure the default date
format is used.

Bryan Jacobs

--Sig_/Vs1VWkk+p3udv1kfl4ycf8a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVrDroAAoJEK0vMvSakaIQqTUP/2wj5CZMYEPp731QnMdH/b2k
WiqpwGRspnHVKI5xC+2wzwkD62ecYQ4ogIo88XRfW2mEvbjs8wtalaLInKykrGsZ
xGo33C+0YXtw3VfIM4dGpeQQEyHvyxaHbwSVr2q6cYSjvKWZQxaFKOCjeCKxxOJs
tBm7b+s1dTRyxd5p2rt1fN2yPyOVhclKpGUCJ3LRtEnquub9izOnycgFGebFCgeN
s+UqGYXtWde+jSDwMYz9u3RWQ2OTatP0eUcARGDS77jIGRZlI+3lTqpvMDbb7KoC
depzT3pRvcZNPI83hX03OaqdSTBTZVnmVt3rXmdvhUp2MT+ZEREpOuzw2SietGvL
035tYFQeZkIZR+49tYPR7g9MTbpnNAdnNzfF+1AffXLXY5rjWKk3JZgN+yVtwU4/
U7hIuGk9qfIEjmNwPO4wh5UM8dDnMqurC6en6QKCI6skq8tAEH/nOABeWLgAgOFu
QNXK/W+93dlc8AdIg+Po3Ls5vsAyH+Ty19YGpcHzIKpuyZgcZDorrgcQ5nxFfwPI
lVnkWVS+vGCKbTYBA5wBfMSSIMIh33advh3v4aR3E3717Ov4eGvHFPuZfkU0klLr
WrZZE601LLdbFnYd4kiVcL92CW2M8WWRPvUrOSvnDgXcKTLN6xzTIXff9AwcDu6k
UOitBWIgCklLEeXWzPqD
=6SKP
-----END PGP SIGNATURE-----

--Sig_/Vs1VWkk+p3udv1kfl4ycf8a--

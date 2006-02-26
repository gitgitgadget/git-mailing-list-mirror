From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: git-svn and working with tags
Date: Sun, 26 Feb 2006 12:38:35 +0100
Message-ID: <4401933B.2070109@iaglans.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB8F332A0BE942B0F3B543F91"
X-From: git-owner@vger.kernel.org Sun Feb 26 12:40:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDKGG-0001mF-AM
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 12:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWBZLkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 06:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWBZLkU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 06:40:20 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:12557 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1750799AbWBZLkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 06:40:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 6CDE83FA6
	for <git@vger.kernel.org>; Sun, 26 Feb 2006 12:40:02 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24884-04 for <git@vger.kernel.org>;
	Sun, 26 Feb 2006 12:40:00 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 897EC3F7F
	for <git@vger.kernel.org>; Sun, 26 Feb 2006 12:39:59 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16780>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB8F332A0BE942B0F3B543F91
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi guys,

I am about to use a git/svn construct for a project next week to track
my work and the work of my co-workers.

Reason for this is, that all the others are working on windows-boxes and
I am the lonesome gunman, who wants to work with git on a linux box
contributing the others on svn side.

There is still a lot of work todo, preparing both backends, git and svn,
for serving almost the same content structure.

I think, i can do a little scripting to switch my git-SVN-HEAD to
another branch. But how am i intended to export tags to svn?

tags should simply go to <repos>/tags/<tagname>
branches go to <repos>/branches/<branchname>
master goes to <repos>/trunk

A svn-import should be no problem then. The re-exporting back to one
branch or svn_path is described in git-svn howto. but how about tags?

do i have to consider the tags on svn-side manually?

any ideas/hints?

Sincerly
Nicolas

--------------enigB8F332A0BE942B0F3B543F91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEAZM/SlT0CowElk8RAhJSAJsE9R0L50b+WIZbKkDTf39nOi6NGgCggdhD
y6UZZHACbTSH1zcuIucq0/Q=
=Q7i4
-----END PGP SIGNATURE-----

--------------enigB8F332A0BE942B0F3B543F91--

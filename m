From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Status of GIT for Fedora 10 + gitweb's look
Date: Fri, 20 Mar 2009 13:31:02 -0400
Message-ID: <20090320173102.GA32644@inocybe.teonanacatl.org>
References: <B041B86F1FF246ACBD68051753788FBE@HPLAPTOP>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:32:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkiaK-0005Z6-I4
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 18:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019AbZCTRbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 13:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753146AbZCTRbK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 13:31:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZCTRbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 13:31:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 18834A1B91;
	Fri, 20 Mar 2009 13:31:06 -0400 (EDT)
Received: from inocybe.teonanacatl.org (unknown [173.67.142.121]) (using
 TLSv1 with cipher AES128-SHA (128/128 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 7E237A1B90; Fri, 20 Mar 2009 13:31:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <B041B86F1FF246ACBD68051753788FBE@HPLAPTOP>
X-Listening-To: Nothing
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: E471D75E-1574-11DE-82AE-32B0EBB1AA3C-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113983>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Aaron Gray wrote:
> What I am really after knowing is gitweb on the latest version
> 1.6.2.1 anything like the nice HTML layout on http://git.kernel.org/
> or do I have to do the html formatting myself in the perl code ?

The gitweb included in the 1.6.0.6 packages for F-10 should look
mostly the same as the gitweb used on kernel.org.  As JH mentioned,
you can install that with 'yum install gitweb'.  If you need to modify
them, the options and css should let you do what you need without
editing the perl script.

If you do want to use 1.6.2.1, the rawhide packages should rebuild for
F-10 just fine (do note that the rawhide packages finally caught up
and moved the git-* binaries out of $PATH, something that isn't done
in the stock F-10 packages).

The fedora rawhide git packages are at:

http://mirrors.kernel.org/fedora/development/source/SRPMS/git-1.6.2-1.fc11.=
src.rpm

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When life gives you lemons, make lemonade, pee in it, and serve it to
the people that piss you off.
    -- Jack Handy, Deep Thoughts


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBAgAtBQJJw9LWJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjNLYH/inoUaoyFCH3HrIjpqxWNKnT2FKMHrvgr3Je
gsbcQIiJhOXQzyCICjcJ1wXel2noDyfHrdppr77XSYJEO8zLW/FGansNsFoAFWez
t6FZm2+XxCQubwsk/kNqqVsQ3wUWI9Qv7n0Lc/AfyAC2F/zdmVoEwy2GjKhflxCE
2PdNxNEZN82kXtJZ5F4Qs+C/EmJAiMfEn/2Cw7a8riNz98FRvLtOkAriKwbYwX9y
fnMBmu2HPxg63rOTfG7XSif0uJYB51nxY0ANVWdmPcrv+W19T/UOlKTYY8Ye8+eT
kXpoOVRGx3TPj91iRxJ00qERIbMMzLB2pxflJM5UawqT8QHBxJE=
=Ek64
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

From: martin f krafft <madduck@madduck.net>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sun, 16 Sep 2007 08:08:59 +0200
Message-ID: <20070916060859.GB24124@piper.oerlikon.madduck.net>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 08:09:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWnK0-00056k-BL
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 08:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbXIPGJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 02:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbXIPGJY
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 02:09:24 -0400
Received: from clegg.madduck.net ([82.197.162.59]:56580 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbXIPGJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 02:09:23 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 04D30BA3DD;
	Sun, 16 Sep 2007 08:09:00 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id C50DD9F161;
	Sun, 16 Sep 2007 08:08:59 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 8EBBFB3106; Sun, 16 Sep 2007 08:08:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709151430040.5298@iabervon.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4288/Sun Sep 16 07:22:35 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58296>


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Daniel Barkalow <barkalow@iabervon.org> [2007.09.15.2156 +0200]:
> Configuration options only apply to the local aspects of the repository.=
=20
> That is, when you clone a repository, you don't get the configuration=20
> options from it, in general. And changing configuration options on a=20
> repository does not have any effect on the content it contains. So=20
> configuration options aren't appropriate.

Sure they are. Just like git-commit figures out your email address=20
if user.email is missing from git-config, or core.sharedRepository=20
or core.umask deal with permissions only when you tell them to,=20
you'd have to enable core.track or else git would just do what it
does right now.

> Git doesn't have any way to represent owners or groups, and they
> would need to be represented carefully in order to make sense
> across multiple computers. If you're adding support for
> metadata-as-content (for more than "is this a script?"), you
> should be able to cover all of the common cases of extended stuff,
> like AFS-style ACLs.

Ideally, git should be able to store an open-ended number of
properties for each object, yes.

> And if you want to allow meaningful development with this
> mechanism (as opposed to just archival of a sequence of states of
> a live system), the normal case will be that the metadata beyond
> +x is manipulated by ordinary users in some way other than
> modifying their working directory.

I have no idea what you mean with that.

> So the normal case here will be like working on a filesystem that
> doesn't support symlinks or an executable bit when this is
> important content.

=2E.. and yet, we support symlinks and executable files. But anyway,
I really don't understand what you're trying to say.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"ist gott eine erfindung des teufels?"
                                                 - friedrich nietzsche
=20
spamtraps: madduck.bogus@madduck.net

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7Mh7IgvIgzMMSnURAqlJAKC+B3Io0Vr/aGN7cpTtbf0aYf3v2wCfTRh7
wVIZ4S/4NValFwPmz2Gw6bo=
=hN3b
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--

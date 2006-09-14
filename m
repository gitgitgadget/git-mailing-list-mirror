From: Daniel Carosone <dan@geek.com.au>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 13:19:18 +1000
Message-ID: <20060914031918.GY29625@bcd.geek.com.au>
References: <45084400.1090906@bluegap.ch>
	<20060913225200.GA10186@frances.vorpus.org>
	<1158190921.29313.175.camel@neko.keithp.com>
	<20060914003242.GA19228@frances.vorpus.org>
	<9e4733910609131757l7ce4b637oae18b523b1b7f0a4@mail.gmail.com>
	<20060914015324.GX29625@bcd.geek.com.au>
	<20060914023017.GA31889@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0074527194=="
Cc: Daniel Carosone <dan@geek.com.au>, Keith Packard <keithp@keithp.com>,
	monotone-devel@nongnu.org, Jon Smirl <jonsmirl@gmail.com>,
	dev@cvs2svn.tigris.org, Git Mailing List <git@vger.kernel.org>
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Thu Sep 14 05:19:34 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNhlE-0005CI-HA
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 05:19:32 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GNhlD-0003Im-TT
	for gcvmd-monotone-devel@m.gmane.org; Wed, 13 Sep 2006 23:19:31 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GNhlB-0003IQ-2V
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 23:19:29 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GNhl8-0003Hp-9l
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 23:19:28 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GNhl8-0003Hm-1p
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 23:19:26 -0400
Received: from [203.17.37.1] (helo=geek.com.au)
	by monty-python.gnu.org with esmtp (Exim 4.52) id 1GNhmx-0006bA-R2
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 23:21:21 -0400
Received: by geek.com.au (Postfix, from userid 106)
	id 10A6C49F7B; Thu, 14 Sep 2006 13:19:19 +1000 (EST)
To: Shawn Pearce <spearce@spearce.org>
Mail-Followup-To: Shawn Pearce <spearce@spearce.org>,
	Jon Smirl <jonsmirl@gmail.com>, Keith Packard <keithp@keithp.com>,
	dev@cvs2svn.tigris.org, monotone-devel@nongnu.org,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20060914023017.GA31889@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26977>


--===============0074527194==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7QTDVAgpgOXqPYyV"
Content-Disposition: inline


--7QTDVAgpgOXqPYyV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2006 at 10:30:17PM -0400, Shawn Pearce wrote:
> I don't know exactly how big it is but the Gentoo CVS repository
> is also considered to be very large (about the size of the Mozilla
> repository) and just as difficult to import.  Its either crashed or
> taken about a month to process with the current Git CVS->Git tools.

Ah, thanks for the tip.

> Since I know that the bulk of the Gentoo CVS repository is the
> portage tree I did a quick find|wc -l in my /usr/portage; its about
> 124,500 files.
>=20
> Its interesting that Gentoo has almost as large of a repository given
> that its such a young project, compared to NetBSD and Mozilla.  :-)

Portage uses files and thus CVS very differently, though.  Each ebuild
for each package revision of each version of a third-party package
(like, say, monotone 0.28 and 0.29, and -r1, -r2 pkg bumps of those if
they were needed) is its own file that's added, maybe edited a couple
of times, and then deleted again later as new versions are added and
older ones retired.  These are copies and renames in the workspace,
but are invisible to CVS.  This uses up lots more files than a single
long-lived build that gets edited each time; the Attic dirs must have
huge numbers of files, way beyond the number that are live now.

This lets portage keep builds around in a HEAD checkout for multiple
versions at once, tagged internally with different statuses.
Effectively, these tags take the place of VCS-based branches and
releases, and are more flexible for end users tracking their favourite
applications while keeping the rest of their system stable.

If they had a VCS that supported file cloning and/or renaming, and
used that to follow history between these ebuild files, things would
be very different. There are some interesting use cases for VCS tools
in supporting this behaviour nicely, too. =20

--
Dan.
--7QTDVAgpgOXqPYyV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (NetBSD)

iD8DBQFFCMo2EAVxvV4N66cRAuvNAJ9QSb6JwE6c3BmDcBZX8opUUgXDaACeKmr0
qFPmWiDkSLettOt3Nw0WkNI=
=usK3
-----END PGP SIGNATURE-----

--7QTDVAgpgOXqPYyV--



--===============0074527194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Monotone-devel mailing list
Monotone-devel@nongnu.org
http://lists.nongnu.org/mailman/listinfo/monotone-devel

--===============0074527194==--

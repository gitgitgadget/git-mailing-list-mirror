From: Daniel Carosone <dan@geek.com.au>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 11:53:24 +1000
Message-ID: <20060914015324.GX29625@bcd.geek.com.au>
References: <45084400.1090906@bluegap.ch>
	<20060913225200.GA10186@frances.vorpus.org>
	<1158190921.29313.175.camel@neko.keithp.com>
	<20060914003242.GA19228@frances.vorpus.org>
	<9e4733910609131757l7ce4b637oae18b523b1b7f0a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1779258612=="
Cc: dev@cvs2svn.tigris.org, Keith Packard <keithp@keithp.com>,
	monotone-devel@nongnu.org, Git Mailing List <git@vger.kernel.org>
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Thu Sep 14 03:53:40 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNgQ4-0005iI-4R
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 03:53:36 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GNgQ3-0004Qb-9J
	for gcvmd-monotone-devel@m.gmane.org; Wed, 13 Sep 2006 21:53:35 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GNgQ0-0004QL-0p
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 21:53:32 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GNgPy-0004Q1-LL
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 21:53:31 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GNgPy-0004Py-EU
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 21:53:30 -0400
Received: from [203.17.37.1] (helo=geek.com.au)
	by monty-python.gnu.org with esmtp (Exim 4.52) id 1GNgRn-0006Z8-9r
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 21:55:24 -0400
Received: by geek.com.au (Postfix, from userid 106)
	id 4B90B49F7B; Thu, 14 Sep 2006 11:53:24 +1000 (EST)
To: Jon Smirl <jonsmirl@gmail.com>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Keith Packard <keithp@keithp.com>, dev@cvs2svn.tigris.org,
	monotone-devel@nongnu.org, Git Mailing List <git@vger.kernel.org>
In-Reply-To: <9e4733910609131757l7ce4b637oae18b523b1b7f0a4@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26973>


--===============1779258612==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NnzFKeVCepadXAxv"
Content-Disposition: inline


--NnzFKeVCepadXAxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2006 at 08:57:33PM -0400, Jon Smirl wrote:
> Mozilla is 120,000 files. The complexity comes from 10 years worth of
> history. A few of the files have around 1,700 revisions. There are
> about 1,600 branches and 1,000 tags. The branch number is inflated
> because cvs2svn is generating extra branches, the real number is
> around 700. The CVS repo takes 4.2GB disk space. cvs2svn turns this
> into 250,000 commits over about 1M unique revisions.

Those numbers are pretty close to those in the NetBSD repository, and
between them these probably represent just about the most extensive
public CVS test data available.=20

I've only done imports of individual top-level dirs (what used to be
modules), like src and pkgsrc, because they're used independently and
don't really overlap.

src had about 180k commits over 1M versions of 120k files, 1000 tags
and 260 branches. pkgsrc had 110k commits over about half as many
files and versions thereof.  We too have a few hot files, one had
13,625 revisions.  xsrc adds a bunch more files and content, but not
many versions; that's mostly vendor branches and only some local
changes.  Between them the cvs ,v files take up 4.7G covering about 13
years of history.

One thing that was interesting was that "src" used to be several
different modules, but we rearranged the repository at one point to
match the checkout structure these modules produced (combining them
all under the src dir).  This doesn't seem to have upset the import at
all.  Just about every other form of CVS evil has been perpetrated in
this repository at some stage or other too, but always very carefully.

--
Dan.

--NnzFKeVCepadXAxv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (NetBSD)

iD8DBQFFCLYUEAVxvV4N66cRAnSbAJ9QFO85tSI+fll68qWVNX8h3zF1nACg+SjH
fZ2Y1EdRcbVouhgoG+6vM6A=
=r978
-----END PGP SIGNATURE-----

--NnzFKeVCepadXAxv--



--===============1779258612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Monotone-devel mailing list
Monotone-devel@nongnu.org
http://lists.nongnu.org/mailman/listinfo/monotone-devel

--===============1779258612==--

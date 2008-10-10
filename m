From: Erik Colson <eco@ecocode.net>
Subject: Re: merge hook
Date: Fri, 10 Oct 2008 12:26:03 +0200
Message-ID: <20081010102603.GC303@Mac2.local>
References: <20081010072148.GB303@Mac2.local> <alpine.DEB.1.00.0810101204540.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 10 12:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoFDS-00072m-6T
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 12:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbYJJK0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 06:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbYJJK0K
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 06:26:10 -0400
Received: from 42.mail-out.ovh.net ([213.251.189.42]:47788 "HELO
	42.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751309AbYJJK0J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 06:26:09 -0400
Received: (qmail 6604 invoked by uid 503); 10 Oct 2008 10:25:46 -0000
Received: from b6.ovh.net (HELO mail432.ha.ovh.net) (213.186.33.56)
  by 42.mail-out.ovh.net with SMTP; 10 Oct 2008 10:25:46 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 10 Oct 2008 10:26:05 -0000
Received: from unknown (HELO localhost) (erik.colson@beavernet.be@77.109.104.221)
  by ns0.ovh.net with SMTP; 10 Oct 2008 10:26:03 -0000
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810101204540.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Ovh-Tracer-Id: 3295227553137475305
X-Ovh-Remote: 77.109.104.221 ()
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97922>


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2008 at 12:07:16PM +0200, Johannes Schindelin wrote:

[..]

> From Documentation/githooks.txt:

thank you for pointing me there

[..]

> I guess that you want to disallow merging in changes from people who=20
> changed files that are none of their business?  If so, it would be nice t=
o=20
> contribute the hook as a patch to contrib/.

wrong guess ;)
The purpose is to check if source code still has debug code in
it. Our policy is to have it removed before reaching master, but
checking by hand is way too buggy ;)

--
erik

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI7y27exs8k4f5tB4RAoXlAJoCMztZs3P3eTTl46sOVVQ6I+961gCdHMW3
bldYEGGl42EUkexsxaNIPFY=
=Zuqb
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--

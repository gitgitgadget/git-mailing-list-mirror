From: Miklos Vajna <vmiklos@frugalware.org>
Subject: git describe weird behaviour
Date: Wed, 10 Nov 2010 02:00:16 +0100
Message-ID: <20101110010016.GC22105@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LlrV9fGC0fe896CO"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 02:00:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFz35-0007da-0h
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 02:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab0KJBAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 20:00:22 -0500
Received: from virgo.iok.hu ([212.40.97.103]:54072 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233Ab0KJBAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 20:00:21 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1581A58095
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 02:00:17 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0ABFB44659
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 02:00:16 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D6575132C041; Wed, 10 Nov 2010 02:00:16 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161116>


--LlrV9fGC0fe896CO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm not sure if this is a bug, so I'm asking.

The frugalware project (git repo:
http://frugalware.org/git/pub/frugalware/frugalware-current ) has the
two latest tags 1.3 and 1.4pre1, somehow git describe HEAD now mentions
1.3 and not 1.4pre1 in the output.

To be more exact:

$ git rev-parse --short HEAD
f25435f

$ git rev-list 1.4pre1..|wc -l
871

So I would exepct 1.4pre1-871-gf25435f. In fact, the output is:

$ git describe
1.3-3028-gf25435f

Or in case I force the usage of the latest tag:

$ git describe --candidate 1
1.4pre1-64725-gf25435f

Does anyone have an idea what's going wrong here?

Thanks.

--LlrV9fGC0fe896CO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzZ7qAACgkQe81tAgORUJbb9gCeMGleDQ1ksgl+vdlRMZmdAjPe
xDgAnRKoClwUxrttj+3ipYGkS+oDoafd
=WJfh
-----END PGP SIGNATURE-----

--LlrV9fGC0fe896CO--

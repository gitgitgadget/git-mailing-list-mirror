From: VMiklos <vmiklos@frugalware.org>
Subject: Re: having problems with building the manpages
Date: Tue, 24 Jul 2007 09:38:19 +0200
Message-ID: <20070724073819.GS31655@genesis.frugalware.org>
References: <20070723182319.GQ31655@genesis.frugalware.org> <Pine.LNX.4.64.0707231937210.32580@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7L9kolmstoDTZ4pm"
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 24 09:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDEyc-0004ji-Sc
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 09:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbXGXHic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 03:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757518AbXGXHic
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 03:38:32 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52148 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499AbXGXHib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 03:38:31 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IDEyR-0000VA-Vw
	from <vmiklos@frugalware.org>; Tue, 24 Jul 2007 09:38:30 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5F2F31868272; Tue, 24 Jul 2007 09:38:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707231937210.32580@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53530>


--7L9kolmstoDTZ4pm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Na Mon, Jul 23, 2007 at 07:40:04PM +0100, Julian Phillips <julian@quantumfyre.co.uk> pisal(a):
> Are you using docbook xsl 1.72?  There are known problems building the
> manpages with that version.  1.71 works, and 1.73 should work when it
> get released.

yes, i'm was uging 1.72. in the mentime 1.73 has been released, here is
the error i get when using it:

asciidoc -b docbook -d manpage -f asciidoc.conf \
                 -a asciidoc7compatible -agit_version=1.5.2.4 -o git-add.xml+ git-add.txt
mv git-add.xml+ git-add.xml
xmlto -m callouts.xsl man git-add.xml
runtime error: file file:///usr/share/xml/docbook/manpages/other.xsl line 129 element call-template
The called template 'read-character-map' was not found.
Note: meta date   : no date; using generated date                  git-add
Note: meta date   : see http://docbook.sf.net/el/date              git-add
runtime error: file file:///usr/share/xml/docbook/manpages/other.xsl line 537 element call-template
The called template 'apply-character-map' was not found.
Note: Writing git-add.1
error: file /var/tmp/fst/src/git-1.5.2.4/Documentation/git-add.xml
xsltRunStylesheet : run failed
make[1]: *** [git-add.1] Error 1
rm git-add.xml
make[1]: Leaving directory `/var/tmp/fst/src/git-1.5.2.4/Documentation'
make: *** [doc] Error 2

thanks,
- VMiklos

--7L9kolmstoDTZ4pm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGpaxre81tAgORUJYRApcsAJ0U3RK7hqFdfGM5N37ScOXt8txhtQCfUqgN
RehYw00RRgdedP7bVlb5ulQ=
=mzpy
-----END PGP SIGNATURE-----

--7L9kolmstoDTZ4pm--

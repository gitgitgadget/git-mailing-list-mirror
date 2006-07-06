From: Bennett Todd <bet@rahul.net>
Subject: Re: git2rss --- publish changes from git-log via RSS
Date: Thu, 6 Jul 2006 12:53:28 +0000
Message-ID: <20060706125328.GA19414@rahul.net>
References: <20060704191135.GB10534@rahul.net> <e8elej$4sa$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 14:53:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyTMi-0002rO-Md
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 14:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWGFMxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 08:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWGFMxv
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 08:53:51 -0400
Received: from og.latency.net ([64.21.79.2]:36870 "EHLO og.latency.net")
	by vger.kernel.org with ESMTP id S1030245AbWGFMxv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 08:53:51 -0400
Received: by og.latency.net (Postfix, from userid 1053)
	id 8917313FB2E; Thu,  6 Jul 2006 08:53:50 -0400 (EDT)
Received: from pic.bent.dom (localhost [127.0.0.1])
	by og.latency.net (Postfix) with ESMTP id C672E13FB2C;
	Thu,  6 Jul 2006 08:53:46 -0400 (EDT)
Received: (from bet@localhost, uid 500)
          by pic.bent.dom (femail 0.97)
          06 Jul 2006 12:53:29 +0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e8elej$4sa$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-Spam-Checker-Version: SpamAssassin asr 3.0.2 (2004-11-16) on og.latency.net
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23385>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

2006-07-04T21:09:32 Jakub Narebski:
> Added to http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#git2rss
> Please correct/expand the info if needed.

Thanks. But I'm not sure it belongs there. If anybody else turns out
to be interested, and we work out how to update it to pull out the
Bent-specific stuff hardcoded in it, and document the result, then
maybe. At best it might be an example someone could copy, if they
wanted to publish an rss of git-log, with some hardwired assumptions
about the log format and the archive structure. It's not based on
darcs2rss, it's a complete rewrite, and much simpler since I used
XML::RSS::SimpleGen.

> BTW. gitweb includes RSS feed, see e.g.:
>   http://www.kernel.org/git/?p=git/git.git;a=rss
>   http://www.kernel.org/git/?p=git/git.git;a=opml

Can it be used for offline generation? I don't run any CGIs on my
webserver, I re-generate bent.xml whenever I push any updates.

-Bennett

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFErQfIHZWg9mCTffwRAurXAJ9hNJTEa85uWCa4S6NI42u2wLx4JwCdFINN
YQjejDJolVNTvE0wIOwNs5s=
=UZvP
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

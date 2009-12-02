From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 2 Dec 2009 18:11:18 +0100
Message-ID: <20091202171117.GY31763@genesis.frugalware.org>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sTC4Ri5uc2u6z9Yo"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 18:11:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFsjw-00081G-ET
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbZLBRLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754800AbZLBRLO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:11:14 -0500
Received: from virgo.iok.hu ([212.40.97.103]:38138 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755217AbZLBRLM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:11:12 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4C6285809B
	for <git@vger.kernel.org>; Wed,  2 Dec 2009 18:11:18 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4052D42F0A
	for <git@vger.kernel.org>; Wed,  2 Dec 2009 18:11:18 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0DAB11240011; Wed,  2 Dec 2009 18:11:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134353>


--sTC4Ri5uc2u6z9Yo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2009 at 01:27:32AM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
> +--date=<date>::
> +	Override the date used in the commit.  The format is the Git
> +	native one and is `<time> SP <offutc>`.

I just noticed that fmt_ident() calls parse_date(), so other formats are
supported as well.

Is there any documentation describing what does parse_date() accept?

Based on t0006-date.sh and the comments in the source, I see 3 supported
formats:

1) <unix timestamp> <timezone>

2) A format like 2008-12-02 18:04:00

3) RFC 2822 (Thu, 21 Dec 2000 16:01:07 +0200)

Thanks.

--sTC4Ri5uc2u6z9Yo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksWn7UACgkQe81tAgORUJYIqQCeJ/IWVntl2cqlW0hmjyFEhqg3
hA4AnjAM+G0qUFgLocbw84UKHkWOTV9W
=QBg0
-----END PGP SIGNATURE-----

--sTC4Ri5uc2u6z9Yo--

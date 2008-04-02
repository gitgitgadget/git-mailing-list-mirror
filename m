From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 3/3] contrib/hooks: add an example pre-auto-gc hook
Date: Wed, 2 Apr 2008 22:45:24 +0200
Message-ID: <20080402204524.GZ3264@genesis.frugalware.org>
References: <cover.1207049697.git.vmiklos@frugalware.org> <7vhceldv12.fsf@gitster.siamese.dyndns.org> <20080402011447.GO3264@genesis.frugalware.org> <7vwsngaoqg.fsf@gitster.siamese.dyndns.org> <20080402190240.GV3264@genesis.frugalware.org> <7vtzik848t.fsf@gitster.siamese.dyndns.org> <cover.1207164676.git.vmiklos@frugalware.org> <96017502f7bca67a14f9a09d19c8ea42bde78949.1207167342.git.vmiklos@frugalware.org> <7vfxu4808c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CVXKxAdNG2kQIXaJ"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 22:47:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh9s9-0003de-Hm
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 22:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764200AbYDBUpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 16:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762026AbYDBUpe
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 16:45:34 -0400
Received: from virgo.iok.hu ([193.202.89.103]:25306 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933439AbYDBUp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 16:45:29 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C57B61B2503;
	Wed,  2 Apr 2008 22:45:25 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 886DB446A6;
	Wed,  2 Apr 2008 22:42:14 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 12F821190543; Wed,  2 Apr 2008 22:45:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vfxu4808c.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78715>


--CVXKxAdNG2kQIXaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2008 at 01:34:27PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> If it is "can't tell", then it is "can't tell".  Don't you want to err on
> the safe side?

First, I think "can't tell" almost never means "on battery" these days,
since the necessary kernel support is enabled by the distro's hotplug
scripts.

Second, that's what we do in case we fail to read for example
/sys/class/power_supply/AC/online: just silently redirect the error to
/dev/null and assume we are not on battery.

I would say it does not worth doing so, but feel free to kick me if it's
a must. :)

--CVXKxAdNG2kQIXaJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkfz8GQACgkQe81tAgORUJbNEwCfXv/ZSZ59TbfjlW651cbmlala
YNoAnAmQx38fi+H2eAplyhDxT2h0mI3B
=DC3k
-----END PGP SIGNATURE-----

--CVXKxAdNG2kQIXaJ--

From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 09:39:17 -0500
Message-ID: <43CE5315.8060008@michonline.com>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com> <20060118142139.GQ28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig697ADBD9BEF7B8491DD09E11"
Cc: Mathias Waack <Mathias.Waack@rantzau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 15:40:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzETM-0007iV-15
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 15:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWAROjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 09:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWAROjd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 09:39:33 -0500
Received: from mail.autoweb.net ([198.172.237.26]:48347 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1030327AbWAROjc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 09:39:32 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EzETA-0007Gr-JQ; Wed, 18 Jan 2006 09:39:30 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1EzET4-00083V-LV; Wed, 18 Jan 2006 09:39:28 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1EzET3-0001BI-Oz; Wed, 18 Jan 2006 09:39:21 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060118142139.GQ28365@pasky.or.cz>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14831>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig697ADBD9BEF7B8491DD09E11
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Petr Baudis wrote:

>Dear diary, on Wed, Jan 18, 2006 at 03:09:17PM CET, I got a letter
>where Ryan Anderson <ryan@michonline.com> said that...
>  
>
>>... Why would that be the optimal method?
>>
>Ow. I suppose that's what you call "blinded by invalid implicit
>assumptions". Obviously, if you are ok with such a grand move, this is
>the best.
>  
>
Sorry, that came out a bit harsher than I had intended.

>This also reminds me that I should finally merge the cg-mv patch.
>
>>	git fetch ../r1/
>>	GIT_INDEX_FILE=.git/tmp-index git-read-tree FETCH_HEAD
>>	GIT_INDEX_FILE=.git/tmp-index git-checkout-cache -a -u
>>	git-update-cache --add -- $(GIT_INDEX_FILE=.git/tmp-index git-ls-files)
>>	cp .git/FETCH_HEAD .git/MERGE_HEAD
>>	git commit
>>    
>>
>
>But if you want to have an idea what's actually going on on the high
>level, perhaps the
>
>	cd r2
>	cg-branch-add r1 ../r1/.git
>	cg-fetch r1
>	cg-merge -j r1
>
>might be easier. ;-)
>
Ah, yes, cg-merge seems like it might be somewhat simpler here.


-- 

Ryan Anderson
  sometimes Pug Majere


--------------enig697ADBD9BEF7B8491DD09E11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDzlMZfhVDhkBuUKURAnOmAJwKlQveHXKP8kiNm7QLBzm9ha3upwCgiMUb
DOuUTfGtwo/NuUmvjQkxHSY=
=RS85
-----END PGP SIGNATURE-----

--------------enig697ADBD9BEF7B8491DD09E11--

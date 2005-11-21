From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [RFC] git-format-patch options
Date: Mon, 21 Nov 2005 14:11:35 -0500
Message-ID: <43821BE7.5000306@michonline.com>
References: <20051121182737.43012.qmail@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA49DC27559A7CE46531CD7D1"
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 20:13:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeH4s-0008Dm-3A
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 20:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVKUTLm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 14:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVKUTLm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 14:11:42 -0500
Received: from mail.autoweb.net ([198.172.237.26]:33214 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932456AbVKUTLl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 14:11:41 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.50)
	id 1EeH4l-0002T3-HB; Mon, 21 Nov 2005 14:11:39 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EeH4l-0004rl-00; Mon, 21 Nov 2005 14:11:39 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1EeH4l-0007mN-3a; Mon, 21 Nov 2005 14:11:39 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: ltuikov@yahoo.com
In-Reply-To: <20051121182737.43012.qmail@web31811.mail.mud.yahoo.com>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12468>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA49DC27559A7CE46531CD7D1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Luben Tuikov wrote:
> --- Andreas Ericsson <ae@op5.se> wrote:
> 
> 
>>Here's how to automate it.
>>
>>git format-patch $(git rev-list --max-count=2 <commit-ish> | tail -n 
>>1)..<commit-ish>
> 
> 
> I've a similar script, called
> "git-format-commit-patch <commit-ish>" which is slightly
> more involved.
> 
> 
>>Either way, you need to know <commit-ish>, but this format should be 
>>fairly easy to add to git-format-patch. If you do, please
> 
> 
> How about git-format-patch --commit <commit-ish>
> to generate the formatted patch of only what _that_ commit
> introduced? (i.e. <parent>..<commit-ish>)

Doesn't git-format-patch $commit^1..$commit do what you want?


--------------enigA49DC27559A7CE46531CD7D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDghvqfhVDhkBuUKURAoVeAJ9OC9wOujC3UuokNgdGoyYxMqURswCgyDNC
MbgB74h8IH96hYH0aFpc+Pk=
=bva3
-----END PGP SIGNATURE-----

--------------enigA49DC27559A7CE46531CD7D1--

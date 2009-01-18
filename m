From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] expand --pretty=format color options
Date: Sun, 18 Jan 2009 18:13:21 +0100
Message-ID: <49736331.8010003@lsrfire.ath.cx>
References: <20090117153846.GB27071@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:14:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObEV-0004Bz-Bd
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456AbZARRNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 12:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759898AbZARRNY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:13:24 -0500
Received: from india601.server4you.de ([85.25.151.105]:36644 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556AbZARRNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:13:23 -0500
Received: from [10.0.1.101] (p57B7E094.dip.t-dialin.net [87.183.224.148])
	by india601.server4you.de (Postfix) with ESMTPSA id 112322F8046;
	Sun, 18 Jan 2009 18:13:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090117153846.GB27071@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106245>

Jeff King schrieb:
> Currently, the only colors available to --pretty=3Dformat
> users are red, green, and blue. Rather than expand it with a
> few new colors, this patch makes the usual config color
> syntax available, including more colors, backgrounds, and
> attributes.
>=20
> Because colors are no longer bounded to a single word (e.g.,
> %Cred), this uses a more advanced syntax that features a
> beginning and end delimiter (but the old syntax still
> works). So you can now do:
>=20
>   git log --pretty=3Dtformat:'%C(yellow)%h%C(reset) %s'
>=20
> to emulate --pretty=3Doneline, or even
>=20
>   git log --pretty=3Dtformat:'%C(cyan magenta bold)%s%C(reset)'
>=20
> if you want to relive the awesomeness of 4-color CGA.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Ren=C3=A9: I saw you mention an end goal of implementing the other --=
pretty
> formats in terms of --pretty=3Dformat:. So maybe this will help just =
a
> little.

Nice!

Another step would be for --pretty=3Dformat to respect the color config=
,
i.e. it shouldn't print any colour codes if colouring is turned off or
if set to auto while writing to file or pipe.

Ren=C3=A9

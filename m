From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 3 Dec 2009 17:00:20 -0500
Message-ID: <20091203220020.GS23717@inocybe.localdomain>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
 <m2hbs85koj.fsf@igel.home> <4B17ABE3.6060003@drmicha.warpmail.net>
 <m2d42w5fqq.fsf@igel.home> <4B17D078.6080000@drmicha.warpmail.net>
 <20091203150323.GI23717@inocybe.localdomain>
 <7viqco54xh.fsf@alter.siamese.dyndns.org>
 <20091203202738.GP23717@inocybe.localdomain>
 <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="3wfpuDtTLg8/Vq6g"
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 23:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGJj3-0007PD-IN
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 23:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbZLCWAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 17:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZLCWAZ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 17:00:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbZLCWAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 17:00:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77034850FE;
	Thu,  3 Dec 2009 17:00:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=icYQy6C6g/YpvInTzK9d+spMvcA=; b=aFe0WjP
	e3trCrXle3hcZvMKSIi1R1t8/sLdkZ/Q2eOsFXq9lTuUnokNnKFTv1PunTfxQulV
	C1soeduhlae9qGvlIZjtdqWYPa5rRr15D2oK8H+fc5lzmpvLt03CxgThSM4kqw35
	8k89DWRgyvrQk4NAFwlIvDAjAt68+lSLdubU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=PRWsxxCooD9D/xsFXYapyrrN8q3F0kS+K
	+WjMRLg1Wi4Z0uuzv27iQPgoZq6S/XoIduVBG9wy0e/orN7GrE6YnBsYpeGs6KBf
	8QzgeqzkxcXdy9wSUUjxlALng0GYa/7xXEsHx7hU11s1IXa2777+VJhOXHGvf5Db
	FEn75YT0eE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F001D850FA;
	Thu,  3 Dec 2009 17:00:25 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43B35850F7; Thu,  3 Dec
 2009 17:00:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 430E61A8-E057-11DE-9F1F-9F3FEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134479>


--3wfpuDtTLg8/Vq6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> This is what I plan to use.
>
> -- >8 ---
> From: Junio C Hamano <gitster@pobox.com>
> Date: Thu, 3 Dec 2009 11:12:32 -0800
> Subject: [PATCH] Documentation: xmlto 0.0.18 does not know --stringparam
>
> Newer DocBook stylesheets want man.base.url.for.relative.links
> parameter set when formatting manpages with external references
> to turn them into full URLs, and leave a helpful "you should
> set this parameter" message in the output.  Earlier we added
> the MAN_BASE_URL make variable to specify the value for it.
>
> When MAN_BASE_URL is not given, it ought to be safe to set the
> parameter to empty; it would result in an empty leading path for
> older stylesheets that ignore the parameter, and newer ones
> would produce the same "relative URL" without the message.
>
> Unfortunately, older xmlto (at least version 0.0.18 released in
> early 2004 that comes with RHEL/CentOS 5) does not understand
> the --stringparam command line option, so we cannot add the
> parameter definition unconditionally to the command line.  Work
> it around by passing the parameter only when set.

Is it worth sidestepping the xmlto part entirely?  If we set this
directly in a .xsl file, it will work on older systems without any
effort.  Then we can default MAN_BASE_URL to something and let distro
packagers override it.

I tested with this in Documentation/manpage-base.xsl on a CentOS 5 box
and it builds fine, leaving no cruft in the man pages regarding the
man.base.url...

<!-- set a base URL for relative links -->
<xsl:param name=3D"man.base.url.for.relative.links"
       >/path/to/git/docs</xsl:param>

Of course, the relative links looked just like they did in older
docbook releases:

       1. Everyday Git
          everyday.html

Is it worth the effort to have @@MAN_BASE_URL@@ in
Documentation/manpage-base.xsl or similar and replace it at build
time?

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Just because everything is different doesn't mean anything has
changed.
    -- Irene Peter


--3wfpuDtTLg8/Vq6g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJLGDTvJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjshkH/ivRmrvF+g1272BC8eaj+uJBKShk2qYoBXvr
odpybKuhsNy11q7R01AVsgwmkcxlsvc75gOFvXmxF9nlp5F390dT336HrO0jIDIK
R37JHYxpMD8WKMBXjA78ZJ9HsrGQYFwYgNgXJcRZJcM9588MCUoLqZ+m582pF3dg
5hl9/GXwWLDeLCIKv+9efW9ZVekWP/k8ykO/uaNPMyCUL2YhrsMGU0m5iXpmd5fq
6dqqHENCl8lVwKlwY4bxaQvPnhBOWwCkroVlxLSJGdPyPOvxh6g64r/QCMvCxv8t
YcKQKfsJj4wnY54YHRSZuCZgdHz+Pi6uXHijdMljYBDJK6jQ3qc=
=ZyWu
-----END PGP SIGNATURE-----

--3wfpuDtTLg8/Vq6g--

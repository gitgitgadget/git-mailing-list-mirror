From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] usage.c: remove unused functions
Date: Thu, 25 Sep 2008 13:48:37 +0200
Message-ID: <200809251348.42789.trast@student.ethz.ch>
References: <20080925184104.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4834973.hLIXnAAbJv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 13:49:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KipM0-0004bD-9O
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 13:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbYIYLso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 07:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYIYLsn
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 07:48:43 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:51514 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216AbYIYLsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 07:48:43 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 25 Sep 2008 13:48:42 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 25 Sep 2008 13:48:42 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080925184104.6117@nanako3.lavabit.com>
X-OriginalArrivalTime: 25 Sep 2008 11:48:42.0166 (UTC) FILETIME=[A85B5D60:01C91F04]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96751>

--nextPart4834973.hLIXnAAbJv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Nanako Shiraishi wrote:
> This removes three functions that are not used anywhere.
[...]
> -void set_usage_routine(void (*routine)(const char *err) NORETURN)
[...]
> -void set_error_routine(void (*routine)(const char *err, va_list params))
[...]
> -void set_warn_routine(void (*routine)(const char *warn, va_list params))

These blame to the following commit:

  commit 39a3f5ea7c0352a530338d30d4e618f6b4db84e4
  Author: Petr Baudis <pasky@suse.cz>
  Date:   Sat Jun 24 04:34:38 2006 +0200

      Customizable error handlers
     =20
      This patch makes the usage(), die() and error() handlers customizable.
      Nothing in the git code itself uses that but many other libgit users
      (like Git.pm) will.
  [...]

So apparently the intent was that they would only be used from outside
Git.  I don't know whether anyone still plans to do that, but they're
certainly not "just" unused.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart4834973.hLIXnAAbJv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjbepoACgkQqUud07tmzP3bxwCfQF1lMqSDzwaYtrnNiZoY+DV/
e8kAn0CDk8/kfztswf7nvy5xtxFoQg/l
=RTHl
-----END PGP SIGNATURE-----

--nextPart4834973.hLIXnAAbJv--

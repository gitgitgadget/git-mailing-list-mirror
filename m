From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: StGIT 0.12.1: pulling up to specific commit (tag)
Date: Sat, 17 Mar 2007 11:33:05 +0300
Message-ID: <200703171133.13038.arvidjaar@mail.ru>
References: <20070308201707.GA4250@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2445043.J0hJBS5yjS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 09:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSUMt-0005D9-VQ
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 09:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbXCQIeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 04:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbXCQIeZ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 04:34:25 -0400
Received: from mx28.mail.ru ([194.67.23.67]:20641 "EHLO mx28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbXCQIeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 04:34:24 -0400
Received: from mx2.mail.ru (mx2-2.mail.ru [194.67.23.122])
	by mx28.mail.ru (mPOP.Fallback_MX) with ESMTP id B10D36E8FEF;
	Sat, 17 Mar 2007 11:33:31 +0300 (MSK)
Received: from [85.141.134.31] (port=31929 helo=cooker.local)
	by mx2.mail.ru with asmtp 
	id 1HSULl-000EzF-00; Sat, 17 Mar 2007 11:33:17 +0300
User-Agent: KMail/1.9.6
In-Reply-To: <20070308201707.GA4250@nan92-1-81-57-214-146.fbx.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42427>

--nextPart2445043.J0hJBS5yjS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 08 March 2007, Yann Dirson wrote:
> Hi Andrey,
>
> >Now "stg pull" no more accepts branch name; but I cannot figure how to to
> > the same using git config.
>
> (I must say I am not sure to understand the workflow you're using, I
> suspect there were some missing steps in your mail).
>
> You probably want "stg rebase <parent branch>", unless you have
> commits below your stack base, and that you get a merge commit when
> running "git pull".
>

yes, looks like stg rebase does exactly what I need. Thank you and sorry fo=
r=20
stupid question.

=2Dandrey

--nextPart2445043.J0hJBS5yjS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBF+6fCR6LMutpd94wRArK+AJwMdmejkqjnV6Lbv5QHtJwAd8LJNACfUqWW
cguwb5AoDSX3N2ub0jk5OUQ=
=ML8G
-----END PGP SIGNATURE-----

--nextPart2445043.J0hJBS5yjS--

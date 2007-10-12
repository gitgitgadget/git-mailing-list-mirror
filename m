From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] add simple install replacement
Date: Fri, 12 Oct 2007 17:07:39 +0200
Message-ID: <20071012150739.GJ20753@schiele.dyndns.org>
References: <20071011215237.GI20753@schiele.dyndns.org> <20071012140647.GC7865@efreet.light.src>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Oct 12 17:08:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgM7I-0006d9-Iz
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 17:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbXJLPHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 11:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbXJLPHq
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 11:07:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:59847 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbXJLPHp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 11:07:45 -0400
Received: by nf-out-0910.google.com with SMTP id g13so782030nfb
        for <git@vger.kernel.org>; Fri, 12 Oct 2007 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        bh=vOm5D/xe+A3m6YzmXQ5ZGqVSDC76ZIR27wLyHi7/RUo=;
        b=fUN8zt/BiDZzf50K2RoPAFYSfNOJYV8ajeOml8qF1v2s7JjzGeAKpMHyBedl1EWwYjbaq3wTXW3SlVvGyEQAr9yJ5Ee1GQd9i5l6BMnQsYsSjlmZhskvCPrQdaxIYO/15i7P4+ek0P0F1PAs1JVhT7bjlk5d8dS1rzG6jGR4RYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=c5FJA8zSVoGSdRH+aWEFIlLCpLXlCyP/UF/Jo8xxjTCjBM9oH6UOnt1pJTOMpovMcWhUpSAXvFwQpsNDnY0WIuYGtBONO9OekeFQcKxYNBBCTPPLH1H2tlZN/530/P8IwdJDCHfRQfzKCln/OVygRwppGEFTA+WamjhrcVrJbpY=
Received: by 10.86.78.4 with SMTP id a4mr2436131fgb.1192201663594;
        Fri, 12 Oct 2007 08:07:43 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.112.203])
        by mx.google.com with ESMTPS id f31sm1605898fkf.2007.10.12.08.07.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Oct 2007 08:07:42 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 38C109855EA; Fri, 12 Oct 2007 17:07:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071012140647.GC7865@efreet.light.src>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60695>


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2007 at 04:06:47PM +0200, Jan Hudec wrote:
> On Thu, Oct 11, 2007 at 23:52:37 +0200, Robert Schiele wrote:
> > This patch adds a very simple install replacement script to git.
> > This allows more easy installation on systems that don't have a
> > compatible install.
>=20
> Do you have a particular case where you need it?

We have some machines here where no compatible install was installed.  Sure=
 I
could have built GNU coreutils on all of them but writing this script was j=
ust
more convenient for me.

> No such thing here:
> zsh$ /bin/sh
> $ which getopts
> $
>=20
> Yes, bash and zsh do have that, but my (and I suspect many git users')
> /bin/sh is neither of those. Git scripts should use just POSIX shell
> features for portability.

I just used it because the shells on my machines had it.  My idea was that =
if
someone has a shell with less features we could still replace parts with ev=
en
more basic ways of doing things.

> You may want to have a look at /usr/share/automake-1.9/install-sh (or
> /usr/share/automake<something>/install-sh). It shows how to portably proc=
ess
> options in shell and since it's in fact covered by the MIT/X license (and=
 FSF
> changes are public domain), git could just use it if necessary.

Oh, forgot about that implementation.  Since this version is definitely more
advanced I retract my patch and propose to use that one instead.

> Are you sure reall install would do this? The maual (install(1)) states
> following usage variants:
>=20
>     install [OPTION]... [-T] SOURCE DEST
>     install [OPTION]... SOURCE... DIRECTORY
>     install [OPTION]... -t DIRECTORY SOURCE...
>     install [OPTION]... -d DIRECTORY...

I did not intend to write a full replacement for install but cover only the
cases needed to install git.

> Now however there is nothing saying that SOURCE... is at least two, so is
>=20
>     install git /usr/bin
>=20
> a case of the first or second usage? I would say the second, but your code
> would:
>=20
>     rm -rf /usr/bin
>     cp git /usr/bin

No, in your example /usr/bin is a directory and thus this is:

rm -rf /usr/bin/git
cp git /usr/bin

>     touch "foo*bar" "a b c"
>     ./gitinstall "b*c" "a b c" /tmp
>=20
> ... will copy a lot of files to /tmp (presuming we are in git source
> directory, where tons of files are called builtin-<something>.c) and comp=
lain
> that there is no 'a', no 'b' and no 'c'.

There are no files with special characters in git to be installed.  Again t=
his
was meant a _simple_ replacement for install on systems without a compatible
install just to install _git_, not to reinvent the wheel.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFHD427xcDFxyGNGNcRAgyJAJ0QLh4a/Sv3plsXSceLoa8d3fRnjACfU1/s
mFdK2+N+N6wvIhPx1QvEy70=
=ERs+
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--

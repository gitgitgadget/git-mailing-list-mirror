From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: mergetool feature request - select remote or local
Date: Wed, 14 May 2008 21:25:33 -0400
Message-ID: <200805142125.40027.xenoterracide@gmail.com>
References: <200805140721.13719.xenoterracide@gmail.com> <7vzlqsok0y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart28163371.CNcP1y2R7V";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 03:35:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwSNu-0000L6-0n
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 03:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbYEOBeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 21:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbYEOBeo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 21:34:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:16358 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbYEOBen (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 21:34:43 -0400
Received: by yw-out-2324.google.com with SMTP id 9so104695ywe.1
        for <git@vger.kernel.org>; Wed, 14 May 2008 18:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:message-id;
        bh=2yBcbuSz2OE7q4+1FjSyStdoMJMp5brv87g9IiIhWnw=;
        b=uq/auv2qmIuNRTDBOd3M69hLqVJ3Ms7q6lAfJkev0aTjvubG2TxYykqXtvcu/TcBdWdJNpXEvk4jFzMW/fmp5FAlbqfJYb8kdYdeFkjkclSQlidoabECG3cR/YSAimWVet+FEo9o4UrZcOM9/u6haRSHO5ClyN+b8yMAd4gF53k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:message-id;
        b=sW5GWWzRXepbPc0sOimzY7TK3EgbR7PmMSG/Bqd9s6UDp34sF67EooP1FnU+kIdV3F8pDGcZULfvdNfOL87+Fq6X/GoRL4Y4c12RmiSsLWPWSvs8d55STqbsR8BeiwGYzMx+109AEU0yiYkA5ZkdWt7s/VN6CRfhajn8TYYLfvE=
Received: by 10.150.217.14 with SMTP id p14mr1762927ybg.53.1210815277287;
        Wed, 14 May 2008 18:34:37 -0700 (PDT)
Received: from ?192.168.0.101? ( [75.128.154.7])
        by mx.google.com with ESMTPS id 30sm1093754yxk.4.2008.05.14.18.34.33
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 18:34:34 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <7vzlqsok0y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82164>

--nextPart28163371.CNcP1y2R7V
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 14 May 2008 01:47:09 pm you wrote:
> I never understood why people are using git and not ftp when they say the
> other side is always right, but I see this comes up every once in a while,
> so it would probably be a good thing to support.

well in my case I'm not particularly sure why fast forward didn't just merg=
e=20
them. Seems like I had resolved these changes in master previously. this=20
problem is most annoying when I am resolving the same issues across multipl=
e=20
branches.

> The above "(l)local" and "(m)anual" look inconsistent, and the wording
> should be more like "local, remote or merge".

local,remote, merge is fine and I used the (m) for example because of how i=
t=20
asked me to handle a file existing locally (with mods?) but had been delete=
d=20
in MERGE_HEAD?

> > also in the event of having 20 files with this issue it would be nice to
> > have an option after first starting mergetool for remote all or local
> > all.
>
> This makes me wonder if you are better off not using mergetool in such a
> situation. =A0Instead, perhaps
>
> =A0=A0=A0=A0=A0=A0=A0=A0$ git ls-files -u --no-stage | xargs git checkout=
 MERGE_HEAD

perhaps... I'm not this familiar with git yet.

> might be a better option? =A0The attached is a completely untested
> weather-baloon patch.
>
> If this turns out to be a better approach, perhaps we would further want
> to tweak things to make:
>
> =A0=A0=A0=A0=A0=A0=A0=A0$ git checkout --unmerged MERGE_HEAD [--] [<paths=
pec>...]
>
> to work (if you want "local", you would use "HEAD" instead of
> "MERGE_HEAD").

> Looks easy enough.  Caleb, does this approach fit the situation you
> described better?

um.. is that just a resolution for an merge all (local or remote).

I'm gonna be honest when I say I'm an amateur developer (although I've=20
considered myself a pretty good admin for a few years) and relatively new t=
o=20
git. So I'm getting a bit lost, but it sounds reasonable. It wouldn't affec=
t=20
any files that had been successfully fast forwarded right?

unfortunately I'm not sure how easy testing will be, as this problem doesn'=
t=20
arise with every merge, but has arisen often enough to be a pita.
=2D-=20
Caleb Cushing

my blog http://xenoterracide.blogspot.com

--nextPart28163371.CNcP1y2R7V
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkgrkRMACgkQQ201sGJR45I3fQCfUsq2gH8VI3CkBYzF4Fn62+tU
uacAoIVu+EPofv+wxQA+MzqaGhZc0XWW
=Erla
-----END PGP SIGNATURE-----

--nextPart28163371.CNcP1y2R7V--

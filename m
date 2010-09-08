From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: how do I create a branch and push it so several developers can
 share work?
Date: Wed, 8 Sep 2010 15:40:41 -0700
Message-ID: <20100908224041.GB8466@vfa-6z.perlninja.com>
References: <AANLkTinO9TVyg6EBS1ZuQPS+VWxzODmLan0sDGzFw8eh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 00:40:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtTJx-0003yn-Ms
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 00:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491Ab0IHWkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 18:40:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53034 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab0IHWko (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 18:40:44 -0400
Received: by pzk34 with SMTP id 34so235591pzk.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:x-pgp-key:user-agent;
        bh=2gImjwrOB5/eMNDN+Y2gb/6B4VzjxenXIqFYf2MiHi8=;
        b=cER9K9SGe4M83070hn8zCijTylCr+wq61BZRZHBtYQR+aqfgiYfL2gSz85VEQ82g5O
         /J327oIuYjT7gXXdRJEuF3d2tb15SOcRIeVAMSYGaUQeh1XHyT4yEd4aS99wOCLCLS9o
         Bial4iH8p83/CW+ah/xM5kZCvIkbkxWOC5glU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-pgp-key:user-agent;
        b=OS5Q3MwT48ki6gm88hve0utSTrnYYsZr3OQqcS8KENiLIGn8Gbo5JE+f6EBjIxBsxd
         SVXSm1mO3AX3FsNGaRfApxQ0p0eQKc7rv9mvaLf2xQ25pLRUJIXOhBhvP8Z5rxCbQAeH
         6vJu1DC2ZrgldVsLiGv0dOFOlXDz4hyeu47i0=
Received: by 10.142.191.12 with SMTP id o12mr265917wff.301.1283985644190;
        Wed, 08 Sep 2010 15:40:44 -0700 (PDT)
Received: from localhost (66.239.37.190.ptr.us.xo.net [66.239.37.190])
        by mx.google.com with ESMTPS id 9sm566109wfd.0.2010.09.08.15.40.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 15:40:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinO9TVyg6EBS1ZuQPS+VWxzODmLan0sDGzFw8eh@mail.gmail.com>
X-PGP-Key: http://technosorcery.net/pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155820>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 08 Sep 2010 18:31:30 -0400, Robert Buck wrote:
>=20
> We just switched over to git and also use gitolite.
>=20
> To create a new branch and push it so a team of developers can
> collaborate on that branch I performed the following commands:
>=20
> Listed available tags:
> git fetch --tags
>=20
> Listed available branches, which for me only showed one, master:
> git branch
>=20
> Created the branch off the tag:
> git branch fullers tagduvel
>=20
> Checked out the branch to verify the contents:
> git checkout fullers
> ...
>=20
> Push the branch to the remote repository:
> git push origin fullers
>=20
> Now, when I clone the repository and list the branches I only see
> 'master'. If I list the branches with the -a option I see something I
> did not anticipate:
> git branch -a
> * master
>   remotes/origin/HEAD -> origin/master
>   remotes/origin/duvel
>   remotes/origin/fullers
>   remotes/origin/master
>=20
> What I had expected was a fullers branch.
>=20
> So apparently I did something very wrong here. What did I do wrong?
>=20
> Thanks,
>=20
> Bob

You didn't do anything wrong at all.  That's exactly what I'd expect to
see at the end.  Git doesn't automatically create local branches (the
ones without remotes/.../ in front) for any branches other than the one
pointed to by remotes/origin/HEAD.

The other developers will still have your fullers branch available to
them, but if they want to do any work on it, they'll need to do
something like "git checkout -b fullers origin/fullers" to create a
local branch, which they can modify.

--=20
Jacob Helwig

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQGcBAEBAgAGBQJMiBDiAAoJEHJabXWGiqEBu1cL+gNCu5BiRFytPSi7IsjPNk81
dPO6AX69K1hq22eShO0Li62NPDhM4B8H5aXAlfdtjVLz/VdRrAiuBaW2zX0eUaQ6
i7k3vl+QeyDt02UphG9mM8dEYivrh7UUozQ3OVTYitkN5+3kmfg7tw+7pF7+Z6Et
LZ7bRUb3pzEaD8sKSKNbqjSpj9bqo2aCdgZFd+fE8yzNDmpE6wQby9vks15IOtPd
Skh+SjhmD9yNL6LC3+8989muxXomi2gZvXIcCyBy/ECexeLSTOQGH6JX086TIqus
rVKn7UNNncNzB2Q/lY8VM89A7zTyEdFhIbh8xkbEEGPGkGTU3t/TOwANGU0Q3rRO
ymNJYLhg9cg+JWnO04f5gTPI66df4J16ctqIEWqBiqK6gm+8/VlLyz2H4yIvxRfW
zocPp3ae/JsKIYKAqBPwFaeNgW4mHMmLlnv6Gc96ZscFE66dj5HgwuY80B6pNSqR
U3H3VJGWNJsAceByhArsaytrzLURbxqpE4a79IuVIg==
=fj56
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--

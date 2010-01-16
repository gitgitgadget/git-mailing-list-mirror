From: =?iso-8859-1?q?Adri=E1n_Ribao_Mart=EDnez?= <aribao@gmail.com>
Subject: Re: Integration-Manager Workflow
Date: Sat, 16 Jan 2010 20:47:37 +0100
Message-ID: <201001162047.38010.aribao@gmail.com>
References: <201001161849.32211.aribao@gmail.com> <87r5ppx42f.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7310305.GIKsW3HLS6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 20:47:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWEcf-0006Ju-0i
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 20:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab0APTro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 14:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800Ab0APTro
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 14:47:44 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50249 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab0APTrn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 14:47:43 -0500
Received: by ewy19 with SMTP id 19so1974266ewy.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 11:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=MQlyOgAN3B51td2zhFAWJD6AVrs05twDxXNHqmjK/NA=;
        b=bCihPSaybQeByU8UOUGOmTzZRTSPJzTCGLsr1QoJem3mpNjTxcHaAjJRSDnWaJHZ9E
         cwwz9V3kPc3aYC5zASAGZyLa00SQLh53thnG3iT6/JPTHW+52sBEIf3IQprRDrpoaWvO
         KMMEKw2ZFz9k5qNk8RQDSqcjMfZU6HxvjU8Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=USF3k7znuJjKXNxcIbUzyJWxz23inpM+XBSALaLie2luzYqjhWJIBQReG30ZQVxUbe
         6RezwDGJHrBi9PzzVnk5erYNjNXTriv7CYyODSivQMYcE720DAK6XXpkszhPaxY5SYU/
         5CTSpbOaMu5VtmXVyAfs3Y69RSMWP/BbMqWiE=
Received: by 10.216.85.70 with SMTP id t48mr1374122wee.84.1263671261158;
        Sat, 16 Jan 2010 11:47:41 -0800 (PST)
Received: from debian.localnet (93.160.222.87.dynamic.jazztel.es [87.222.160.93])
        by mx.google.com with ESMTPS id p37sm2393265gvf.8.2010.01.16.11.47.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 11:47:40 -0800 (PST)
User-Agent: KMail/1.12.4 (Linux/2.6.32-trunk-amd64; KDE/4.3.4; x86_64; ; )
In-Reply-To: <87r5ppx42f.fsf@troilus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137257>

--nextPart7310305.GIKsW3HLS6
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Adri=E1n Ribao Mart=EDnez writes:
>=20
> > What happens if they accidentally work in the develop branch instead of=
 creating a new one? What should we do?
> > I think I should never fetch from teamx.myserver.net to avoid this prob=
lem and instead track the branch like in step 2. Is this correct?
>=20
> It is simpler than that.
>=20
> If you just use "git remote add teamx teamx.myserver.net:/...." (rather
> than cloning your integration repository from one of those
> repositories), it will leave all your local branches alone -- any
> changes to teamx.myserver.net's "develop" branch will only show up in
> the teamx/develop tracking branch.

I think this is a stupid question but, how do I bring the feature1 branch f=
rom teamx to my local repository?

>=20
> The reason is that a fetch or pull only merges into your develop branch
> if your branch.develop.merge git-config entry specifies an upstream
> branch -- more detail can be found in the git-config man page under
> branch.<name>.remote and branch.<name>.merge.
>=20
> Those entries are set up when you clone from a repository, and through
> some other commands, but if teamx clones from the integration server,
> they can only mess up their own develop branch.  If/when you push into
> teamx's repository from yours, you can forcibly overwrite any of those
> accidental changes.  (Normally, though, the push would only do a
> fast-forward merge -- so if teamx made such a mistake, the merge will
> fail until you address the mismatch.)

I'm not sure if I understand.

1. I bring the feature1 to my local repository.
2. Check if everything is ok
3. Merge or rebase the branch into develop
4. Push the develop changes into the in central repository
5. Push and force the develop changes into the teamx server
6. The developers pull their local repositories from teamx server

Is this correct? What are the commands for all those actions?

>=20
> Michael Poole
>=20

Thank you.

--nextPart7310305.GIKsW3HLS6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAktSF9oACgkQalnHcq94LhmLEQCfdd4/7ML+YhcFQtXVJvD2yCXl
4EoAn1zZidT4v4UV2xwD0IQzuO72ukzk
=0hox
-----END PGP SIGNATURE-----

--nextPart7310305.GIKsW3HLS6--

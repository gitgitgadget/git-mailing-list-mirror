From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Mon, 30 May 2011 15:14:35 +1000
Message-ID: <20110530051434.GA3723@Imperial-SD-Longsword>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20110528230844.GA31498@elie>
 <4DE32138.4050104@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 30 07:14:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQuoQ-0001iN-Ef
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 07:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab1E3FOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 01:14:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46673 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab1E3FOl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 01:14:41 -0400
Received: by pwi15 with SMTP id 15so1494584pwi.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 22:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8hWUww3pOr0sanV8q6yy9XhfQiBCreDUaFHPENk86lY=;
        b=qeKU6awH4fuN2hGLDlBDa7Qp5jp5SSfZmvqp6uRTJoA+YT3v6m4Bce7a/tsjEp1Umf
         ZxkfoXaDghpfDMQYYqp2m6jArq9x/5nfC1lPcl/R811ksFqc8GLhr72NEN2GXK+Zm9Ar
         BvFbfGVec4FGb48C1WyiL93AOgq3aqXkpA+ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MTp3sL7hIocqfyV0CZTLvOrs40e1+uuvWBHAxk5UUbW49675YAZMIFelLDsbMw76c3
         JDclHpu3e0rGYe+qGUPAMg1+yzsD03E+XxkVUROsMqJEWtY1wr80AmTbCsndIl6opIo6
         SMwxQ6bKGDEipHgOTrcW5OAzMr+ZvG2rBOHEo=
Received: by 10.142.208.1 with SMTP id f1mr620932wfg.412.1306732480216;
        Sun, 29 May 2011 22:14:40 -0700 (PDT)
Received: from longsword.imperial.fleet (c114-76-222-200.rivrw3.nsw.optusnet.com.au [114.76.222.200])
        by mx.google.com with ESMTPS id z7sm2893341wff.17.2011.05.29.22.14.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2011 22:14:39 -0700 (PDT)
Received: from tim by longsword.imperial.fleet with local (Exim 4.76)
	(envelope-from <tim@imperial-sd-longsword>)
	id 1QQuoF-000127-7w; Mon, 30 May 2011 15:14:35 +1000
Content-Disposition: inline
In-Reply-To: <4DE32138.4050104@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174721>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2011 at 06:46:48AM +0200, Michael Haggerty wrote:
> On 05/29/2011 01:08 AM, Jonathan Nieder wrote:
> > Agh, "git rebase --abort --keep-head" feels a little too long to be
> > memorable.  Still, hope that helps.
>=20
> It seems like the distinction is analogous to "git reset --soft", so maybe
>=20
>     git rebase --abort --soft

Well, the only problem with that is the "--soft" option refers to the
"reset" command given to git, whereas in your proposed syntax, the
"--soft" option refers to the _other_ option, "--abort".

This may seem a little nit-picky, but such a difference could lead to
confusion.  Perhaps "--soft-abort" or "--soft-abort" would be better?  A
single option to the "git rebase" command rather than a "sub-option"
given to another option.

It just seems to me that all the git commands work this way; "git
command --options-to-command".  An option to another option just seems
too confusing.

Of course, there's the floodgate problem; once you have options to
options, are you going to have options to options to options, ad
infinitum?

--=20
Tim

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJN4ye5AAoJEGNoa2q+dzQWkhcP/00q2vEtltCJEN3Ty4NdI18R
4SDcmgcwFwnqzfU1UkO+a/8KwOXMSnQo+h5ZuD/Mv8ozikPeHPvkCrwQz5sGCS2x
Aj5CDj+P0DPkt6NzhT4+5FTmfYgjdGqksMIzGBMDM6OxqvVPXIKnPLqjhivsHNrH
RBVnvjjlNev6BPjvTm3NluV6Ka5bSu/Uash6+oDsGjFKCp/1ZCl00hZh5SZZ3t06
hDsCSgdHRb0uDv9pJ7jF3DS/UY1CRbpLRnxpTwcYk1DNm7g7H+MR+pe0gDgcGM3W
mmMXdpnRvaAo2S09M1Pf+r9GYA+RIw+vGJE3ikoSRMAb7Qz6D0ZvAxdE6S6jcl3X
26Un/oAx+CdpkLDZkNqBdBJwwMTBb9OvCcILOiiOe2ozjBQ9nGxuqkLax1iJ1LTu
4lWHOlAjXA0ZBbTHqNCNI0qYQgV6RMzdYycAksCbVBAjsKIWFZoI7j4YmCWD7U0z
/86+L1/G1t3mMHdxIveFTqJ8w73G6UFX8BqMkL3ykrO5uJa3/FVzyKx54XyqD4ku
kWhM7IejChRvu06ZU0GnLYMvr/W90Smxs65C0Czw69hCpwkNBA9iINfF6QmeV+ae
RuNq7iF8ZX9qa32M3yXGb8eZFp7Q00WL2uEZ5xmnUlOowORIWZGZvJhmWHwP8aPU
w0gPCZdoxyVDOg0OGvdK
=spbA
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

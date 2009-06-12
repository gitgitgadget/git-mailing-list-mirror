From: "=?utf-8?q?K=C4=81rlis_Repsons?=" <karlis.repsons@gmail.com>
Subject: Re: git shared repository & permission problems
Date: Fri, 12 Jun 2009 14:24:24 +0000
Message-ID: <200906121424.28577.Karlis.Repsons@gmail.com>
References: <200906121213.13365.Karlis.Repsons@gmail.com> <4A325E00.6050504@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5105181.rv1pWh24vl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 16:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF7gY-0001Dd-2j
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 16:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759239AbZFLOYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 10:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754863AbZFLOYa
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 10:24:30 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:36554 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbZFLOY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 10:24:29 -0400
Received: by fxm12 with SMTP id 12so658836fxm.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=+X/dqN+fCyOtMEHvijHIH+T5p+vhCWpU86vg6dvw1s8=;
        b=DhUFRZWbx2oGcQhJKyhR7f9F2/pOu9gmTzgIgnCIP9qNhITq95sHPI5OCFYA7uPBYF
         A/pcNebaufKW2NYIuN4+eCzffT4Of9ZOkyKGE/nVVDf95VZdlVqUxlHz5PQ8RpieMF+5
         vM0iMLJ6J80ff5lFEmvPpvIbzTQvD6JOxxZO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=sY57+oEMKfipESL35gxV/EjjR5lEumyBwENSZwac5mUVmKi2hCtp4v/QiXMokESLeA
         24j8C5aPovu/+RpkDOGssLeWEOkkc1b+PR/m7OhWhqQq9rXIi+7gltxNLgKmuZtqxeum
         MFXtL5vUR0L+vl7Ts4WCPkpaprCaC+P83HTIw=
Received: by 10.103.247.14 with SMTP id z14mr1906092mur.70.1244816670482;
        Fri, 12 Jun 2009 07:24:30 -0700 (PDT)
Received: from ?192.168.7.93? ([85.15.210.9])
        by mx.google.com with ESMTPS id y6sm436781mug.10.2009.06.12.07.24.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Jun 2009 07:24:30 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <4A325E00.6050504@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121425>

--nextPart5105181.rv1pWh24vl
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 12 June 2009 13:54:08 you wrote:
> Am 12.06.2009 14:13 schrieb Ka-rlis Repsons:
> > Things would be fine, but I am having really bad ssh permission problems
> > in here: for example, if there is an empty, initialised git archive and
> > it is pulled to over ssh, the created files have permissions only u=3Dr=
wX,
> > no more. Then subsequently git pulling doesn't work. Maybe you know how
> > to solve it?
>
> Probably your umask is doing this? When you locally create a file (e.g.
> "touch foo"), does it then only have "-rwx------" as well?
No, at client its allright with umask (well, in bash, not konqueror).
Where from is sftp-server receiving its file permission bits for the new=20
files? Maybe some way to change it?

> > Also, in general, how can it be set up, that >1 people have a write
> > access to the same repository? Only by using the same login?
>
> Have a look at the "--shared" option of "git init". That's supposed to
> create shared repositories, i.e. all users of the same group have write
> access.=20

> I'm not exactly sure how to make an existing repo "shared" after=20
> it's been created,
Someone else knows? That would be useful...

> Hope this helps,
>      Dirk
Thanks!

k.

--nextPart5105181.rv1pWh24vl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkoyZRwACgkQHuSu329e3GFfRQCgieyUgvasiNgRumTq3tl6ZVie
D1kAn2wq4JuxdSdEqJAvwOf3S6KCIzBA
=47rt
-----END PGP SIGNATURE-----

--nextPart5105181.rv1pWh24vl--

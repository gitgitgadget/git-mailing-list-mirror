From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 14:18:52 -0800
Organization: Slide, Inc.
Message-ID: <1231885132.14181.38.camel@starfruit>
References: <1231883002.14181.27.camel@starfruit>
	 <200901131606.04634.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-NNU8kN3IPqqfjxzOIhTm"
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:20:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrcV-0005w6-Dk
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbZAMWS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 17:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755460AbZAMWS5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:18:57 -0500
Received: from mx0.slide.com ([208.76.68.7]:42676 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755335AbZAMWS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=I
	nbEiVxS2y91UENUqMcY2/VyN3JgA0BImkf5VTuLPCo=; b=srw0B0xy56O+RUsK7
	0yJKQu0Msm3o3xjfke615kqeT3TAJx628DLEVDWhQT+HyCl5+SXkt8gxyG/47H9K
	mOuJ6KwQ03a5Y0LBNTmjkte4LT3VRNLbZ9Xx2QleqYDHp3DLLiGqiykTEqc3j1v1
	N/zG+ZPYuSok8MDnr2FaN3SqQw=
Received: from nat3.slide.com ([208.76.69.126]:40094 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LMrb5-0003IE-Sh; Tue, 13 Jan 2009 14:18:55 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id D0999A70012E;
	Tue, 13 Jan 2009 14:18:55 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YKw5FqNmlWbx; Tue, 13 Jan 2009 14:18:55 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 8808AA70012D;
	Tue, 13 Jan 2009 14:18:55 -0800 (PST)
In-Reply-To: <200901131606.04634.bss@iguanasuicide.net>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105552>


--=-NNU8kN3IPqqfjxzOIhTm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-01-13 at 16:06 -0600, Boyd Stephen Smith Jr. wrote:
> On Tuesday 2009 January 13 15:43:22 R. Tyler Ballance wrote:
> >One of our developers "discovered" the --force option on `git push` and
> >used it without taking the appropriate care and hosed one of the project
> >branches we have running around in our central repository.
>=20
> Reflogs should let you recover from this.
>=20
> >Besides a vigorous flogging, we're looking at other ways to prevent this
> >sort of thing from happening again;
>=20
> receive.denyNonFastForwards
>         If set to true, git-receive-pack will deny a ref update which
>         is not a fast forward. Use this to prevent such an update via a
>         push, even if that push is forced. This configuration variable
>         is set when initializing a shared repository.

Looks good, thanks; sorry I missed it, didn't even think to look at the
git-config(1) page for such an option.=20

I'm assuming this will actually cover the rebase -i case as well?


Cheers

--=20
-R. Tyler Ballance
Slide, Inc.

--=-NNU8kN3IPqqfjxzOIhTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkltE0wACgkQFCbH3D9R4W+xIgCeK8VwLlhIm8Qt5KUVIGEGWvQI
2V0AoJFf7T5tNdMunOXz53qIda30KcMK
=oPDc
-----END PGP SIGNATURE-----

--=-NNU8kN3IPqqfjxzOIhTm--

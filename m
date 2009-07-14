From: "=?utf-8?q?K=C4=81rlis_Repsons?=" <karlis.repsons@gmail.com>
Subject: Re: Truly decentralised use of git?
Date: Tue, 14 Jul 2009 13:22:58 +0000
Message-ID: <200907141323.02151.Karlis.Repsons@gmail.com>
References: <200907140811.24174.Karlis.Repsons@gmail.com> <adf1fd3d0907140222t6762d4f7s417f56905492cbba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1586599.hMu7XzXmEI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jul 14 15:23:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQhya-0006cj-29
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 15:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbZGNNXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 09:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbZGNNXH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 09:23:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:60172 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbZGNNXF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 09:23:05 -0400
Received: by fg-out-1718.google.com with SMTP id e12so647145fga.17
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:cc:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=57cTnIAvtn2ojdqH3Etz69JpXDwcY6FHWEBpi/QYFuU=;
        b=GUOFoNUZ3WB60Z/9tRyFX+rcYAcAAPjjmEi7z4eJiREdpX7SuStt7UMy1D+evqSCVU
         6qjYMFbNUdn8KL8ZYZkdDxhAPXLodpPH2YnbI2yCAxAPKiufkX4kWPg8QXzNgCpLFCVy
         lUsWd1uk1FArfAeCy45zjGxBK2tGdn96+on7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=jH+MW00vl+WVGSo+MWtHxz1qn6wasAofxGSUS4wp0a/p3mEWe9TcmHRE3dDfRKVyi7
         JVJoZR6PgwmAdaxZbhNZ4O/aYcEDmv9Vi5YbLzYuCoGcRXv0RNbGY138cVlH6tM5AAJc
         8EaiMA0XDivtJ2l19tffvggjAqMhU9ohw1id4=
Received: by 10.86.25.19 with SMTP id 19mr4105017fgy.71.1247577784475;
        Tue, 14 Jul 2009 06:23:04 -0700 (PDT)
Received: from ?192.168.7.93? ([85.15.210.9])
        by mx.google.com with ESMTPS id l19sm8364318fgb.21.2009.07.14.06.23.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Jul 2009 06:23:03 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <adf1fd3d0907140222t6762d4f7s417f56905492cbba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123245>

--nextPart1586599.hMu7XzXmEI
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 14 July 2009 09:22:10 you wrote:
> 2009/7/14 K=C4=81rlis Repsons <karlis.repsons@gmail.com>:
> > Hello,
> > git is just great with its possibility of decentralised using, but how
> > can it be done, given, that participants are all across the internet?
> > IPv6? How is it done with kernel?
>
> I don't think "truly decentralised" is what you want[1]. For me, truly
> decentralised is when all the repositories are equal, and in
> particular there is no central repository to sync with.
>
> Normally there is a "social" central repository, be it controlled by
> one person (like the linux kernel) or by multiple people (like the
> gnome git repositories). It does not mean it is not decentralised,
> many people can (and do) have repositories spread across the internet
> and the central repository can be moved from one place to another.
>
> In a "truly decentralised" setup, every repository can sync any other
> repository. So you just provide a public repository and sync with the
> rest of repositories. It does not scale with a large number of
> repositories, so it is easier just to declare some of the repositories
> as central (like the Linus' repository and the subsystem
> repositories).
>
> In the linux kernel setup, there is a central repository, Linus'
> repository, with its public repository at kernel.org, and the
> subsystem repositories (x86, mm, usb,...) normally at kernel.org but
> they can be anywhere else. Everybody syncs with Linus' repository, and
> when you work in a specific subsystem you sync with the central one
> and/or the subsystem repository.
>
> HTH,
> Santi

I am sorry, another thing was of my interest.
My unknown is the technical realisation - how can particular repository be=
=20
made available for easy pulling from it? Right now with IPv4 most normal=20
workstations are not accessible directly, because they are behind routers.
That situation should be better with IPv6, but I haven't tried to use it.
I hope, question is now clarified.

k.

--nextPart1586599.hMu7XzXmEI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkpchrYACgkQHuSu329e3GHAcQCfeXkr3sN+V25bYJDoMEDlvZ8b
nsEAn1c4R3E4erYiHm4vsEHRXN2e1fBe
=KWNm
-----END PGP SIGNATURE-----

--nextPart1586599.hMu7XzXmEI--

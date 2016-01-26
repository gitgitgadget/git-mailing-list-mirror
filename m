From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/19] mingw: try to delete target directory before
 renaming
Date: Tue, 26 Jan 2016 09:14:12 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601260900550.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <d75b0dc0b76beefee9e705555ca4f2fa4f4b96ce.1453650173.git.johannes.schindelin@gmx.de> <4C2ED807DD184A168C87221809034B70@PhilipOakley> <alpine.DEB.2.20.1601250753470.2964@virtualbox>
 <xmqq4me1h4k2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-446657084-1453796057=:2964"
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	nalla <nalla@hamal.uberspace.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 09:15:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNymZ-00036Y-BW
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 09:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbcAZIPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 03:15:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:54364 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932090AbcAZIPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 03:15:17 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LkBPy-1ZqYcd2Gt8-00c5ZR; Tue, 26 Jan 2016 09:14:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq4me1h4k2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:X66TAceXNtQB/1/NUIsZ7UZutXsGgC7LDKDdvRqcyj273B/Qq/6
 zmwxUc/cV89UKfAY6ea2Jp8UxYVNICbGfwI7CzbRyfWApo980QUC5EIl6MBIrW7eCnwu+dB
 hP56MsxhgD2nBXP5Z9hbYHpk6gY6oxPATUhtuQzFtAL9VVNV/lhYo4ie8zCkloy8vsJ8hnm
 3kU9IDf6mj4yCfXyrirjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qvVQU6bZC8Q=:UfsdbjGjQ+4jkfMLMy3FZ2
 r0NyDogOlvPlVUKpbqnShLYBkBy+tCZWey96Pt7+UGvDgrufjX6+W8QuG3cojhuDXeqx5N/Qr
 q6xajyGzNGAWyCvN6uwqVPtWmS81bxkuqWYGP+3OQ1v5O96mFbGxNCyqbiUmNFXvFP72ODpXE
 qGre8WvSiDtPiYOn/ziM6yGPpZM5u8z6lEvNNR45xYwTX3zmz81uMRph4cT1WO1oSIt5ycdut
 ja0sv15iKCPMxr4OTcbYgfyasXVybSQqOVAYFPRcZ7RBmzCzIsD4aCQ0x00H/3vvgo8Hy4Op2
 4j6jU2Thz8yoS5A+3L5/HCi7LajFarKSm5JVX+ZnLN+Ra+2CliS/jbFArm+QWtjFQC44ELBUa
 fJb61GayXnad/pA03jaLAy289cMSzL0ZdrQ8v/nvRIw/qf4zwkd67G45deA43ID6PyZv5vdP4
 YY4NNsR2G3UdxUlY9hnA6iarXqCJyzYmWOuNzPiECCitGwM9xxm3eA9K6gGiRmjp2niF6mP1H
 Kv5O589vJSHomn5JjOZg1TCechdhcmzRJnUHHF15fUEo5M3eqXlN2SrrK37TRkf0ebnrzPcsM
 lbOlaZ2j6f04QpyK95yplh6ebzGtbmYxj/WdaOsHslPwot85Cj9vCK+4rOhm0X2XWfUQZRFMH
 hm6bShP0D67kWiHyZfX2joM5KY5YuIXK8ZPkEtY/LMLMrylcDyTgvZcU3sQOwJimbcQ1u2AFi
 Az7Mxa+7zcVCJamDm49PknsbsvU4tpl9MSOOxCKiE7TGUsGEXqoee1ZfSAuOXIcrNW+PyOkz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284786>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-446657084-1453796057=:2964
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 25 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Sun, 24 Jan 2016, Philip Oakley wrote:
> >
> >> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> >> >From: =EB=A7=88=EB=88=84=EC=97=98 <nalla@users.noreply.github.com>
> >>=20
> >> Is this Nalla's preferred email, or just a carry over from cautions
> >> of the Github interface?
> >
> > Neither. It is from the author field as recorded in the commit that I
> > merged originally: https://github.com/dscho/git/pull/8
>=20
> If it is not recorded under the name/email that is preferred by the
> author, as I am not pulling from you but will be applying a patch,
> we can fix it to match the author's desire, if we wanted to.
>=20
> Your "Neither" hints that it is the case, but it is unclear to me
> what address is the desired one (I can guess hamal.uberspace might
> be), so...

The author clarified to me that the noreply "address" was used only in the
early patches, but the uberspace one is the preferred one.

I fixed it in my branch; v2 will have the fix.

Ciao,
Dscho
--8323329-446657084-1453796057=:2964--

From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFC/PATCH] __git_ps1: migrate out of contrib/completion
Date: Thu, 8 Nov 2012 08:19:10 -0500
Message-ID: <20121108131910.GE23491@zaya.teonanacatl.net>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
 <20121025005106.GA9112@elie.Belkin>
 <3B606942-D194-4148-AF6E-1F3283C983ED@googlemail.com>
 <20121025074549.GC15790@elie.Belkin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Cc: Danny Yates <mail4danny@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Anders Kaseorg <andersk@MIT.EDU>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Dan McGee <dan@archlinux.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:19:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWS1B-0007T9-JQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 14:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637Ab2KHNTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 08:19:20 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:47455 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626Ab2KHNTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 08:19:16 -0500
Received: by mail-qa0-f46.google.com with SMTP id n12so1226966qat.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WXqAjF0ZP5y/01XB79z4G45ALJAMGo3dG5yAEhLzSI0=;
        b=RYGcrjg1MlH2GqvAEd2p90WMEhM9v7NKHTxZOfDJFKfloRg1xFg6wVbAm9lDMdorli
         6UZdQKMyOcaQ/B3HD0/MK2Ay1j8RAbf/urxDj42mOLsz3PUpSLFI55i6Nz+u7nbEpCYV
         ifg4usqvkg5rAGaWbLuyob5HrmocVhM3bUOSPAPavSYkvdl+ANGK42GmBoThK/TfzACy
         6Fy2STJQqHeJEF721N6aCCKhrC5PDcpIH7pefICjn3WfzcCEbaw2uJhrmSjpg/BDBT7E
         MCQYDye3RYa4/qfFBXTrQJ+NH0TPE8t2H6MM9ANArLXF/yBz2NxeJPmLTFOuBG5qJUeQ
         1FDg==
Received: by 10.49.25.163 with SMTP id d3mr3422373qeg.20.1352380755754;
        Thu, 08 Nov 2012 05:19:15 -0800 (PST)
Received: from zaya.teonanacatl.net (zaya.teonanacatl.net. [2001:470:5:873:862b:2bff:fe5e:698b])
        by mx.google.com with ESMTPS id q7sm13997417qeo.6.2012.11.08.05.19.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Nov 2012 05:19:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121025074549.GC15790@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209156>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jonathan Nieder wrote:
> Different installers put the git-prompt.sh shell library at different=20
> places on the installed system, so there is no shared location users=20
> can count on:
>
>  Fedora - /etc/profile.d/git-prompt.sh

FWIW, we moved it to /usr/share/git-core/contrib/completion/ -- it was=20
only ever in /etc/profile.d in an unreleased version of Fedora for a=20
short time.  (Side note: at some point, we'll likely install most or=20
all of contrib under /usr/share/git-core/contrib in Fedora.)

Having it in a more standard location would be excellent, it would=20
avoid bugs like: https://bugzilla.redhat.com/show_bug.cgi?id=3D854061 :)

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Oh, very funny!  Now tell the one that doesn't suck.
       -- Stewie Griffin


--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFDBAEBCAAtBQJQm7FOJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjrsQIAI+gyGLH+BPZtvfSHxlaQz39mCUE3Rwvq/h6
HQH3Gmpd6iGp+IAmDeMoZg+4vf48sGZv6kyYhvcyAcWCRLNW3emUFFSfHRqhWimb
bV69vUno7rOe+mHzyZym1JOBQyyOs0/sSdueB4P7xWq/tzjH30xjNBVJnVSagwwJ
GJmRLkC1EAbvrJoQleer42vTqRx1L/Yff3u82vcA17F+IIIxemRvoBmIYQ5SOoTi
P8Sp5Ri+++SKLhiZMMOIcUS7PwQNXn0YVmiQSpEel7g6IOsyqQfWNXp0WeJp5sxl
2MvwPxpUpGlIPo5vNlbRDYgI3sW+EBLHgUw6F0OUmK0z6UwI4uI=
=rVnq
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

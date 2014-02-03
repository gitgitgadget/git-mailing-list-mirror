From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Running "make rpm" fails on a CentOS 6.3 machine
Date: Mon, 3 Feb 2014 09:24:47 -0500
Message-ID: <20140203142447.GY3241@zaya.teonanacatl.net>
References: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
 <20140130181643.GG27577@google.com>
 <20140130185104.GV3241@zaya.teonanacatl.net>
 <CALMr_pVP-YVJ9K7ZpQxk3d5YBFQmCZBonFeUYY1fxdZNHHZJHA@mail.gmail.com>
 <20140202210724.GX3241@zaya.teonanacatl.net>
 <CALMr_pXJTYvCjMQqOak8WhMkW7q4VmAP41V=uTWibx=Zb3SfzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5tiY7shzwSGI9p6W"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 15:25:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAKSI-00085A-P2
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 15:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbaBCOYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 09:24:53 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:44200 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbaBCOYw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 09:24:52 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so10940271qcv.5
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 06:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X+852imYex1YtSkFMeLfOpnmVsIf/y3WydArGHJchKQ=;
        b=WJxcNa+BeWQlJ59ZGVfjFq3Ft9pQwDsXVh16odc+y5L+Bn3gQH2vzKhgodmhA5fevs
         CXKyg7yHcNR6LOhigXG9LfISZZooC3FycuZ3P5Ll0ncbqBRjP2y/Xl/cfaY3k4BSK4ch
         oErSnoTYXyYpJjZQBT0BeGhL9qNwFNNhnFG0LM07fcSHfpA/C6l9JoXkAyctelzfrhfm
         26EFxam6RlsaiqWgiD3bXd4U2eWJc7xpoNACocXT2IaVvmQOhYttvsRT8uKecNP0+6Jy
         tuw1dQDi7O6AiX+I9UL2bxisZclQfY4fTScRBchViQED35GB3pkXwrnb9zBdSjbHzkRK
         J6ew==
X-Received: by 10.229.219.5 with SMTP id hs5mr56464617qcb.9.1391437491983;
        Mon, 03 Feb 2014 06:24:51 -0800 (PST)
Received: from zaya.teonanacatl.net (zaya.teonanacatl.net. [2001:470:5:873:862b:2bff:fe5e:698b])
        by mx.google.com with ESMTPSA id u75sm27257074qgd.23.2014.02.03.06.24.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 06:24:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALMr_pXJTYvCjMQqOak8WhMkW7q4VmAP41V=uTWibx=Zb3SfzQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241436>


--5tiY7shzwSGI9p6W
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Erez Zilber wrote:
> Thanks. Just making sure - I need to do all of this on a fedora=20
> machine, not a RHEL/CentOS machine, right?

Nope.  An el6 box makes a fine mock host for el6 and (usually) fedora=20
targets (though the mock package in EPEL doesn't always have config=20
files for the very latest fedora release).  The builder I use for my=20
packages on el6 is an el6 host.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Don't look for me in daylight where robots all assemble.  You'll find
me in my dark world, in my smoke-filled temple.


--5tiY7shzwSGI9p6W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFDBAEBCAAtBQJS76avJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjLqIH/1U75qLdfpWH883RdgJa98qa6T3hkKQMU7AH
BbIy2i6V9gTcHiSM7F6JcwQ+MROSdJMmdNM6809myrpi0lG/mkrYkZLv1Eci4zln
WQrQBDJ1tdxzMpFYtL1I/IuGAzhYuGksOLURgzia89znmI6oAiXefwADBC/7pe5z
sROpoqnNpvjQeUNZnomlkmsm0lw9svD78p7tCAp6rPkWJg02Dhdy27FLOV1nKevg
6WOhZ3neXB4m/yhxDpWqoWbBSXbDzatyhHw9gFmzr5TgtRfEl1cH+NE61Mk7vwC3
+S3r5fVkGmGvmlW6AzBsxjN/o7ZfMdhRav787Wefjl4CkylMM+U=
=YTZp
-----END PGP SIGNATURE-----

--5tiY7shzwSGI9p6W--

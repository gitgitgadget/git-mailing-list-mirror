From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Running "make rpm" fails on a CentOS 6.3 machine
Date: Thu, 30 Jan 2014 13:51:04 -0500
Message-ID: <20140130185104.GV3241@zaya.teonanacatl.net>
References: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
 <20140130181643.GG27577@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aXXwKK8cHQSbFLNd"
Cc: Erez Zilber <erezzi.list@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 19:51:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8whq-00041O-KW
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 19:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbaA3SvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 13:51:10 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:40663 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbaA3SvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 13:51:09 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so4920117qaq.39
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 10:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QSaeLM7xinDfyPQhaK0PzUnlsWd/bBWIjJRcU1Jb9q0=;
        b=aGAfOILbfkNCvKGe21fbz1sW061bJXnAstkz0CQv/5kuM/uG6u/uBcKYGte7IqwT9T
         76A/u2yCEC3WT2RTwR8MuaE3AWwAA5px+bITS5iE2PIjISzFN9J/T0tHAffiUH2iYdBj
         IMTTgsFURGvD1wYB7zoo77FZrmg7uD673O8jRku02VJb4/hElqUdjYAFtjd8WGU9Gw1N
         scnpiIU8KhXKNYs65MjiOyS9+NZGTPobq/gtUh+K6bz5udt2cm+FNAk5X9A3SvQp1hhf
         FC/rBvZHG8cXav6uh2JOZCsU4Oe6ID6UxdlrH4Du3hBE+dOfzqK5CGJGFhLPIifcE9k7
         bBuw==
X-Received: by 10.224.137.66 with SMTP id v2mr24423987qat.104.1391107868172;
        Thu, 30 Jan 2014 10:51:08 -0800 (PST)
Received: from zaya.teonanacatl.net (zaya.teonanacatl.net. [2001:470:5:873:862b:2bff:fe5e:698b])
        by mx.google.com with ESMTPSA id g68sm9901034qge.7.2014.01.30.10.51.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jan 2014 10:51:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140130181643.GG27577@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241276>


--aXXwKK8cHQSbFLNd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Jonathan Nieder wrote:
> Erez Zilber wrote:
>
>> Writing perl.mak for Git=20
>> Writing perl.mak for Git=20
>> rename MakeMaker.tmp =3D> perl.mak: No such file or directory at /usr/sh=
are/perl5/ExtUtils/MakeMaker.pm line 1024.=20
>> make[3]: perl.mak: No such file or directory=20
>> make[3]: perl.mak: No such file or directory=20
>> make[3]: *** No rule to make target `perl.mak'.  Stop.
>
> Looks like MakeMaker is racing against itself.  Alas, (on a fairly=20
> current Debian system, with perl 5.14.2) I'm not able to reproduce that.
>
> Instead, I get this:
>
> | $ make -j8 rpm=20
> [...]
> | make[2]: Leaving directory `$HOME/rpmbuild/BUILD/git-1.8.5.3/Documentat=
ion'=20
> | make[1]: Leaving directory `$HOME/rpmbuild/BUILD/git-1.8.5.3'=20
> | + exit 0=20
> | Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.WqNYnx=20
> | + umask 022=20
> | + cd $HOME/rpmbuild/BUILD=20
> | + cd git-1.8.5.3=20
> | + rm -rf $HOME/rpmbuild/BUILDROOT/git-1.8.5.3-1.x86_64=20
> | + make -j12 'CFLAGS=3D-O2 -g' \=20
> 	DESTDIR=3D$HOME/rpmbuild/BUILDROOT/git-1.8.5.3-1.x86_64 \=20
> 	ETC_GITCONFIG=3D/etc/gitconfig prefix=3D/usr \=20
> 	mandir=3D/usr/share/man htmldir=3D/usr/share/doc/git-1.8.5.3 \=20
> 	INSTALLDIRS=3Dvendor install install-doc=20
> | make[1]: Entering directory `$HOME/rpmbuild/BUILD/git-1.8.5.3'=20
> | make[1]: warning: -jN forced in submake: disabling jobserver mode.=20
> | make[1]: *** write jobserver: Bad file descriptor.  Stop.=20
> | make[1]: *** Waiting for unfinished jobs....=20
> | make[1]: *** write jobserver: Bad file descriptor.  Stop.=20
> | error: Bad exit status from /var/tmp/rpm-tmp.WqNYnx (%install)=20
> |=20
> |=20
> | RPM build errors:
> |     Bad exit status from /var/tmp/rpm-tmp.WqNYnx (%install)=20
> | make: *** [rpm] Error 1
>
> Known problem?  A build without -j8 gets further.

It seems like it's not a problem with el6 or git's Makefiles=20
themselves.  I haven't used the spec file from git.git in ages, but I=20
have tried to ensure that the one we use in Fedora builds cleanly on=20
el{5,6}.  I use this myself to keep an update git on el6, where Red=20
Hat has left git at 1.7.1 since the release of el6 however many years=20
ago. :(

Here's a build I ran just now using the latest Fedora SRPM, showing it=20
succeeds with make -j5:

http://kojipkgs.fedoraproject.org//work/tasks/3049/6473049/build.log

The build task, with all of the resulting rpms and logs is here:

http://koji.fedoraproject.org/koji/taskinfo?taskID=3D6473049

(That will remain for a few days or so, at least.  Scratch builds like=20
this aren't kept indefinitely.)

This makes me think that there's something in the git.spec in git.git=20
that differs from what we use in Fedora/EPEL.  I don't have time to=20
dig into that now, but perhaps someone with time and inclination can=20
diff the spec files and find the cause.

I know the Fedora/EPEL spec file and what's in git.git have grown=20
apart a good bit, unfortunately.  That's the cost of having a spec=20
file that is meant to work across a very wide array of RPM-based=20
systems, I guess.  The Fedora/EPEL spec file is fairly specific to the=20
Fedora/EPEL build tools (mock is the primary build tool).

Hope this helps a little in narrowing down the issue.  I'm sorry=20
I can't be of more assistance at the moment.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
How am I supposed to hallucinate with all these swirling colors
distracting me?
     -- Lisa Simpson


--aXXwKK8cHQSbFLNd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFDBAEBCAAtBQJS6p8YJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj638H/3e79mH2YdSRWMNDQGtlolq4phHXoruyHAPi
h89MhE3Yc34LbGNErrsWHIAyZUPFya8wpTPReXPukkU6r/NysbSxi2y5rQFXMGgY
Uh9kPlf7HWxG104MpjXFciR7xAtqKMg2e+aAoPVYZJ9guCnTgypNuYEip9oNHyfL
cgFrUu1qUTpMfhLZ/X0kCfwUD7YGmVfqbNtyxM7mpe6Jxh3Z499Y2FAQus5yJdtc
CUmJDMYl01m3PpCMg0f9JlPF+0Z7q+779Yi8P2nG43FGK3G/eBGbYn9vXBb0w8wo
N5oZQ8kcYp/fPW40THasqFv4LRlLFJXfZDPC43LDVFVXmodPp3I=
=MgFu
-----END PGP SIGNATURE-----

--aXXwKK8cHQSbFLNd--

From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC
 toolchain
Date: Wed, 19 Aug 2009 09:29:48 +0200
Message-ID: <4A8BA9EC.9000006@storm-olsen.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <1250600335-8642-1-git-send-email-mstormo@gmail.com>  <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com>  <4A8AED8B.9080604@gmail.com>  <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>  <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>  <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de> <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com> <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enigD46F8B60906663DF4204ABDD"
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,  Johan 't Hart <johanthart@gmail.com>, Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,  git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Aug 19 09:30:11 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdfcX-0004Je-9d
	for gcvm-msysgit@m.gmane.org; Wed, 19 Aug 2009 09:30:09 +0200
Received: by ywh4 with SMTP id 4so7182223ywh.22
        for <gcvm-msysgit@m.gmane.org>; Wed, 19 Aug 2009 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:received:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=5LiUGhl/osOx1sbYkljcBMEEsvKkXLeNpdSfQ3lq+y8=;
        b=m8ZCmyfaNbzCwt+lkgW0xwpd4RWBAN4JLB4CgVSDvSeyPTOs8VuRXYuEWQIxDhemYT
         7hW9wo9LvYb6MdL/ba13qKRKRohknnPZcUp+mFr5qZzwHkJe1bf0UfMn2iYa2vfzfnlr
         mJwvSnzCfp74LGJulSu3I6aKheqqtyZ1NdLKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=6uZZRuol0vymQI0zk0uEwBXaNVllEWCkiJGeOjE6oaVOsfcPOg1bc59UNzImovtwVj
         j9dF6889VstXN0fmgmBCTk9P5qC4LAvVX0y9g0qGpAwuooXcdk8OjmuUJQ3dqxm6oH8Z
         yQZgzI26RUI/d+xlCRCm23o97yQiAwEZYj55A=
Received: by 10.100.193.12 with SMTP id q12mr2058026anf.5.1250667001867;
        Wed, 19 Aug 2009 00:30:01 -0700 (PDT)
Received: by 10.176.94.14 with SMTP id r14gr6532yqb.0;
	Wed, 19 Aug 2009 00:29:52 -0700 (PDT)
X-Sender: marius@storm-olsen.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.103.48.37 with SMTP id a37mr184836muk.20.1250666992163; Wed, 19 Aug 2009 00:29:52 -0700 (PDT)
Received: by 10.103.48.37 with SMTP id a37mr184835muk.20.1250666992141; Wed, 19 Aug 2009 00:29:52 -0700 (PDT)
Received: from mail-bw0-f228.google.com (mail-bw0-f228.google.com [209.85.218.228]) by gmr-mx.google.com with ESMTP id 14si140645bwz.5.2009.08.19.00.29.51; Wed, 19 Aug 2009 00:29:51 -0700 (PDT)
Received-SPF: neutral (google.com: 209.85.218.228 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) client-ip=209.85.218.228;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 209.85.218.228 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) smtp.mail=marius@storm-olsen.com
Received: by bwz28 with SMTP id 28so3332104bwz.30 for <msysgit@googlegroups.com>; Wed, 19 Aug 2009 00:29:51 -0700 (PDT)
Received: by 10.204.153.22 with SMTP id i22mr4543166bkw.165.1250666991558; Wed, 19 Aug 2009 00:29:51 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104]) by mx.google.com with ESMTPS id g28sm7781388fkg.45.2009.08.19.00.29.50 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 19 Aug 2009 00:29:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.22) Gecko/20090605 Lightning/0.9 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302>
X-Enigmail-Version: 0.96.0
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126511>


This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD46F8B60906663DF4204ABDD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin said the following on 19.08.2009 09:16:
> On Wed, 19 Aug 2009, Erik Faye-Lund wrote:
>> On Wed, Aug 19, 2009 at 12:38 AM, Johannes=20
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>>>> Nope, you're still able to skip through the erros (with F4)
>>>> as ususal. I've been using a sed-script to translate
>>>> gcc-style errors to msvc-style errors for makefile projects
>>>> before with great success. In this case, the errors are
>>>> already in msvc-style, so that part should really not be any
>>>> issue.
>>> At this point you are just piling work-around on work-around.
>> At what point?
>=20
> At the point where you bolt on a sed script on top of a bolted-on
> build procedure.
>=20
> Using a Makefile from within Visual Studio is just not the intended
> way to do things, so you will hit the limitations sooner or later.
>=20
> For example when the sed script encounters a situation which was
> not anticipated by the script author.
>=20
> So I think if we support Microsoft Visual C++, it should be either
> through .vcproj files, or through a procedure that creates them.

IMO, and I'm primarily a Windows developer mind you and spend a lot of=20
time in Visual Studio, the primary is to support *compiling* git with=20
VC, which is easily done with a few changes to the current Makefile.

The full IDE support is secondary, first because you *can* use the IDE=20
already, and second because it'll be harder to whip something up which=20
guarantees that the vcproj support stays in-sync at all times and=20
won't lag behind.

If you want, you can even use Qt Creator's Makefile support on any=20
platform to build and debug git, and get tab completion, code=20
refactoring support, 'quick open' navigation etc. So, I still think=20
the primary focus should be to simply add the VC support in the=20
current setup, and ensure that the patch series is up to scratch; and=20
when that's all done, *then* add the effort of properly supporting the=20
various IDEs.

Of course, if someone has a huge itch to restructure the current=20
Makefile; factoring out the files into a file which can simply be=20
included in the current Makefile, and easily parsed by a script, or=20
included by CMake, then that can be done in parallel and possible=20
added to git mainline before the MSVC support patches from Frank.

--
=2Emarius


--------------enigD46F8B60906663DF4204ABDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFKi6nsKzzXl/njVP8RAqg6AJ9jwHWp88mlq/o1ypoh/uvj+cEdBwCeITkJ
fOL21dru2oL4SSBq7tdXo2c=
=FpMj
-----END PGP SIGNATURE-----

--------------enigD46F8B60906663DF4204ABDD--

From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 22:05:11 +0100
Message-ID: <3f4fd2640908171405g46aa1d09t5169a3c8bcb1c49c@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-3-git-send-email-lznuaa@gmail.com> <1250525103-5184-4-git-send-email-lznuaa@gmail.com> <1250525103-5184-5-git-send-email-lznuaa@gmail.com> <4A899495.8050902@gnu.org> <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com> <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com> <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com> <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Erik Faye-Lund <kusmabite@googlemail.com>,  Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,  msysgit@googlegroups.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Aug 17 23:10:59 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9Tl-0005H4-Ro
	for gcvm-msysgit@m.gmane.org; Mon, 17 Aug 2009 23:10:58 +0200
Received: by ywh4 with SMTP id 4so5196114ywh.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 14:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:mime-version
         :content-type:content-transfer-encoding:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:x-google-approved
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=7DhKW6Eu8ZVlgRuEnfjn5lLBv5vVi/ShJ1deNWr2DFc=;
        b=qZQL/h9JeDS6ZTKtB8IhiHRt0DSb4ljjYzMluF2umWgYwPNNmPwhQ+3HI87uq47w04
         DiIeVRaIkfJmCQT6nwyV/xYXXVFDIRfm6TsQ23LbHNXxQ+vFaeY0Td4ihCxCh4qHwlgj
         iUzJPly6fekO3A6wJhwMqKLKADbvBbtngWmUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:content-type
         :content-transfer-encoding:in-reply-to:references:date:message-id
         :subject:from:to:cc:x-google-approved:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=rKDUnD5cgmYiKDkEXWUV/4AkuefALHtriqJwWSkIJpYI66LgJxrfO0b6WEekHatBhR
         ZLb50mdnp3bnh/DVoZH/AH4FHXgU72RluqNAI8B0Djek8oIMXc2q88GDh9LwPZAzSr4q
         vFxGG0rF/ocrBA+lMgPYiSbInUuZqrWl79m/Q=
Received: by 10.100.20.39 with SMTP id 39mr1277885ant.6.1250543451662;
        Mon, 17 Aug 2009 14:10:51 -0700 (PDT)
Received: by 10.176.48.40 with SMTP id v40gr6400yqv.0;
	Mon, 17 Aug 2009 14:10:48 -0700 (PDT)
X-Sender: msclrhd@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.220.82.72 with SMTP id a8mr697662vcl.14.1250543113061; Mon, 17 Aug 2009 14:05:13 -0700 (PDT)
Received: by 10.220.82.72 with SMTP id a8mr697661vcl.14.1250543113001; Mon, 17 Aug 2009 14:05:13 -0700 (PDT)
Received: from mail-vw0-f199.google.com (mail-vw0-f199.google.com [209.85.212.199]) by gmr-mx.google.com with ESMTP id 23si334681vws.2.2009.08.17.14.05.11; Mon, 17 Aug 2009 14:05:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of msclrhd@googlemail.com designates 209.85.212.199 as permitted sender) client-ip=209.85.212.199;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of msclrhd@googlemail.com designates 209.85.212.199 as permitted sender) smtp.mail=msclrhd@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-vw0-f199.google.com with SMTP id 37so2656103vws.27 for <msysgit@googlegroups.com>; Mon, 17 Aug 2009 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=GoLeG/0h49OwHpPEbea1rTfMMkmBB+DvcX2rV3dkhKk=; b=TQI1A+k5UW7vXw5RvMiQI1s9z4pkYiVfWB/XRpFhXXJsoQooyTuAgFAqBM2ptrVzoV XQF0WTNq6AShapg5Ka+M0mX/Uk2DeRrvKYC6vItdTy07Nrn4Z8MVdL6PcvurD5Q5mOHt K+lK7ejR5+yapCkSISGgkIWjw2kJOb1nHzrrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=rcUX7W5ntOD8prUwG2o8nyheeE7Y213yLxmC5ck5ISXl8v/urWAPGo/Xl3KQ8YMTAz yzGKgKR4TKa23YYve6lq76F6Y7lVp7m0GhRkWVqUHjYjLUo9PAZILePjz7Ex76F1dr6G 6AdfQr5OkodwfEKJMZR6qDZ0M7CoKzJ6qV99I=
Received: by 10.220.116.197 with SMTP id n5mr5427013vcq.76.1250543111790; Mon,  17 Aug 2009 14:05:11 -0700 (PDT)
In-Reply-To: <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com>
X-Google-Approved: johannes.schindelin@googlemail.com via web at 2009-08-17 21:10:47
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126287>


2009/8/17 Pau Garcia i Quiles <pgquiles@elpauer.org>:
> On Mon, Aug 17, 2009 at 10:43 PM, Reece Dunn<msclrhd@googlemail.com> wrot=
e:
>> 2009/8/17 Pau Garcia i Quiles <pgquiles@elpauer.org>:
>>> On Mon, Aug 17, 2009 at 9:53 PM, Johannes
>>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>>>
>>>> Of course, we could have a script that verifies that the .vcproj files
>>>> contain reference the appropriate files (which it would know about by
>>>> being called from the Makefile and being passed the file names), maybe
>>>> even be able to edit the .vcproj file if it is missing some. =A0Should=
 not
>>>> be too hard in Perl.
>>>
>>> You'll need to special-case for Visual C++ 2010, which is different
>>> and incompatible with previous versions. Hence my suggestion for
>>> CMake: appropriate project files would be generated for the tool the
>>> user chooses, be it VC++ 2005, VC++2010, gcc, Borland C++ or anything
>>> else.
>>
>> The problem is that you'd still need the Visual Studio projects (one
>> each for 6, 7 (2002), 7.1 (2003), 8 (2005), 9 (2008) and 10 (2010) --
>> yes, there'll need to be one for each version of Visual Studio) as
>> people who use Visual Studio tend to primarily use the IDE. CMake
>> (which Windows users will need to download & install from somewhere)
>> will sit outside this -- unless you mean making the project files be
>> the "Makefile project" type and simply use it to invoke CMake and host
>> the source files to ease access to them from the IDE?
>
> If a CMake build system is provided, you will not need a single Visual
> Studio project, or the autotools build system, or anything else. Just
> CMake and the CMake build system (which are a bunch of CMakeLists.txt
> plain text files).

Note that I said that people who use Visual Studio are more likely to
build and develop things through the Visual Studio IDE. Unless there
is IDE integration for it, they are not likely to use it.

For an automated build, CMake would probably work.

Looking around, it seems that CMake on Windows assumes that Microsoft
Visual C is used; that is, you have to explicitly specify CC for MinGW
or cygwin to build.

> CMake takes the CMakeLists.txt file(s) as the input and generates
> makefiles for gcc, vcproj files for Visual C++, makefiles for NMake,
> Eclipse projects for Eclipse, XCode projects for XCode, etc.
>
>> Also, not every posix system will have CMake installed (e.g. Linux
>> From Scratch systems) and that's not including "exotic" systems like
>> Solaris and the *BSDs.
>
> CMake is available for many platforms (Linux x86-32 and x86-64, PPC,
> Solaris Sparc, HP-UX, Irix, AIX PPC) as a binary from the CMake site (
> http://cmake.org/cmake/resources/software.html ) and as source for the
> rest.
>
> *BSD? It is available in the ports section (and maybe as a binary,
> too) in FreeBSD(
> http://www.freebsd.org/cgi/cvsweb.cgi/ports/devel/cmake/ ), NetBSD and
> OpenBSD.

Ok, I stand corrected there.

> Linux from scratch? If people are brave enough to build and use LFS,
> they are brave enough to build CMake (CMake is autocontained and
> bootstraps itself, it only depends on a C++ compiler to build itself).

At what about at the bootstrap stage? A C compiler will be available,
but a C++ one may not.

- Reece

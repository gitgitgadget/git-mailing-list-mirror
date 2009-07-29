From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: [msysGit] Git for Windows 1.6.4
Date: Thu, 30 Jul 2009 00:50:09 +0200
Message-ID: <46d6db660907291550q62d4383au7e847d535058558d@mail.gmail.com>
References: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>
	 <46d6db660907291503o6979ef9fvbef5d25fa4318e37@mail.gmail.com>
	 <alpine.DEB.1.00.0907300018451.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:56:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWI4o-0005yx-Vz
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbZG2W4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 18:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754901AbZG2W4n
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:56:43 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50252 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbZG2W4n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 18:56:43 -0400
Received: by bwz19 with SMTP id 19so274156bwz.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=io77UqKv1B0uIgo38eaZUnryWTGb2nh5hE4qGP/c2mo=;
        b=oDjZiZee6KxMvPg7AwxodkjRKWJW4zyh8NgKy3+ags+NdXPA+mQDvFgOgj924W8aht
         f3+WN3+w1KLfP3UXUbQE21gtzZKtyIZZB36JbJ9C+b2odBQHJnbcUPRIAUuAm8BD2TCA
         EX7s3hAtDjy0lTFaLPCBRo6XS6NFnchDSi7jU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qZRlD/VWwTOS0BJLu0PULxhWmD/TgUf6Oe2z7DcY8fwx00jcT4uAAWnes0ZCgYdhsq
         LePXDMRDwAO2eRl9gHujXouqQZRbe44V3omfYDLXgTdZqjrCUYfTqqqjBiwPd7UNWn/V
         yDAWJQ67wTU1gvKzk5vThBWQYF/nmu3bTE7H8=
Received: by 10.204.78.131 with SMTP id l3mr260677bkk.186.1248907809927; Wed, 
	29 Jul 2009 15:50:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907300018451.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124406>

On Thu, Jul 30, 2009 at 12:20 AM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 30 Jul 2009, Christian MICHON wrote:
>
>> On Wed, Jul 29, 2009 at 11:40 PM, Johannes
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> >
>> > this mail informs you that Git for Windows 1.6.4 is out. =A0It is =
less
>> > well tested than the previous versions, mainly because I was busy =
with
>> > other things and asked for help with testing on the msysGit mailin=
g
>> > list and I am very impatient.
>>
>> I'm still too busy, but since I saw your email arriving live and I'v=
e
>> Vista here, I kept some minutes for you :)
>>
>> >
>> > Git Release Notes (Git-1.6.4-preview20090729)
>> > Last update: 29 July 2009
>> >
>>
>> bad news: here the installation complains around the end (all defaul=
t answers)
>
> Uh oh.
>
>> "Could not set CR/LF behavior: core.autoCRLF true"
>>
>> Using git gui works, calling gitk from it works.
>> But git bash initiates a shell complaining:
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> -------------------------------------------------------
>> Building and Installing Git
>> -------------------------------------------------------
>> sh.exe": cd: /git: No such file or directory
>
> Ah, you are not installing Git for Windows, but msysGit.

I'm installing http://msysgit.googlecode.com/files/Git-1.6.4-preview200=
90729.exe:
I should have been more accurate. But each time I reported on this
package, it was on the preview.

> Now the question is if full or net.

I believe it's preview, not full, not net. My download size is 11.3MB
and the md5sum is 16F1AB9CBFB75553DC19C3B17BB96C57

>
> I will not guess, especially since I am dead tired after that hour it
> always takes to make a new release.

I believe we're both on CET :)

>
>> Apparently, git binaries are not in the path. I'll check on a winXP
>> and win2003 environments asap.
>
> Pff.
>
> I think it is the lack of libcrypto.dll and libssl.dll. =A0And now I =
know
> you used the net installer.

no, I did not use the net install, nor the full install. I can see
from the wiki the net installer is a 1.8MB download.

??? libcrypto and libssl *are* in the package preview...

It's actually quite funny, but I guess I've seen it all on Windows:
all the binaries are here with their libraries until the setup
complains about core.autoCRLF. After this stage, git.exe gets
deleted... And it's not a virus triggering this (I checked).

I managed to quickly copy it before it got erased, and manually added
it back after the setup completes. It works.

I'll not try the full install; at least from my point of view, it's a
regression on the *preview* package, which I'm using on a daily basis.

>
> As I said, would have been nice to be precise.
>

let me know if it's not yet clear enough: I'm tired too, almost 1am :)

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: asciidoc, was Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 6 Mar 2009 14:15:50 +0100
Message-ID: <200903061415.50746.jnareb@gmail.com>
References: <Pine.LNX.4.44.0903010945290.4675-100000@localhost.localdomain> <alpine.DEB.1.00.0903061301340.10279@pacific.mpi-cbg.de> <43d8ce650903060428h26392348i4e0db5c23ca57da6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 14:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfZtn-0005Ia-Qe
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 14:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZCFNOE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 08:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbZCFNOD
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 08:14:03 -0500
Received: from mail-ew0-f177.google.com ([209.85.219.177]:48570 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZCFNOA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 08:14:00 -0500
Received: by ewy25 with SMTP id 25so197526ewy.37
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GXOzFqQTPoN/SIhtvI/gV4EiYzmsBNnAEH17TOw6ND0=;
        b=M+e9avehRQCIkYSaDndXwuF+nhu6BaB/Bz365reB24c4nD1ufcJGJXkrNPG67pbL1o
         U4RnLopLPf6EjNtiBBqntp4oE0mBBd27yGXX0p+de0bkcDJvYmxzY5dazNycy67slT/b
         /y8bshX/2Q7EaC8V2uStx44pycLmKURA7YC6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cNwguFawGSurE5NuLawbpwWFtqvcshlvh4SbhyWSG0bPjPZ+deyo03rdkrBwEk7+/t
         HVty7HUrJ7V+kL1WUb0IngevXx1feH48sM+NyoOomXj3M+zHqIdXal500CXJ8znZGyEx
         0JJX+0CtuUaEhhXc8mkuJbxYYWkvY7VrBbdxM=
Received: by 10.216.71.70 with SMTP id q48mr1202551wed.207.1236345237527;
        Fri, 06 Mar 2009 05:13:57 -0800 (PST)
Received: from ?192.168.1.13? (abwf107.neoplus.adsl.tpnet.pl [83.8.229.107])
        by mx.google.com with ESMTPS id i6sm2155356gve.18.2009.03.06.05.13.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 05:13:57 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <43d8ce650903060428h26392348i4e0db5c23ca57da6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112435>

On Fri, 6 March 2009, John Tapsell wrote:
> 2009/3/6 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> On Fri, 6 Mar 2009, John Tapsell wrote:
>>> 2009/3/6 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>>> On Fri, 6 Mar 2009, Jakub Narebski wrote:

>>>>> However while toolchain needed to produce documentation (asciidoc=
 +
>>>>> xmlto) isn't, I think, something very common, in my opinion autoc=
onf is
>>>>> something that is present on systems containing other build tools
>>>>> required to build git from sources. =C2=A0So 'configure' branch i=
s not, I
>>>>> think, as necessary as 'html' and 'man' branches; additionally 'h=
tml'
>>>>> branch (or the repository used to build documentation, or the byp=
roduct
>>>>> of building documentation) is used to generate on-line docs for g=
it.
>>>>
>>>> Plus, keep in mind that autoconf support is only an afterthought i=
n Git;
>>>> Just running "make" is supposed to work. =C2=A0If it does not, pat=
ches are
>>>> certainly welcome, I think.
>>>
>>> Well now that you mention it.. :-)
>>>
>>> It doesn't check for the existance of asciidoc, but blindly assumes=
 it
>>> exists. =C2=A0And even if you do have asciidoc, there's a good chan=
ce that
>>> you have the wrong version. =C2=A0 The INSTALL file says that ascii=
doc
>>> requires 8.2.7 but most distros (debian, ubuntu. =C2=A0probably oth=
er) have
>>> 8.2.6.

Do you mean here Makefile checks, or do you mean ./configure checking
for existing asciidoc toolchain, and for asciidoc version?

>>> If you compile the docs with the wrong asciidoc version, there is n=
o
>>> warning or error at all. =C2=A0It just builds incorrect man pages.
>>
>> Frankly, I was talking about "make". =C2=A0I never needed asciidoc t=
here.
>>
>> Besides, if it is really an itch of yours, maybe you can come up wit=
h a
>> patch checking for a correct asciidoc version? =C2=A0Only if asciido=
c would be
>> needed at all, of course.
>=20
> Yep.  I've been looking at it for the last half hour, but configure.a=
c
> syntax defeats me :-D   (I figured getting the check into configure.a=
c
> would be a good first start)

Errr... doesn't configure.ac have checking for asciidoc version? Search
for AC_CHECK_PROGS(ASCIIDOC, [asciidoc]). Perhaps tests should be more
detailed, or something...

--=20
Jakub Narebski
Poland

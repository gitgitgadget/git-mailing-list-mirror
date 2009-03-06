From: John Tapsell <johnflux@gmail.com>
Subject: Re: asciidoc, was Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 6 Mar 2009 13:39:01 +0000
Message-ID: <43d8ce650903060539q5a189543g4ef51dac0ba2e6a3@mail.gmail.com>
References: <Pine.LNX.4.44.0903010945290.4675-100000@localhost.localdomain>
	 <alpine.DEB.1.00.0903061301340.10279@pacific.mpi-cbg.de>
	 <43d8ce650903060428h26392348i4e0db5c23ca57da6@mail.gmail.com>
	 <200903061415.50746.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 14:40:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfaHz-0005kC-TZ
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 14:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbZCFNjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 08:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbZCFNjF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 08:39:05 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:40817 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbZCFNjD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 08:39:03 -0500
Received: by wf-out-1314.google.com with SMTP id 28so542376wfa.4
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Da12r5Db1jaAiBaXfCqhPAxRq2SjbE4tncp4OGVhMo=;
        b=c6CYptUuUY1hvCzqnkFXLTzwkXXsbMm4roSD/ikA3/TmkljLQwrCeTCXnSZwxfo5UD
         /Y3hDPqCpXnIfrLQpedr8aFSVqUNwn0dZHmNEITMBYt3ucETRdUD7/Oi8tLNM3HA7QrK
         NkBF7j62OOi6u47pyrV0zkA80h9Q7NhrZlXsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WAk4aWjgc3FHqtjYV8taLjmf2fcHiwzWoXkh2+4OeahZgdaASybrzvKF8O7IVH8Kqz
         qA9gJSkoMPPyEANlf++9wSIJvls8Uo5l0fH19zIpl80coloj22N1a7ZE8JiK0PPd1r+6
         cs81Aoz2BnZpd7iH9eO8dGucUk9/OFk+HbsTQ=
Received: by 10.142.230.7 with SMTP id c7mr1110977wfh.97.1236346741125; Fri, 
	06 Mar 2009 05:39:01 -0800 (PST)
In-Reply-To: <200903061415.50746.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112437>

2009/3/6 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 6 March 2009, John Tapsell wrote:
>> 2009/3/6 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>> On Fri, 6 Mar 2009, John Tapsell wrote:
>>>> 2009/3/6 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>>>> On Fri, 6 Mar 2009, Jakub Narebski wrote:
>
>>>>>> However while toolchain needed to produce documentation (asciido=
c +
>>>>>> xmlto) isn't, I think, something very common, in my opinion auto=
conf is
>>>>>> something that is present on systems containing other build tool=
s
>>>>>> required to build git from sources. =C2=A0So 'configure' branch =
is not, I
>>>>>> think, as necessary as 'html' and 'man' branches; additionally '=
html'
>>>>>> branch (or the repository used to build documentation, or the by=
product
>>>>>> of building documentation) is used to generate on-line docs for =
git.
>>>>>
>>>>> Plus, keep in mind that autoconf support is only an afterthought =
in Git;
>>>>> Just running "make" is supposed to work. =C2=A0If it does not, pa=
tches are
>>>>> certainly welcome, I think.
>>>>
>>>> Well now that you mention it.. :-)
>>>>
>>>> It doesn't check for the existance of asciidoc, but blindly assume=
s it
>>>> exists. =C2=A0And even if you do have asciidoc, there's a good cha=
nce that
>>>> you have the wrong version. =C2=A0 The INSTALL file says that asci=
idoc
>>>> requires 8.2.7 but most distros (debian, ubuntu. =C2=A0probably ot=
her) have
>>>> 8.2.6.
>
> Do you mean here Makefile checks, or do you mean ./configure checking
> for existing asciidoc toolchain, and for asciidoc version?

Well presumably both would have to check, since you can run make
without configure.  I just figured starting with configure would be
easiest.

>
>>>> If you compile the docs with the wrong asciidoc version, there is =
no
>>>> warning or error at all. =C2=A0It just builds incorrect man pages.
>>>
>>> Frankly, I was talking about "make". =C2=A0I never needed asciidoc =
there.
>>>
>>> Besides, if it is really an itch of yours, maybe you can come up wi=
th a
>>> patch checking for a correct asciidoc version? =C2=A0Only if asciid=
oc would be
>>> needed at all, of course.
>>
>> Yep. =C2=A0I've been looking at it for the last half hour, but confi=
gure.ac
>> syntax defeats me :-D =C2=A0 (I figured getting the check into confi=
gure.ac
>> would be a good first start)
>
> Errr... doesn't configure.ac have checking for asciidoc version? Sear=
ch
> for AC_CHECK_PROGS(ASCIIDOC, [asciidoc]). Perhaps tests should be mor=
e
> detailed, or something...

Yeah I saw that - it checks if you have version 7.* or 8.*. I just
don't know how to check if the version is >=3D .8.2.7.

John

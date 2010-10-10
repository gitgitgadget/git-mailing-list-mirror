From: Akira Kitada <akitada@gmail.com>
Subject: Re: Git 1.7.3.1 cannot be built on FreeBSD 4 with gcc 2.95
Date: Sun, 10 Oct 2010 14:25:13 +0900
Message-ID: <AANLkTindQ8Nty=eUGNgREish0K-=dGgg9qXjWbefKb3M@mail.gmail.com>
References: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com> <AANLkTi=3BG0PScgp5X+y2-U1FqC6aoOrw_pyLU7cEzME@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 07:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4oSu-0006ey-Ns
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 07:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830Ab0JJFZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 01:25:34 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43865 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab0JJFZe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 01:25:34 -0400
Received: by vws2 with SMTP id 2so349982vws.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 22:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Wcum8x25slC5vQ6B2m7iakmB5gCKLWxEuWTHdQrX3tY=;
        b=AHSo2dHBi9XEsLm0KoO50q9prQ0ATXH72tXGkWOOKNgZT15zNwyQbcGjinJVea4HZW
         x+TsuXtw6GjrLGBBVeZqtPDrvEynSmrVBV4hxdY40kI5wghR27fxN8uh0TtsW2S1rPOQ
         nN9rtwLh5u1g2wWguigdc+akd3LOykDeTZiIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KVFmp3CMcviE379eU/XFkp0wyPj8oUR6znFnWi6qisuueXXj/ZospJdSXktdT0oJrP
         ZdM2UE9SPpsqNyi0Nr3fo9qsA5hneQx7W1MXU7OPWNr94MCZnTK2izmauVNOGWFSGjMN
         tBZlcHMPZdpAdWByqeveNSQYJ070cbDkAgGG0=
Received: by 10.220.186.5 with SMTP id cq5mr1384341vcb.246.1286688333196; Sat,
 09 Oct 2010 22:25:33 -0700 (PDT)
Received: by 10.220.191.73 with HTTP; Sat, 9 Oct 2010 22:25:13 -0700 (PDT)
In-Reply-To: <AANLkTi=3BG0PScgp5X+y2-U1FqC6aoOrw_pyLU7cEzME@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158642>

Thanks for reply.

I use perl 5.8.9 and ExtUtils::MakeMaker is 6.48.

$ /usr/local/bin/perl -v | grep v5
This is perl, v5.8.9 built for i386-freebsd

What version of Perl does Git require to build?
It seems INSTALL does not mention it.

Thank you
On Sun, Oct 10, 2010 at 1:46 PM, Tay Ray Chuan <rctay89@gmail.com> wrot=
e:
> On Sun, Oct 10, 2010 at 10:52 AM, Akira Kitada <akitada@gmail.com> wr=
ote:
>> Hello,
>>
>> I'm hitting the following errors during Git 1.7.3.1 build on FreeBSD=
 4.
>> I didn't see this problem when I built 1.7.0.1 so I should be
>> introduced in the recent versions.
>> Is there any reports regarding this?
>>
>> Thank you
>>
>> $ ./configure && gmake -j 1 V=3D1
>> ...
>> rm -f git-add--interactive git-add--interactive+ && \
>> =A0 =A0 =A0 =A0INSTLIBDIR=3D`MAKEFLAGS=3D gmake -C perl -s --no-prin=
t-directory instlibdir` && \
>> =A0 =A0 =A0 =A0sed -e '1{' \
>> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0s|#!.*perl|#!/usr/bin/per=
l|' \
>> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0h' \
>> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0s=3D.*=3Duse lib (split(/=
:/, $ENV{GITPERLLIB} || "'"$INSTLIBDIR"'"));=3D' \
>> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0H' \
>> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0x' \
>> =A0 =A0 =A0 =A0 =A0 =A0-e '}' \
>> =A0 =A0 =A0 =A0 =A0 =A0-e 's/@@GIT_VERSION@@/1.7.3.1/g' \
>> =A0 =A0 =A0 =A0 =A0 =A0git-add--interactive.perl >git-add--interacti=
ve+ && \
>> =A0 =A0 =A0 =A0chmod +x git-add--interactive+ && \
>> =A0 =A0 =A0 =A0mv git-add--interactive+ git-add--interactive
>> 'INSTALLSITEMAN3DIR' is not a known MakeMaker parameter name.
>> 'INSTALL_BASE' is not a known MakeMaker parameter name.
>> Writing perl.mak for Git
>> 'INSTALLSITEMAN3DIR' is not a known MakeMaker parameter name.
>> 'INSTALL_BASE' is not a known MakeMaker parameter name.
>
> This looks like a problem with Perl. What version do you have?
>
> You can check that with cpan - type "m ExtUtils::MakeMaker", and look
> at the INST_VERSION line.
>
> --
> Cheers,
> Ray Chuan
>

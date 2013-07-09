From: Ilya Holinov <holinov@netvoxlab.ru>
Subject: Re: [BUG] git svn geotrust certificate problem
Date: Tue, 9 Jul 2013 12:45:02 +0400
Message-ID: <CAOfgeSYfMjkW87PjmaVWoMKtKTGfmq0dHyT6-gkBUP1bLOBm5w@mail.gmail.com>
References: <CAOfgeSaRmqRj3gCGy0q9ehr=znzyPONa-Ze03hTo69QLHMuQjA@mail.gmail.com>
	<20130708194604.GA7038@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 10:45:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwTXr-0006g8-CS
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 10:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab3GIIpG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 04:45:06 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:44490 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab3GIIpE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 04:45:04 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so4599088lab.18
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 01:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=0mtuclC55PYCJDkhYCb3EMYDtVLfKTm0KCGdyoDGT3o=;
        b=mQt10aegIIXFddH/OZHFf0xvq3AYHsyxS9/OofK9oMxtpUNwmBZaJr3tBuNi0bpjti
         ER2v/QNfoXyNWW/vlTK4+zYuieuckv/uq41GkLMGIpIgWTb8xmKqFx15OaPoPv/ojtGu
         bGNtUcyYIfh/9EiItE+1XxrzsS5xYDlpZwRWDrU05Pc6BdUh2pX+IWwe5BYJpSNDpIYP
         v68ndtK4BHa0n+m9+TEhnIz3JTkpqIh2POBNVJP7uuHNRlEeOLNl9jdZAwTpFrXs1+lS
         Sz0c2BfwU6LBU8V13KQygw6qB/7G7n0DpLGFSUShmOLjRLzK5yX5NjHphTptqGu+eAN7
         I/SQ==
X-Received: by 10.152.29.41 with SMTP id g9mr12195583lah.44.1373359502148;
 Tue, 09 Jul 2013 01:45:02 -0700 (PDT)
Received: by 10.112.74.47 with HTTP; Tue, 9 Jul 2013 01:45:02 -0700 (PDT)
In-Reply-To: <20130708194604.GA7038@paksenarrion.iveqy.com>
X-Gm-Message-State: ALoCoQmIUY+f9vSvgrl85l7LTc4n8x2qei13TWkhWZupig/OeA5OBJS+ZjCvJtOKmLRn7Onh6HfO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229920>

Thanks for trying to help me.
I'v found an issue - that happend because i had system username
written in russian language.
When i'v changed to user with english characres username everything
started to work ok
_____________

C =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC
=D0=A5=D0=BE=D0=BB=D0=B8=D0=BD=D0=BE=D0=B2 =D0=98=D0=BB=D1=8C=D1=8F =D0=
=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B5=D0=B2=D0=B8=D1=87,

=D0=92=D0=B5=D0=B4=D1=83=D1=89=D0=B8=D0=B9 =D0=B8=D0=BD=D0=B6=D0=B5=D0=BD=
=D0=B5=D1=80-=D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B8=D1=81=
=D1=82

=D0=93=D1=80=D1=83=D0=BF=D0=BF=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BF=D0=B0=D0=BD=
=D0=B8=D0=B9 =C2=AB=D0=9D=D0=B5=D1=82=D0=B2=D0=BE=D0=BA=D1=81=C2=BB

=D0=9C=D0=BE=D0=B1: +7 (964) 7075157

=D0=A0=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9: +7 (499) 502 2020 =D0=B4=D0=
=BE=D0=B1 547

Email: holinov@netvoxab.ru,
-------------------------------------

=D0=93=D1=80=D1=83=D0=BF=D0=BF=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BF=D0=B0=D0=BD=
=D0=B8=D0=B9 =C2=AB=D0=9D=D0=B5=D1=82=D0=B2=D0=BE=D0=BA=D1=81=C2=BB =D0=
=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D1=8F=D0=B5=D1=82 =D0=BA=D0=BE=D0=
=BC=D0=BF=D0=B0=D0=BD=D0=B8=D0=B8 =D0=B2 =D0=BE=D0=B1=D0=BB=D0=B0=D1=81=
=D1=82=D0=B8 =D1=80=D0=B0=D0=B7=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BA=D0=B8
=D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BD=D0=BE=D0=B3=D0=BE=
 =D0=BE=D0=B1=D0=B5=D1=81=D0=BF=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D1=8F, =D0=
=B8=D0=BD=D1=82=D0=B5=D0=B3=D1=80=D0=B0=D1=86=D0=B8=D0=B8 =D0=B8=D0=BD=D1=
=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=BE=D0=BD=D0=BD=D1=8B=D1=85 =D1=
=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC =D0=B8
=D0=BE=D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F =D0=B1=D0=B8=D0=B7=D0=BD=D0=B5=D1=81-=D0=BA=D0=BE=D0=BD=D1=81=D0=
=B0=D0=BB=D1=82=D0=B8=D0=BD=D0=B3=D0=B0:
=D0=9E=D0=9E=D0=9E =C2=ABNetvox Lab=C2=BB

___________________________


2013/7/8 Fredrik Gustafsson <iveqy@iveqy.com>:
> On Fri, Jul 05, 2013 at 07:16:01PM +0400, Ilya Holinov wrote:
>> I have svn repository on https singed with GeoTrust issued certifica=
te.
>> Every time i try to access this repository i have message :
>>
>> $ git svn rebase
>> Error validating server certificate for 'https://svn.egspace.ru:443'=
:
>>  - The certificate is not issued by a trusted authority. Use the
>>    fingerprint to validate the certificate manually!
>> Certificate information:
>>  - Hostname: *.egspace.ru
>>  - Valid: from Apr 28 01:38:17 2013 GMT until Apr 30 12:00:40 2014 G=
MT
>>  - Issuer: GeoTrust, Inc., US
>>  - Fingerprint: b2:8d:f8:3b:7c:d2:a2:36:e2:1d:c3:5c:56:ec:87:6f:22:3=
e:4b:a8
>> Certificate problem.
>> (R)eject, accept (t)emporarily or accept (p)ermanently? p
>> Authentication realm: <https://svn.egspace.ru:443> VisualSVN Server
>> Username: holinov
>> Password for 'holinov':
>>
>> Even if i choose permanently every next attempt to access in i have
>> same issue. And this happens on svn rebase on every commit. I mean i=
f
>> i have 10 commits in local repository i will be asked about cert and
>> user login\passwor for every one of them (and that's is verry
>> annoying).
>> But if i use TortoiseSVN i have no problem with checking that cert.
>>
>> P.S.: I'm using Windows 8 x64.
>> P.P.S: I like git very much but in this case it makes me impossible =
to
>> work in this way.
>
> This isn't really my thing to answer, I don't know windows well enoug=
h.
> However since you still haven't got an answer I'll give it a try.
>
> Please see the following link:
> https://confluence.atlassian.com/display/SOURCETREEKB/Resolving+SSL+S=
elf-Signed+Certificate+Errors
>
> --
> Med v=C3=A4nliga h=C3=A4lsningar
> Fredrik Gustafsson
>
> tel: 0733-608274
> e-post: iveqy@iveqy.com

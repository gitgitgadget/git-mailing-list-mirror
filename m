From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGit] Can't compile under windows (MSVC2008)
Date: Tue, 07 Oct 2008 13:55:24 +0200
Message-ID: <48EB4E2C.3040405@lyx.org>
References: <gbak2u$v9b$1@ger.gmane.org> <e5bfff550810070414u283f5ccav33712ca1c6212bde@mail.gmail.com> <48EB4ADF.8010908@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 13:58:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnBCl-0001Gp-SL
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 13:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYJGLzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Oct 2008 07:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbYJGLzd
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 07:55:33 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:37887 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbYJGLzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 07:55:32 -0400
Received: from smtp5-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 3F6EB3EA1D5;
	Tue,  7 Oct 2008 13:55:31 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 144303EA247;
	Tue,  7 Oct 2008 13:55:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <48EB4ADF.8010908@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97697>

On 07/10/2008 13:41, Abdelrazak Younes wrote:
> On 07/10/2008 13:14, Marco Costalba wrote:
>> 2008/9/23 Abdelrazak Younes<younes@lyx.org>:
>>> Hello,
>>>
>>> I tried to follow README_WIN.txt:
>>>
>>> C:\devel\qgit\qgit4>qmake qgit.pro
>>>
>>> The Makefile (attached to this mail) seems to be correctly generate=
d=20
>>> in the
>>> same directory (C:\devel\qgit\qgit4).
>>>
>>> Then, under MSVC2008 Express, I get this error:
>>>
>>> 1>------ D=C3=A9but de la g=C3=A9n=C3=A9ration : Projet : qgit, Con=
figuration :=20
>>> Debug Win32
>>> ------
>>> 1>Actions de projet Makefile en cours
>>> 1>Microsoft (R) Program Maintenance Utility Version 9.00.21022.08
>>> 1>Copyright (C) Microsoft Corporation. Tous droits r=C3=9Aserv=C3=9A=
s.
>>> 1>  cd src\&&  "C:\Program Files\Microsoft Visual Studio
>>> 9.0\VC\bin\nmake.exe" debug
>>> 1>Microsoft (R) Program Maintenance Utility Version 9.00.21022.08
>>> 1>Copyright (C) Microsoft Corporation. Tous droits r=C3=9Aserv=C3=9A=
s.
>>> 1>NMAKE : fatal error U1073: incapable d'obtenir 'src\\Makefile'
>>> 1>Stop.
>>> 1>NMAKE : fatal error U1077: 'cd'=C3=A1: code retour '0x2'
>>> 1>Stop.
>>> 1>Project : error PRJ0019: Un outil a retourn=C3=A9 un code d'erreu=
r =C3=A0=20
>>> partir de
>>> "Actions de projet Makefile en cours"
>>> 1>Le journal de g=C3=A9n=C3=A9ration a =C3=A9t=C3=A9 enregistr=C3=A9=
 =C3=A0 l'emplacement
>>> "file://c:\devel\qgit\qgit4\Debug\BuildLog.htm"
>>> 1>qgit - 3 erreur(s), 0 avertissement(s)
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D G=C3=A9n=C3=A9ration : 0 a r=C3=A9us=
si, 1 a =C3=A9chou=C3=A9, 0 mis =C3=A0 jour, 0 a=20
>>> =C3=A9t=C3=A9 ignor=C3=A9
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Idea someone?
>>>
>>
>> have you tried to setup MSVC for custom build ?
>
> Sorry, I don't follow you.
>
>>   and pass proper
>> comamnd line with nmake ?
>
> In the NMAKE field of the project properties, there is 'nmake /f=20
> Makefile debug', is that what you mean?

OK, by removing '/f Makefile' I manage to compile qgit from within=20
Visual Studio. I also managed to launch it in debug mode by selecting=20
the executable in ../bin/qgit.exe. When launched this way (F5), qgit=20
opens up with the qgit repository but the user name and email are still=
=20
not filled in, I'll try to debug that now.

Abdel.

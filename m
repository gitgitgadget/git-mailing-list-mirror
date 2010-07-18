From: "Rainer Lauer" <lauerr@gmx.net>
Subject: AW: Challenge with Git-Bash
Date: Sun, 18 Jul 2010 20:08:44 +0200
Message-ID: <008a01cb26a4$4313e360$c93baa20$@gmx.net>
References: <001d01cb25cb$eb176980$c1463c80$@net> <20100717171303.GB10730@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <msysgit@googlegroups.com>
To: "'Jonathan Nieder'" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:08:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYIH-0005kJ-FO
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844Ab0GRSIs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 14:08:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:53062 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756830Ab0GRSIr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 14:08:47 -0400
Received: (qmail invoked by alias); 18 Jul 2010 18:08:45 -0000
Received: from pD9E08E8C.dip.t-dialin.net (EHLO Lappi) [217.224.142.140]
  by mail.gmx.net (mp064) with SMTP; 18 Jul 2010 20:08:45 +0200
X-Authenticated: #9219177
X-Provags-ID: V01U2FsdGVkX1/gVJkOsLLgRFtSbZrqOdk+N3D712NgZiNHpff+Fo
	COS06uMzwBEcNM
In-Reply-To: <20100717171303.GB10730@burratino>
X-Mailer: Microsoft Outlook 14.0
thread-index: AQJBLblBgdg5C3/Ahc5qaLKbDJjUnQNsR91rka+Ek0A=
Content-Language: de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151227>

Hi Jonathan,
thanks for this hint. Now it is working on the base of environment vari=
ables.

In order of automatically setting up my projects I'd like to use the co=
nfiguration file for preparing  CVS-work instead introducing environmen=
t variables.
Unfortunately, I'm facing another problem.
=46ollowing commands don't modify .git/config coming along with my proj=
ect(s).
git config user.name=3D"Rainer Lauer"
git config user.email=3D"Rainer.Lauer@gmx.net"
git config core.editor=3D"c:/Program Files/SlickEditV14.0.2/win/vs.exe"
The file seems to stay in initial revision as created with the command =
git init.

Where is following information stored? Command:  git config --global us=
er.name=3D"Rainer Lauer". Did I get the documentation right that this i=
s a definition for all projects?

Regards,
Rainer

-----Urspr=C3=BCngliche Nachricht-----
Von: Jonathan Nieder [mailto:jrnieder@gmail.com]=20
Gesendet: Samstag, 17. Juli 2010 19:13
An: Rainer Lauer
Cc: git@vger.kernel.org; msysgit@googlegroups.com
Betreff: Re: Challenge with Git-Bash

(+cc: msysgit)

Hi Rainer,

Rainer Lauer wrote:

> with my Windows 7 Git-Installation I get following challenge:
>
> 1)	Set GIT_EDITOR to editor of your choice
>
> 2)	With Windows7 let this editor run in admin-mode
> 	Goto .exe-file -> right mouse-click -> compatibility -> run program
>	as admin (I'm running a German version maybe English names are slight=
ly
>	different)
>
> 3)	Make a git action like git add file
>	                       git commit
> 	from the git bash.
>
> 4)	Now following message appears:  sh.exe: ./"editor of your choice":
> Bad file number
>
> Everything is fine without Admin-Mode set for editor.

Apparently =E2=80=9CBad file number=E2=80=9D can mean =E2=80=9CPermissi=
on denied=E2=80=9D among other things on Windows.  I do not have any be=
tter suggestion than to try running git bash as administrator too, sorr=
y.

Regards,
Jonathan

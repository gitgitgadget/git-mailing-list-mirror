From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: msysGit and SCons: broken?
Date: Sat, 15 Aug 2009 16:04:28 +0200
Message-ID: <4A86C06C.3060409@dirk.my1.cc>
References: <4A772A43.8070503@dirk.my1.cc> <alpine.DEB.1.00.0908040010220.8306@pacific.mpi-cbg.de> <4A7B32EA.2080505@dirk.my1.cc> <4A846A5A.4000000@dirk.my1.cc> <alpine.DEB.1.00.0908132353380.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 15 16:08:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McJvT-0006xP-6Q
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 16:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbZHOOHx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Aug 2009 10:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbZHOOHx
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 10:07:53 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:45360 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbZHOOHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 10:07:52 -0400
Received: from [84.176.89.3] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1McJry-0008NC-HE; Sat, 15 Aug 2009 16:04:30 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <alpine.DEB.1.00.0908132353380.8306@pacific.mpi-cbg.de>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126004>

Am 13.08.2009 23:54 schrieb Johannes Schindelin:
> Hi,
>=20
> On Thu, 13 Aug 2009, Dirk S=FCsserott wrote:
>=20

=2E..

>> If someone had the same or a similar problem: I tracked it down and=20
>> found a solution. The problem was that I tried to run a Windows prog=
ram=20
>> from git-bash. The Windows program then faces the bash's $PATH with =
a=20
>> different separator (':' vs. ';') and a different root directory ('/=
c/'=20
>> vs. 'C:/').
>=20
> I cannot believe that.  I actually run a Windows program very often, =
from=20
> Git Bash, and PATH is correctly converted all the time.
>=20
> Ciao,
> Dscho

Hmm, I wrote a simple "hello $PATH" and it actually DID print the path=20
in Windows' flavour when started from Git Bash, like you said. Dunno wh=
y=20
ActivePython ceased to do so as well... Probably I confused my machine=20
by extending PATH in Windows and .bashrc with different PATHs in=20
different order. Or ActivePython is somehow "zickig" (what's that in=20
english? :-)). However, now it works for me and as SCons is the only=20
tool that failed, I see no further need for investigation.
Btw., I started scons from Git Bash with

   cmd //c C:/Python24/Scripts/scons.bat "$@"

Maybe that's a problem, but I don't care any longer.

Dirk

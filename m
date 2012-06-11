From: Ilya Dogolazky <ilya.dogolazky@nokia.com>
Subject: Re: git-p4: commits are visible in history after 'git p4 clone',
 but not a single file present
Date: Mon, 11 Jun 2012 22:16:28 +0300
Message-ID: <4FD6440C.7090900@nokia.com>
References: <4FD5C263.9010307@nokia.com> <CAE5ih79Lgc8vF0v=vTGZSwASsGwQWs2Q7h_AkW67RBfi-R=DCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 21:16:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeA6Q-0006mX-Sd
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab2FKTQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 15:16:35 -0400
Received: from smtp.nokia.com ([147.243.128.26]:36677 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab2FKTQe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:16:34 -0400
Received: from [10.162.253.82] (essapo-nirac25382.europe.nokia.com [10.162.253.82])
	by mgw-da02.nokia.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id q5BJGT37006431;
	Mon, 11 Jun 2012 22:16:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAE5ih79Lgc8vF0v=vTGZSwASsGwQWs2Q7h_AkW67RBfi-R=DCA@mail.gmail.com>
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199711>

Hi Luke!

06/11/2012 06:28 PM, ext Luke Diamand =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:
> If you do something like "p4 describe 17473" what does that show?
=46irst I see a line containing the change number, my colleague's name =
and=20
date, then the commit title (identical to one printed by "git log"),=20
then a list of files [every line begins with "... //xxx/yyy/"], then th=
e=20
word "Differences" and then something looking very much like output of=20
'diff' command (the actual commit differences).

> Are the files changed all contained with //kalma/xxx/yyy?
Yes, they are.

> It could be that there's a p4 version problem going on - which versio=
n
> of p4 are you
> using?
The output of 'p4 -V' contains "Rev. P4/LINUX26X86/2012.1/459601=20
(2012/05/11)". That's probably the version of my command line client.

The output of "p4 info" contains "P4D/LINUX26X86_64/2011.1/428451=20
(2012/03/08)" --- that's probably the version of the server.

The version of git installation (by debian package) is 1:1.7.10-1 (as=20
reported by "dpkg -l git"). The package contains the file=20
"/usr/share/doc/git/contrib/fast-import/git-p4" which I copied to=20
$HOME/bin/git-p4 in order to have in $PATH and with executable bit.=20
Could it be, that I did something wrong here by making this manually?

 > And which platform are you using?
Debian GNU/Linux.

I hope I provided all the needed information, of not please ask for mor=
e.

Cheers,

Ilya

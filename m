From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: Gitk: shortcut to jump to the current HEAD (yellow spot)?
Date: Sun, 25 Dec 2011 20:33:33 +0100
Message-ID: <4EF77A8D.7020907@dirk.my1.cc>
References: <4EF3517A.8030108@dirk.my1.cc> <874nwslayi.fsf@fox.patthoyts.tk> <4EF4CE80.8090502@dirk.my1.cc> <CAOeW2eGCKxYW1TT-HPoSCO0_PsQPX5C-bcHLUy73MTd7=CsqRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Git Mailing List <git@vger.kernel.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 25 20:34:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RetpX-0002UB-TH
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 20:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab1LYTdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Dec 2011 14:33:39 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:40918 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab1LYTdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2011 14:33:38 -0500
Received: from [84.176.34.130] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Retp9-0006bY-6y; Sun, 25 Dec 2011 20:33:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CAOeW2eGCKxYW1TT-HPoSCO0_PsQPX5C-bcHLUy73MTd7=CsqRA@mail.gmail.com>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187688>

Am 24.12.2011 05:22 schrieb Martin von Zweigbergk:
> 2011/12/23 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>:
>>
>> That's because gitk behaves odd (at least to me) when not run from t=
he
>> top-level directory. E.g. the "touching paths" box won't find files =
in
>> the top dir if you don't prefix them with a slash.
>=20
> This should be fixed in c332f44 (gitk: Fix file highlight when run in
> subdirectory, 2011-04-04), which is in the current master and thus, I
> believe, to be released in Git 1.7.9.
>=20
> Martin

Ahh, cool. I wouldn't have noticed because I'm so used to my "cd $TOP &=
&
gitk". I thought it was by intention because it just behaves like "git
log": When run from subdirs it doesn't know about topdir files: Assume
README.txt is in the topdir and current dir is some subdir:

$ git log -- README.txt    # fails
$ git log -- ../README.txt # works

My alias (or function) was just a helper to avoid remembering where I
started gitk from.

Cheers,
    Dirk

BTW, Merry X-Mas to you and all others on the list :-)

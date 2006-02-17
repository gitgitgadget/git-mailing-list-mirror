From: =?ISO-8859-15?Q?=22J=2E_David_Ib=E1=F1ez=22?= <jdavid@itaapy.com>
Subject: Re: Use case: GIT to manage transactions in a CMS?
Date: Fri, 17 Feb 2006 12:10:52 +0100
Message-ID: <43F5AF3C.5050507@itaapy.com>
References: <43F30602.500@itaapy.com> <43F31454.8060704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 12:22:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA3gM-0006UD-Kk
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 12:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWBQLVq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 17 Feb 2006 06:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWBQLVq
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 06:21:46 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:4882 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751088AbWBQLVp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 06:21:45 -0500
Received: from [192.168.0.101] (itaapy-255-90.cnt.nerim.net [195.5.255.90])
	by kraid.nerim.net (Postfix) with ESMTP id D056240E2A;
	Fri, 17 Feb 2006 12:21:43 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051204
X-Accept-Language: en, es, fr, pt, it, zh
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43F31454.8060704@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16338>

Andreas Ericsson wrote:

> J. David Ib=E1=F1ez wrote:
>
>> Hello,
>>
>> I am working on a project (a content management system) where the da=
ta
>> is stored as files and folders.
>>
>> Currently, for persistance and transactions we use the ZODB [1] obje=
ct
>> database. But our goal is to move away from the ZODB and use directl=
y
>> the file system, as it will allow us to use all the good unix tools.
>>
>> We are using git to manage the source code. And now we are exploring=
 git
>> to see if it can do the job of transactions, so that each transactio=
n in
>> the system will be a git commit.
>>
>> One problem we have found is that we can not commit empty directorie=
s
>> (what
>> we need to do). Any idea how to solve or work-around this constraint=
?
>>
>
> $ touch empty/dir/.placeholder
>
>

I would like to have something better, no so much of a work-around.

Maybe I could hack something, are there some docs explaining the
internal format of git objects? or, where to look in the source to
find this info?


>> Any suggestions and input on this exotic use case for git will be ve=
ry
>> welcomed.
>>

Another point, the application is written in Python, right now I
have to open a shell to run the git commands.

It would be nice if the core functionality was implemented in a C
library, then with a Python wrapper I could use git without going
through the shell.

Is this something to be expected? There will be a "libgit" sometime
in the future?


> Sounds cool. I'll have to give it a whirl when you've got something t=
o
> show.
>

Probably I will have to hack something else to have ACID transactions,
in the short-term. But "git" is at least interesting, since it could
open a world of possibilities. If I ever have something to show, I will
tell you.


--=20
J. David Ib=E1=F1ez
Itaapy <http://www.itaapy.com>         Tel +33 (0)1 42 23 67 45
9 rue Darwin, 75018 Paris              Fax +33 (0)1 53 28 27 88=20

From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: qgit-0.4
Date: Fri, 10 Jun 2005 14:16:23 -0700 (PDT)
Message-ID: <20050610211623.15018.qmail@web26308.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 23:12:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgqnX-0004uo-V6
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 23:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVFJVQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 10 Jun 2005 17:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFJVQe
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 17:16:34 -0400
Received: from web26308.mail.ukl.yahoo.com ([217.146.176.19]:48769 "HELO
	web26308.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261227AbVFJVQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 17:16:27 -0400
Received: (qmail 15020 invoked by uid 60001); 10 Jun 2005 21:16:23 -0000
Received: from [151.38.74.248] by web26308.mail.ukl.yahoo.com via HTTP; Fri, 10 Jun 2005 14:16:23 PDT
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Radoslaw Szkodzinski wrote:

>Marco Costalba wrote:
>
>>Here is qgit-0.4, a git GUI viewer
>>
>>New in this version:
>>
>>- file history
>>
>>- command line arguments passed to git-rev-list, eg: qgit v2.6.12-rc6=
 ^v2.6.12-rc4
>>
>>- complete rewrite of start-up thread, should be faster now, expecial=
ly with warm start
>>
>>=20
>>
>>
>It certainly is faster. However, I have some gripes with it:
>- it doesn't support national characters
>- it doesn't decode dates (author Rados=B3aw Szkodzi=F1ski
><astralstorm@gorzow.mm.pl> 1118416741 +0200)

In cogito repository I see:

Author: Petr Baudis <pasky@ucw.cz>
Date:   09/06/2005 11:12:40
Parent: 5b46e22e1c6de0dd800effb6136ac713698f98cf

    cogito-0.11.3

and in the author column the dates are all stripped away. If you can pr=
ovide me with some of your
stuff I can check what happens with your date and fix also the national=
 charachters.

>- you could run git-rev-list niced, and maybe with --pretty and

git-rev-list is used just to load and parse all the raw data, the outpu=
t format in bottom left
window is set indipendently of the git-rev-list format. Indeed the form=
at is the same of --pretty
option i.e. without committer information, also if I run git-rev-list -=
-header because I need
committer date to reorder and draw the graph becuse I need the property=
 parent->date <=3D
child->date.=20

>--merge-order
>- somehow the program is much slower than gitk and I don't think it's
>caused by qt or C++

I think so the same :-)


>
>AstralStorm
>

Marco



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20

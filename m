From: =?utf-8?B?UGFwIEzDtHJpbmM=?= <paplorinc@yahoo.com>
Subject: Parallel refactoring and git merge nightmare
Date: Wed, 11 Apr 2012 09:13:23 -0700 (PDT)
Message-ID: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com>
Reply-To: =?utf-8?B?UGFwIEzDtHJpbmM=?= <paplorinc@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:13:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0Aj-0004xq-Ka
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759734Ab2DKQNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 12:13:25 -0400
Received: from nm1.bullet.mail.bf1.yahoo.com ([98.139.212.160]:27617 "HELO
	nm1.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756723Ab2DKQNY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:13:24 -0400
Received: from [98.139.212.148] by nm1.bullet.mail.bf1.yahoo.com with NNFMP; 11 Apr 2012 16:13:23 -0000
Received: from [98.139.212.223] by tm5.bullet.mail.bf1.yahoo.com with NNFMP; 11 Apr 2012 16:13:23 -0000
Received: from [127.0.0.1] by omp1032.mail.bf1.yahoo.com with NNFMP; 11 Apr 2012 16:13:23 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 764545.17292.bm@omp1032.mail.bf1.yahoo.com
Received: (qmail 92161 invoked by uid 60001); 11 Apr 2012 16:13:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1334160803; bh=T33riG0jmCPImO3oign0uJ1d3lSyrTWTksAFboPTEOE=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=deb8r7PO+rNulrdlaHvDgkLhNd+g957+jnOoIipK5w/xgz1GkUXsxWGOCFquuHvL5BEZwxSIk2jCp+b7x82JYeM0KflzIab8g9d7bUbeL/STu4s7ZI2cFAzqe+z0tSxWBf4q7y0bZsd4rpCSDJ9K9XKrsHyx468FqAJBu3cPtCg=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AmpagJUVLFAExGqSrIh6aWOHTyYAIyl6k3Wy9apXJGWqa1vre7EOJMGh+F4ySSJg5bFf3T/gnSLS09SH4kRDrOlJAB6CJG0u2tensITqS8o/RZzL0MmTBcdJ8VA0f3hKSqLMf7ksYrSY+Yt3Laz4YllAMEtGgoBO1MGOZO5UZPc=;
X-YMail-OSG: PlYQ70UVM1nMJ8y0IAqQMSxIj2xqbpaNjvzMfv44zXR8bb6
 eeW15nm6oOAJxMUSogRO4Ggl97VkjPVrp1P0wbdYAzDTKn1vK3Yuh1DAZ32b
 Z1E_XYIsPhd9NsC9slAT75ejIbZLEJd.NHhu4xrycTkwY2q5jTkW13VViygt
 AR7xa5nI9eoCvvQIUoavmv3GI8WKLBVWMMvhlwW7CJXrZkAjLB2na289NSRY
 MzDCZA87aNBYiWwXhqgeU2IHJP9d4Gi947et_pZaraxGwRyxjmHKQwuzckTf
 MpcMq1Z517XYDzSTV3pZkp5Z3AWURAzQ3ycZiH8ZcRGTt3M0xX_eQ0BsZnUZ
 V7JQ7dbxiYGmnOsIc2sZvOGgJbQD4Sj1iykB_n2jjk.cHqVWwmFAyW5IEFn_
 3SB0PxRnwYDDjMzzaPbo6wMpzXpguGOAH8LS.IE4qt9fBIR1dgOEPEUoa4GF
 rMAUZAFCYjoc2ur1viTAmS2UodA--
Received: from [89.137.110.183] by web160603.mail.bf1.yahoo.com via HTTP; Wed, 11 Apr 2012 09:13:23 PDT
X-Mailer: YahooMailWebService/0.8.117.340979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195197>

Hello! :)

We are working in parallel on the refactoring of a=20
small project. The team uses SVN and I decided to give GIT a chance to=20
demonstrate it's merging capabilities I've read so much good about :).

However
 - I must be doing something VERY wrong - every time I try to merge fro=
m
 the remote svn (git svn fetch and git merge remotebranch) into my=20
branch, I get hundreds of conflicts, mostly because of moved folders.

I
 tried it from the console (latest git), from Idea (11.1.1), from git=20
extensions, from gitk, from tortoisegit and they all offer me a=20
one-by-one resolution of the conflicts, that should have been resolved=20
automatically (in Idea and tortoisegit I can select "theirs" to all the=
=20
conflicts, but they still give errors at the end).

I think the=20
problem arises because git doesn't track
 moves, therefore I constantly get conflicts of type "local modified,=20
remote deleted" (or even both deleted) when in fact it was only modifie=
d
 and moved, it could have been merged without conflicts (-> apply my=20
changes and move the file to the new location).

Even if I move=20
the files manually (eg. from totalcommander) to their final locations (=
I
 have to copy each modified remote file to the new location ... still=20
faster than going through the hundreds of conflicts in git mergetool=20
manually, one-by-one), and added the files to the index, I have to hunt=
=20
down the duplicated files, and the ones containing the=20
"<<<<<" conflict markers (which often contain the two=20
whole files ... not just their differences, even though they are clearl=
y
 very similar), delete the merge file leftovers (theirs, base, local=20
etc), copy the files over manually, that could not be merged etc. This=20
is madness, I am merging manually!!!

I don't want conflict
 markers in my files, it's dangerous. Don't spam my files with garbage=20
(and commit them later, because it was left unnoticed in the whole=20
manual merge), use temporary files or whatever.

It would also be=20
nice if conflicts could be ignored, if the match a certain regexp (eg.=20
moving the same .java file in parallel might change the package or=20
import statements, which will result in conflicts ... I don't care, use=
=20
whichever, Idea will correct it anyway, I don't want to go through=20
hundreds of files because of this). Some hooks could be activated on=20
merge conflicts also.

What am I doing wrong, this manual or=20
one-by-one merge is absurd :(? I want git to work because of all the ba=
d
 experience I've had with TFS and SVN, but I just can't comprehend this=
=2E

Thank you for your patience,
Pap L=C5=91rinc

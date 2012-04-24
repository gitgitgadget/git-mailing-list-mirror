From: M Yep <myep01@yahoo.com>
Subject: Detached HEAD problem
Date: Tue, 24 Apr 2012 13:10:50 -0700 (PDT)
Message-ID: <1335298250.31016.YahooMailClassic@web125404.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 22:18:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMmBf-0002Xw-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 22:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab2DXURp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 16:17:45 -0400
Received: from nm18.bullet.mail.ne1.yahoo.com ([98.138.90.81]:38791 "HELO
	nm18.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755503Ab2DXURo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 16:17:44 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Apr 2012 16:17:44 EDT
Received: from [98.138.90.56] by nm18.bullet.mail.ne1.yahoo.com with NNFMP; 24 Apr 2012 20:10:50 -0000
Received: from [98.138.89.248] by tm9.bullet.mail.ne1.yahoo.com with NNFMP; 24 Apr 2012 20:10:50 -0000
Received: from [127.0.0.1] by omp1040.mail.ne1.yahoo.com with NNFMP; 24 Apr 2012 20:10:50 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 491592.24904.bm@omp1040.mail.ne1.yahoo.com
Received: (qmail 31198 invoked by uid 60001); 24 Apr 2012 20:10:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1335298250; bh=eGClKaoHjFcb0itH8QHWVYdZuFuFlBXJq39eMULqFM4=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type; b=vkdEpFEQO76D9Kz5AjUTSq+l9t3BJJ7HAtRFVU6G2cL89XFGmraZWPnPhrBDmtnF0WPOaQa9IQ0tcB34MDom1AR62xCjmuOlR5gjqm+ZrIQVuDaD5l/a7Ee5NnahYoEbMACkhF+0bf5HHeKibKohn18vrAvcBS4ZJXqf7Ll975g=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type;
  b=c+biKSjje77EbyzjrRyicrd301mZj29yu+PvvbmVJkGBq3qxATr3c/wIdf9RTiYjxaT8IasRg/raYk9f0osohHoXFDmMh70dcNkLjWGHi6x57wIx2N0IomahcsMtjC3AeC1iiqxg/+7dcUykHTmwch/PmN0Pe/A19KK+8IYPQzo=;
X-YMail-OSG: tajw2j0VM1ligmtsYvJSezAxp9L2W902K_d4M_cccxrinFp
 _N.w5tKCjxRE8ZEBu.Nkyl2V7gAf07amfVZ4P_N0Omo7PKggrnD.AwBFubYK
 BTxMH5bNhed_Z693LDkQxKflK4s031O..5TvicXDgSVy9wr7hixf8F4bxWel
 SYGwBrYuTNP1OqsSDHILAdZ8ZbT3TPT.9foHUhdMr2hDIASTZdoY6wa2Sxhl
 YK_e1cin_uSVhGol3VPdwyWRLhmsXqfIZvA4jFKQp_C4HJLAcsHiDqM7StB9
 CBAY3Xu3NV0IYR1O.HEYRBXIN8n0YiBa08KcE1bd6mzdTIsmkrHlwzzcMO.2
 yuUCO7nxvHdOIwjMBcrNtQpaN5sw.70e9DvaJkhjzU9qC4dMWgSSJRwJ0Wc1
 N9TNVFW.Gzzf6Mw.uzYQi8rMdJfdvrrCzb6XD4b.9Q8mwbXqxGOiE_asQnDF
 Vlw--
Received: from [216.152.50.10] by web125404.mail.ne1.yahoo.com via HTTP; Tue, 24 Apr 2012 13:10:50 PDT
X-Mailer: YahooMailClassic/15.0.6 YahooMailWebService/0.8.117.340979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196246>

Hello

I have been working on a project and I realized somewhere I introduced a
bug.

I found the closest save point to where i was, i believe it was HEAD -2,
and checked it out.

I then laid in several commits, and now i cant push

here is a view of my history, and the commands i executed to get into this
state

HISTORY (time flows up)

* 1bc1ffb current state
* 735d64f
* 07dd73d Project working again
* c70627c
* 4c6a8ea
* 2828db4
* c38ef0b
| * 1815aac
| | * fe6e0ac Version bump
| | * 32de1e5 BROKE
| | * 528cb37 Bug introduced?
| |/
| * ef4ff7e
|/
| * ef4ff7e
|/
* 8238b14 GOOD
.
.
.


COMMANDS (time flows down)

PUSH 8238b14 GOOD
PUSH ef4ff7e
PUSH 528cb37 Bug introduced?
PUSH 32de1e5 BROKE
PUSH fe6e0ac BROKE Version bump
CHECKOUT master -> ef4ff7e
CHECKOUT ef4ff7e -> dev
COMMIT 1815aac
CHECKOUT dev -> 8238b14
COMMIT c38ef0b
COMMIT 2828db4
COMMIT 4cba8e9
COMMIT c70627c
COMMIT 07dd73d  Project OK again
CHECKOUT 07dd73d -> mvp1
CHECKOUT mvp1 -> master
COMMIT 735d64f
COMMIT 1bc1ffb    current state

now when i try to push:

user@host:~/workspace/project$ git push
To git@github.com:xxxxxxxxxxxxx.git
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'git@github.com:xxxxxxxxxxxxxxxxxxx.git'
To prevent you from losing history, non-fast-forward updates were rejected
Merge the remote changes before pushing again.  See the 'Note about
fast-forwards' section of 'git push --help' for details.


user@host:~/workspace/project$ git status
# On branch master
# Your branch and 'origin/master' have diverged,
# and have 7 and 4 different commit(s) each, respectively.
#
nothing to commit (working directory clean)


user@host:~/workspace/project$ git branch
 dev
* master
 mvp1
 noopt
 temp


Any help would be great.

Thanks

Mike

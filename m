From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [GSoC 11 submodule] Status update
Date: Mon, 27 Jun 2011 21:34:44 +0200
Message-ID: <20110627193444.GA26778@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: iveqy@iveqy.com, hvoigt@hvoigt.net, jens.lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 21:20:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbHMF-0000Ti-Cn
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 21:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab1F0TUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jun 2011 15:20:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61606 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab1F0TUV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 15:20:21 -0400
Received: by bwd5 with SMTP id 5so1467556bwd.19
        for <git@vger.kernel.org>; Mon, 27 Jun 2011 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=45OSFvf6sujpopG5u1UpNkCACZtFJZONc8090FdAbMk=;
        b=VSQY7yhX3aTJphwZDw7a6FAgboVJLbWOEqNn5AVk5oWHTnOMy7f+MzHVovvXkyPe+g
         YuLM06ND3jMlCGY7WSrZiUlTLgnNEHvhD0GWGiy4naEBshmprKQKXVVX9S8P0cTFJbfX
         SQnKTxFiIBYWI7xUmH8oXYMAzu35IzPuXSTfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=Ojw3GAW2081A0hxX0V0Wtexl3BtfGZ9mXzJEf5anbsUSXSdM89jeIYxM8CB/zVU6jW
         pKVwNV3lS+TXAR+LdfV3nk0rigXRKlEOpP6IvouIgvRkLiszJQfmG4oXM8QOn3mehWJA
         nV08hwNpjLNVcCRqm7CDq2dGX54/XnsP0zIZw=
Received: by 10.204.3.21 with SMTP id 21mr4711222bkl.6.1309202419370;
        Mon, 27 Jun 2011 12:20:19 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id v6sm4424048bkf.23.2011.06.27.12.20.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Jun 2011 12:20:18 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1QbHa0-00070f-5F; Mon, 27 Jun 2011 21:34:44 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176367>

Hi,
time for a status update on the git submodule improvements GSoC 11 proj=
ect.
This will be divided in to three section, technical progress, personal
reflection and how to follow my work.

You can read my previous status update here [1].

Technical progress
------------------
Three patch-series has been sent with a total of five patches (six if y=
ou
count patches that I don't have written).

=46irst a patch series to make git submodule update continue update oth=
er submodules
when one submodule fails to be updated [2]. This patch is now in Junios
pu-branch.

Second a minor patch to reduce memory consumption. The improvements was
pretty small, but I took it as an exercise to write and send patches (i=
n the
first patch-series I'd too many non-code related error for my taste). T=
his
patch was however rejected [3].

My third patch series was about making push submodule aware to prevent =
the
user to forgot to push. This is currently sent to the list as an RFC [4=
].
This was the most challenging patch to write and a good start for my ne=
xt
task.

My fourth task (and the main task of this summer) will start on June 27=
 and
will be to move a submodules .git-dir into the super-projects .git-dir.
Design of this is already done and approved by my mentors.

Personal reflection
-------------------
Before starting this project I was a frequent git user. I use git every
day. Apparently, you can be a frequent git user without using the power=
 of
git. I've learned a lot of git as a tool the past weeks. I've learned g=
it
rebase very well, a tool I never used before. It's really useful and
dangerous. Other commands I started to use (but not had any need for
before) was cherry-pick and branches.

I can clearly see that git can be a huge problem in a workspace with
power-git-users and unmotivated anti-scm users.

Although I was familiar with valgrind and gdb before, I never had any
really use for the tools in my development. Actually, they are really g=
ood
and I believe I have a lot to learn on this area.

My start has been very slow, it was harder than I thought to write a pr=
oper
patch and I spent a lot of time on formalities and test-writing, parts =
that
I previously thought where small or non-existing.

=46or the first time I've truly used a test driven development cycle. M=
y
school experience of this was very bad. It was hard, slow and not neede=
d.
However, now I learned that you actually can benefit from a test-driven
development cycle, that it can save time and that tests actually can be
fairly easy to write.

The mentor/student communication has also been something completely new=
=2E
How much help can you ask for? That's a very hard question. My mentors
fortunately helps me with this as well. And so far this has been a real=
ly
good support. It's far, far better than the support I've at school.

The code review cycle is pretty amazing. All code that I submits is vie=
wed
by at least three persons, probably ever more. Even though a few bugs h=
as
slipped past to the last guard (Junio) and this proves the real value o=
f
code reviewing. Git has by far the most serious code review process I e=
ver
worked with. This is amazing and gives a good platform for having good =
code
written. This is also something that we do not practice in school.

How to follow my work
---------------------
You can follow my work on github [5]. There are as of now five interest=
ing
branches:

* gsoc11_submodule_enhancements
  Contains all patches sent to the list (this does not include RFC
  patches). This will always be clean and "stable".
* git-submodule-update
  Contains all commits for the git-submodule update patch series. This =
is
  to be considered "stable"
* buggfix
  Contains the minor patch to reduce memory consumption. This wasn't
  accepted by Junio. This is to be considered "stable".
* push_limits
  Contains all commits for the git push limitation patch series. This i=
s
  subject to unstable updates.
* move_gitdir
  Contains all commits for the move git-dir patch-series. This is subje=
ct
  to unstable updates.

Links
-----
[1] My previous update
http://article.gmane.org/gmane.comp.version-control.git/173095/match=3D=
iveqy

[2] submodule update continue patch.
http://thread.gmane.org/gmane.comp.version-control.git/175500/focus=3D1=
75725

[3] Use correct value when hinting strbuf_read()
http://article.gmane.org/gmane.comp.version-control.git/175844/match=3D=
iveqy

[4] push checks for unpushed remotes in submodules
http://thread.gmane.org/gmane.comp.version-control.git/176328/focus=3D1=
76327

[5] Github-page
https://github.com/iveqy/git
--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com

From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: git pull not ignoring the file which has been sent to the temporary ignore list
Date: Sat, 24 Jan 2015 00:57:30 +0630
Organization: CognitiveClouds
Message-ID: <3278910.5D06XWKxyS@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 20:29:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEjuy-0000Le-Re
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 20:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbbAWT3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 14:29:17 -0500
Received: from nm1-vm10.bullet.mail.sg3.yahoo.com ([106.10.148.97]:60559 "EHLO
	nm1-vm10.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751403AbbAWT3P (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jan 2015 14:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1422041353; bh=HJXH/Q3zN95dl8Jv14Vkb1fqeI/WFmHzK4MPsjkhsBk=; h=From:To:Subject:Date:From:Subject; b=BGVRArER2RWBiXeQIh8JWsX3RQiFlQUo/xadBu64Un7KIM1LsMD/fppcrQ/GNDDocSvPVjQOGZJv+Re7S/D2lxcZejHYEP7SBwdijs99a1rD1Ocyi57xXLn62MqCk0wCVRMjyShBueY58a50DGUv8P7+BhcxF4CZQBH91TpgWJQUYmHO0sq73By2inyli5UtQXx9Sjc0HHMWEuKdxJ+KyRBliUcN8nK2Li6HXyhrK5oTKRhLmPQV6dShEGDDLIEz7s60erUB8SqJ8SJr4YhpsggbvvSeVIAEoaCM34M/+g7LtrFW49PSpZsJRkNZq06BgdH1jAmtQThUhHPzHpYHQQ==
Received: from [106.10.166.116] by nm1.bullet.mail.sg3.yahoo.com with NNFMP; 23 Jan 2015 19:29:13 -0000
Received: from [106.10.167.177] by tm5.bullet.mail.sg3.yahoo.com with NNFMP; 23 Jan 2015 19:29:13 -0000
Received: from [127.0.0.1] by smtp150.mail.sg3.yahoo.com with NNFMP; 23 Jan 2015 19:29:13 -0000
X-Yahoo-Newman-Id: 698705.43132.bm@smtp150.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: pNuMHwAVM1ln0lhkITCHrSoWFnN1ArIqVOZqxAt3ApeC0KC
 k0HnR7.5VhtQRTuhv4MqbPlqghvsj.fBBVaWVcpSnfbSxJl8P7AwkECKTmy5
 jXdOgVeeHk5rF75X5avVX2._HpgIkVkxNpiwOZhu1Ec0dpfTIiGdUm6IZfDq
 f8Lmshp0MnUA5zzmq4nqi.KBcnrh_MhLMKv3sAq5cBa1FlyhTbPDUnTF1h7F
 GzAPh5i83v9wjOTzPfquIaderEokxrHGCikUXV.MvrhShtTXcfFHoBr.kSp.
 U9q0kS2P1b3BEwCS2SRPmj33ihJ8JtMQmugByp8jAmIiMi0Y1XxzpT.nhKxn
 W9L7gMNiztpx95fb910C7Mch43c_mB18ef.ZECdoEb1cMbAKQRA3NyYIjuYv
 obec.O8ok_K2TvWhvdxlcrm55rcWwOQxBZ2.ixtmZYlxcWt1LUnbWTp.6tR9
 5qmE.Lw_OPFV3sApTeFXUibjS.DMlO27b9KZI4oRZCaTrRNQh1uA0W0rcWO3
 WQ7XDO5iMm5i.0WkkYVF0SbcosBZkpAak6LSdQaQT35fLbcb5AI5V7qRhc44
 P0Id3U9O_ogJIo0EDpta1W5bUQHhyg6mSZF5I9Ty_xW4uSL.QFQwRXyLq0fP
 rw9J3blY9p3watL8-
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
User-Agent: KMail/4.11.5 (Linux/3.11.10-25-default; KDE/4.11.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262948>

Hi,

I asked git not to track any changes to the file .gitignore. To do so I did use the command - git update-index --assume-unchanged .gitignore.

[arup@sztukajedzenia]$ git status
# On branch MajorUpgrade
# Your branch is behind 'origin/MajorUpgrade' by 4 commits, and can be fast-forwarded.
#   (use "git pull" to update your local branch)
#
nothing to commit, working directory clean
[arup@sztukajedzenia]$ git pull origin MajorUpgrade
From rubyxcube.co.uk:sztuka-jedzenia/sztukajedzenia
 * branch            MajorUpgrade -> FETCH_HEAD
Updating 59a1c07..d7b9cd3
error: Your local changes to the following files would be overwritten by merge:
        .gitignore
Please, commit your changes or stash them before you can merge.
Aborting
[arup@sztukajedzenia]$

But you can see above, while I am taking `pull`, it is considering the file .gitignore. How should I tell `git pull` also not to consider the change the file, and skip it or something else ?

-- 
================
Regards,
Arup Rakshit
================
Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.

--Brian Kernighan

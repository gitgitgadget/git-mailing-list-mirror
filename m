From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: untracked file deleted from the master branch, when checked out to it from a local branch
Date: Tue, 20 May 2014 22:08:42 +0630
Organization: CognitiveClouds
Message-ID: <2525467.KRXv8a3gWS@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 18:38:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmn3b-0008LQ-5w
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 18:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbaETQiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 12:38:23 -0400
Received: from nm35-vm7.bullet.mail.sg3.yahoo.com ([106.10.151.62]:34071 "EHLO
	nm35-vm7.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751790AbaETQiW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2014 12:38:22 -0400
Received: from [106.10.166.123] by nm35.bullet.mail.sg3.yahoo.com with NNFMP; 20 May 2014 16:38:20 -0000
Received: from [106.10.167.146] by tm12.bullet.mail.sg3.yahoo.com with NNFMP; 20 May 2014 16:38:06 -0000
Received: from [127.0.0.1] by smtp119.mail.sg3.yahoo.com with NNFMP; 20 May 2014 16:38:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1400603900; bh=g0KzeI3e96dnIx3ZDurqxzdjUIMIqaEL6Q1Xjc1d9zw=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:MIME-Version:Content-Transfer-Encoding:Content-Type; b=JHzgjrINUN5OsV9pyNmePZCc8XO4E0+zQsri3W02/vCuC7iMC9PZAjiKiO817vsnb0SVEGXhQ9u4tZCXy3S5tn5A37ESg2O9Jfj3aISDwsejZ3IslwSpKkVyLqUbCXVT/SuI+HvcV67N3YrJP8d13/vTc+wX//UhRCW6wilAkHQ=
X-Yahoo-Newman-Id: 355099.4200.bm@smtp119.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: ePv5DVsVM1l5VIo0sZnx1z7wZ0Hnb3PXD147Kd5soOkml4Z
 05LM95fpJsaS6xv7ni4s68z1iPFGWxAQDHRHJH9dKSkECA3UnwYYwGF2O1T6
 bfrhnJm90XzN5qCnRqfntUIm.w48eZR4S9FgihxUGI28Q9I_Sf06h3D0lbLY
 tGic42h6bj6CPNwUF1xB5jLBCe6XivgqCkHxGW9CcC8Y_Mn654OzWVhKiWQf
 KeaS_bApx4pBifKFT9L12sAZjmXyGErWUuEtIhSfUsgbroN6su.O90CdYIIC
 M940retGM6tz_P21tTHlDYhTsDbAYDJZ997ULmKy6Q0koDPyLYYIitd0xBKN
 HmSROBRVJzFJI1hC_VIaT4wTei0IQk2pQhurfRaB6p4idyq48SZcqPG5NU4z
 gIKzDvyfsb9H3SabSJShvJ8aa108iLHlQiu2O6dYk76ymB3ytkagXyP.HPEN
 EITQZufCkmCwmAS8px7RXkVaJZ4XIhUByhuhCPNzjdd04j5_tHEwg8cvFAff
 BMUDX7Zxim6_gcT1X.VGNy0QLmTe9LcNClwuCZOGKpvcqXF6UZDDyrSQf0ta
 kUKOxrhb47lpQ37RPZGA6rnhIwAQn8YS_6QwOaZKCLX7gXuxZIyt1wWVxuVE
 yf_EjgF4wJxs_sA--
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@117.254.107.189 with plain [106.10.150.171])
        by smtp119.mail.sg3.yahoo.com with SMTP; 20 May 2014 09:38:20 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-7-default; KDE/4.11.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249697>

I was following some tutorial (http://gitref.org/branching/#merge) - and doing 
it in my console :

Arup-iMac:arup_git shreyas$ git status
# On branch master
nothing to commit, working directory clean
Arup-iMac:arup_git shreyas$ touch test.rb
Arup-iMac:arup_git shreyas$ ls
git_1.txttest.rb
Arup-iMac:arup_git shreyas$ cat test.rb
Arup-iMac:arup_git shreyas$ vi test.rb
Arup-iMac:arup_git shreyas$ cat test.rb
class Foo
  def self.bar
    12
  end
end

Foo.bar
***********HERE I switched to a NEW Branch****************
Arup-iMac:arup_git shreyas$ git checkout -b change_class
Switched to a new branch 'change_class'
Arup-iMac:arup_git shreyas$ ls
git_1.txttest.rb
Arup-iMac:arup_git shreyas$ vi test.rb
Arup-iMac:arup_git shreyas$ head -1 test.rb
class Fooo
Arup-iMac:arup_git shreyas$ head -2 test.rb
class Fooo
  def self.bar
Arup-iMac:arup_git shreyas$ git commit -am 'changed the class name'
# On branch change_class
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#test.rb
nothing added to commit but untracked files present (use "git add" to track)
Arup-iMac:arup_git shreyas$ git add test.rb
Arup-iMac:arup_git shreyas$ git commit -am 'changed the class name'
[change_class 2d40033] changed the class name
 1 file changed, 7 insertions(+)
 create mode 100644 test.rb
Arup-iMac:arup_git shreyas$ cat test.rb
class Fooo
  def self.bar
    12
  end
end

Fooo.bar
Arup-iMac:arup_git shreyas$ git checkout master
Switched to branch 'master'
Arup-iMac:arup_git shreyas$ git mv test.rb ruby.rb
fatal: bad source, source=test.rb, destination=ruby.rb
Arup-iMac:arup_git shreyas$ git mv -h
usage: git mv [options] <source>... <destination>

    -v, --verbose         be verbose
    -n, --dry-run         dry run
    -f, --force           force move/rename even if target exists
    -k                    skip move/rename errors
|--------------------------------------------------------------------------------------------------------------|
********FROM MASTER BRACH WHY THE FILE test.rb DELETED?***********
Arup-iMac:arup_git shreyas$ ls
git_1.txt
Arup-iMac:arup_git shreyas$ 

-- 
===============
Regards,
Arup Rakshit

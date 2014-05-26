From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Can we stage all files using "git add" command, except some specific files ?
Date: Tue, 27 May 2014 00:33:08 +0630
Organization: CognitiveClouds
Message-ID: <8392138.j8Dle5WGbS@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 21:03:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp0B6-0006xP-Ck
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 21:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbaEZTDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 15:03:15 -0400
Received: from nm32-vm2.bullet.mail.sg3.yahoo.com ([106.10.151.209]:26824 "EHLO
	nm32-vm2.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751787AbaEZTC6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 May 2014 15:02:58 -0400
Received: from [106.10.166.62] by nm32.bullet.mail.sg3.yahoo.com with NNFMP; 26 May 2014 19:02:57 -0000
Received: from [106.10.167.170] by tm19.bullet.mail.sg3.yahoo.com with NNFMP; 26 May 2014 19:02:57 -0000
Received: from [127.0.0.1] by smtp143.mail.sg3.yahoo.com with NNFMP; 26 May 2014 19:02:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1401130976; bh=xEGvAqIAGbfBAxj7o0kuDfSWMeArERBSODjhJp4eOr0=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:MIME-Version:Content-Transfer-Encoding:Content-Type; b=JilrKklq0y3UreoUEj+xQGBTRB2613Af9Hvr0m0e61mnY/jeya5SRSgC0V+kfsVkm6k87xbHOpGmiwmuOGt64AaOA1Ef1KnI/TniUPTOyo74iTOkTtdIvAT5RcqqvhOCDvw237tb+u81fku8BfAfSdE5HKDPgqfdFkXbb96xjZ4=
X-Yahoo-Newman-Id: 982385.9343.bm@smtp143.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: RycH5d8VM1ndlsr98egpD_izkCJU0CMcr1LPrFRZ02tONBW
 kORrgkfwrTFerUVcozOzdiDpXRGt37K1J1bYht3rTWR3LlyFaYBt9KIacd5V
 V8bfopfCjdu8mXauKEuGjvfHEbULZKV2tlk6c2guzcMhKKE.YnI_R2UzBsip
 1RSN3.aDrvhiTA25qQdlVQj1JaPATc.38LF.zWaysZH6rfmEUnC7iDKSDhvj
 PaWDfCX1t7yH4dlLsQCPE489LbjsuIYggr_LBDvnzUmEVqXvOX0CThwGHZiK
 IDzxK.EicNMjWEarUMJvuFx1Bhsf_waDNjgIytPMxu.rUlgReiH.tqokG9yt
 H2co1nvczTZMc1vxEss1Fdv73ey0fPOV_lL01BTpn3kNG209uaWzRU3t9KRd
 vnoNMQIF9L13.T1bu0pzu5iCs4eoz54rdmfVMe8M7SU4EJnJNsgQP41V46ut
 _0XrS7fcPps8TxU04IyKfndjQK8lrBsQxwpDgvqahxVjKobY3jG79m__556f
 1J2rcjK5sQSlydMZOgaq6IXywVm3QQ7UPkwE3pttYwWQd5F_t0vdPhQfAy4G
 GHuv4Fd5mWbO6St5N7LYg2nyK3FbL0ikYLJd_cyanLCG_WV35tg6dVJlf
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@117.254.111.198 with plain [106.10.150.171])
        by smtp143.mail.sg3.yahoo.com with SMTP; 26 May 2014 12:02:56 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-11-default; KDE/4.11.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250117>

Hi,

Look below :

arup@linux-wzza:~/Rails/app> git status
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       Gemfile
#       Gemfile.lock
#       README.rdoc
#       Rakefile
#       app/
#       bin/
#       config.ru
#       config/
#       db/
#       lib/
#       log/
#       public/
#       test/
#       vendor/
arup@linux-wzza:~/Rails/app> git add -A
arup@linux-wzza:~/Rails/app> git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file:   .gitignore
#       new file:   Gemfile
#       new file:   Gemfile.lock
#       new file:   README.rdoc
#       new file:   Rakefile
#       new file:   app/assets/images/.keep
#       new file:   app/assets/javascripts/application.js
#       new file:   app/assets/javascripts/upload.js.coffee
#       new file:   app/assets/stylesheets/application.css
#       new file:   app/assets/stylesheets/upload.css.scss
#       new file:   app/controllers/application_controller.rb
#       new file:   app/controllers/concerns/.keep
#       new file:   app/controllers/upload_controller.rb
#       new file:   app/helpers/application_helper.rb
#       new file:   app/helpers/upload_helper.rb
#       new file:   app/mailers/.keep
#       new file:   app/models/.keep
#       new file:   app/models/concerns/.keep
#       new file:   app/models/picture.rb
#       new file:   app/views/layouts/application.html.erb
#       new file:   app/views/upload/get.html.erb
#       new file:   app/views/upload/show.html.erb
#       new file:   bin/bundle
#       new file:   bin/rails
#       new file:   bin/rake
#       new file:   bin/spring
#       new file:   config.ru
#       new file:   config/application.rb
#.......................
#...........................
arup@linux-wzza:~/Rails/app> git rm --cached .gitignore
rm '.gitignore'
arup@linux-wzza:~/Rails/app> git rm --cached bin/bundle
rm 'bin/bundle'


Now, you can see, I have staged all the files first using *git add -A*, then 
_unstaging_ those I don't want to _stage_ right now. Now can this be done, in 
the *staging* time ? I mean any way to tell `git add` command, that add all 
the files from the current directory, except some specific files. What I want 
this is, some times I have at least 30 files, whereas I want to _stage_ say, 20 
files, not the rest 10. During _staging_ can I tell *git add* the same. I used 
*git add -h*, which didn't show me any such hints about my need.


-- 
===============
Regards,
Arup Rakshit

From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2008 partial summary
Date: Wed, 3 Sep 2008 16:07:19 +0200
Message-ID: <200809031607.19722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 16:09:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kat2R-00054F-CE
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 16:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbYICOHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 10:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbYICOHZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 10:07:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:57036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbYICOHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 10:07:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so161333fgg.17
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=WVre9kX9Cyvb8e3u4G4Qc3QzYtFVIUTcH74vJFASIuo=;
        b=AF+e7leyIuzzENPdCvJ5qxDlY7ITU+HGhM1eIcDRzmlt865pbbJzGlyi02e6tW6Ss0
         h6N3jW3fZXNm0nYh1CM5uqSro4iPoun091pKDstUbLJenF0OIEw4pU1ek51Fe9ykgFVl
         19WG5m6tzYltu94VyOVLSzTnZuce47Dh1sGks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=o5vCjbsT3PR7RvvLZadYXc6OJyhSPQ8NA78FwMXPGfjHGGwYqwRN7TbRrKA1IqP6J8
         NDHFSHrYZfCBZtPVzSysw0c6CWZ6JFtDz1ARU1Kl1iECXE3HRg6Djv1xkR80Qa7YwZFa
         ogdyl0HZQHD9AdhD30Yn3VlAkSid2/GHEvN6s=
Received: by 10.86.60.14 with SMTP id i14mr6669143fga.75.1220450841841;
        Wed, 03 Sep 2008 07:07:21 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.253.191])
        by mx.google.com with ESMTPS id 12sm8416392fgg.0.2008.09.03.07.07.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 07:07:21 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94797>

This is partial summary of Git User's Survey 2008 after more that 1000 
(yes, that is more than _thousands_ responses) just after the 3 days
of running the survey.  It is based on "Analysis" page for this survey:
  http://www.survs.com/shareResults?survey=M3PIVU72&rndm=OKJQ45LAG8

We have around 1045 individual responses (including 20 responses in the 
'testing' channel), as compared to 683 individual responses for 2007 
survey, and (I think) 115 answers (Base = 115) for 2006 survey. 
That is quite a lot, especially after so short time since staring the 
survey.


03. With which programming languages are you proficient?

Around 939 people answered this question.  C is most popular with 59%;
Ruby and surprisingly a bit shell script programming have around second
place, with about 52-53%.  More people are proficient with Python than 
in Perl by about 1/3-1/4.  Very few people (25 responses, around 3%)
feel proficient in Tcl/Tk, which means shallow pool of possible git-gui
and gitk contributors.  Java is quite popular with around 42%, which
gives hope in continued JGit/EGit development.

And finally 12 responses (around 1%) of "I am not a programmer".  That's 
nice.  That's very nice.


16. I use Git for (check all that apply):

Among more interesting replies in the "Other (please specify)" section
were:
 * tracking 3rd party projects, especially with git-svn
   (which probably should be one of possible responses)
 * versioned filesystem
 * distributing teaching examples live
   (which admittedly is form of "sharing data or sync" response)
 * real-time collaborative editing (conspire)
 * as a sandbox, to debug changes performed by binary installers
 * storing automated build test results

Work projects and unpaid projects constitute almost the same amount.


17. How do you obtain Git?

Most people use binary packages (59%), with source packages and tarballs
second (28%) and pull from main repository third (22%).

Note that in this version of survey this question is multiple choice 
(multiple answers), as opposed to single choice in earlier surveys.


18. What operating system do you use Git on?

Linux, then MacOS X, then MS Windows.  In "Other, please specify"
there are two responses of 'iPhone OS'... can one use git on iPhone?


21. Which porcelains / interfaces / implementations do you use?

Most people (99%, 862/869) use core-git in some form, perhaps in 
addition to some other interface.  Cogito no longer has large
amount of users: only 5; it looks like people noticed finally that
is deprecated and not maintained any longer.  Among patch management 
interfaces StGIT dominates with 24 (3% share), then newcomer TopGit 
with 13, and last Guilt with 6; but the last part can be caused by 
people not noticing it among answers, as I saw a few of "Guilt"/"guilt"
among free-form "Other (please specify)".  Patchy GIT (pg), long
deprecated, has happily no users.

"My own scrips" with 117 / 13% responses shows very well either good
Git scriptability, or lack of good UI ;-).  I guess it is the former.

"Other" responses include Grit, which I forgot is at least partially 
(re)implementation of Git, git-wtf and gc-utils... but some of 'other' 
responses include tools which are (I think) neither porcelain, like 
gitosis or gibak, or git-cola, or magit, but more of a GUI.

People who do not use "git (core)" implementation use StGIT, own 
scripts, or Easy Git.


22. Which git GUI (commit tool or history viewer, or both) do you use?

I think it should have been stated more clearly that this list includes 
also integration with IDE, RAD and editors.  Here among tools which I 
forgot to add are magit which is another Emacs interface, and Textmate 
bundle.

Hmmm... only 75% people use command line; it means that graphical tools 
improved.  Tools which are distributed along git, namely Tcl/Tk based 
git-gui and gitk dominates.  Bit suprising for me is third place (if we 
exclude CLI) of GitNub, and 6% of tig users.  QGit is fourth with 11%;
Giggle has more users (26) than GitView (4).  Quite new GitX has 
surprisingly as much as 16 (2%) users. 

Among 'others' there is nice and a bit curious "testing the integration 
in upcoming KDevelop 4" (which was GSoC 2008 project for KDE).


23. Which git web interface do you use for your projects/have installed?

It was meant to be about web interface _you_ run, and not only use as a 
part of third party git hosting site you use.  It is a bit strange that 
people put GitHub there, unless GitHub source code was made available, 
or is it possible to deploy/install clone of GitHub yourself.

As before gitweb dominates with 80% of share, then Gitorious with 14% 
and next cgit with 11% (30 responses).  

Among 'others' there are Trac (I guess Trac plugin), Redmine 
(I guess also plugin), ikiwiki and "my own, not public yet".



50. Would commercial (paid) Git support from a support vendor be of 
interest to you/your organization?

746 individual responses, 9% yes (66 replies), 69% no, 22% not 
applicable.


To be continued...
-- 
Jakub Narebski
Poland

From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2011 very short summary
Date: Mon, 10 Oct 2011 17:21:51 +0200
Message-ID: <201110101721.51830.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 17:22:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDHg9-0003P0-Aw
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 17:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab1JJPWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 11:22:03 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40803 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab1JJPWA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2011 11:22:00 -0400
Received: by eye27 with SMTP id 27so1474378eye.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=gHacpRz31XdEO2B6W9IUPkETszm63vB4CCMAiKozrvY=;
        b=w1vHjfFk1cKyWOE75/hTB9s2xCdFaAjVuzK4tD1jbAGhdJD84cOJqFRDqDGhHY0vVD
         oq0QkqRHUP/7zuBukiMzWQKJMC98OINrHhvVJznavaDg+4kiQrkDYh0wRY/9Rd9XR/BN
         yhpwnQYfn1uOvA7Jy9z5Lp39P1OrNzc3sbzIU=
Received: by 10.223.62.19 with SMTP id v19mr32759126fah.27.1318260119609;
        Mon, 10 Oct 2011 08:21:59 -0700 (PDT)
Received: from [192.168.1.13] (abvx204.neoplus.adsl.tpnet.pl. [83.8.221.204])
        by mx.google.com with ESMTPS id f25sm32147759faf.7.2011.10.10.08.21.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Oct 2011 08:21:58 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183242>

Unfortunately Git Wiki is still down.  As soon as possible after it is
up I'll upload results of "Git User's Survey 2011" at
   
  https://git.wiki.kernel.org/index.php/GitSurvey2011


Currently you can download 'Survey results Oct 03, 11.csv.gz', a
compressed CSV file with raw survey data (individual responses), and
'GitSurvey2011_questions.yml' YAML file with question structure from
my repository with script used to analyse survey results:

  https://github.com/jnareb/GitSurvey-scripts


You can also view the summary of "Git User's Survey 2011" and
analyse this survey using provided filters at Survs.com:

  https://www.survs.com/results/Q5CA9SKQ/P7DE07F0PL
  http://tinyurl.com/GitSurvey2011Analysis
 

..................................................................
Below there is very short summary of some of the results of
"Git User's Survey 2011"

Total responders: 11498 (7177 complete responses i.e. all sections answered,
and 4321 incomplete responses, which gives completion rate of 62%).


About you
^^^^^^^^^
Most responders are from USA among other countries (35%), followed by
Germany, UK, Canada and France (12% to 4%).  Most responders are from Europe
among other continents (48%), with North America second (40%).

Most responders are between 26 and 30 years old; most common age (mode)
is 27 years old.  Youngest user who answered this question is 11 years 
old (next oldest is 12 years old).

820 of Git developers (out of around 910 in all) answered this survey.
This is 9.1% of responders who answered question 'Does Git include
code or documentation by you? (Are you a Git developer?)'.


Getting started with Git
^^^^^^^^^^^^^^^^^^^^^^^^
Responders say that Git is reasonably easy to learn, and easy to 
reasonably easy to use; it is easier to use than to learn.

More than 90% use git version 1.7.x at least at one place.  There are 5 
unfortunate stragglers who use pre 1.3.x version.

Responders fall somewhere between 'everyday use' (36%) and 'can offer 
advice' (34%) proficiency.


How you use Git
^^^^^^^^^^^^^^^
Most people (74%) obtain/install Git at least at one place using ready 
binary packages.

GNU/Linux dominates among operating systems used (82%), then there is
MacOS X (50%), then MS Windows (where msysGit is 3 to 1 preferred to
Cygwin), with 39%.

Almost 10% of responders use JGit.

62% of responders use some kind of graphical history viewer, and 41%
use Git support integrated with editor/IDE.  Graphical diff and
graphical commit tool are used by around 31% of responders.

Most popular feature, by quite a large margin, is *stash*, with two 
thirds (69.7%) of responses. "git stash" first appeared in git version 
1.5.3, from September 2007.

Second most common used feature is "shell completion of commands", with 
half of responses (49.9%).

Then there are, with percentage of responses from 45% to 42%, in
descending order of responders: interactive rebase, aliases (git
aliases, shell aliases, one's own git scripts), and comitting with
dirty tree (keeping some changes uncommitted).

Least used, with only 0.5% of responses, is "git cvsserver" and
"replace mechanism (git replace)".

Most requested features, both with more of 32% responders, are better
support for big files / large media, and support for tracking empty
directories.


Interacting with other repositories
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The leader among git hosting sites is (like in previous years) GitHub
with 87% of responders (up from 77% in 2010 and 62% in 2009); "self
hosted" is second with 38% (down from 44% in 2010 and 57% in 2009),
followed by "company internal" with 31%.

The high position of GitHub migh be at least partially caused by the
fact that GitHub has good announcement system for new features, which
was used to announce "Git User's Survey 2011" to GitHub users.

Most responders do not use paid git hosting (64%); those that pay for
git hosting do it mainly for private repositories (35%).

>From those that self-host git repositories (2932 / 11498) more use
unmaintained(?) Gitosis (36%) than Gitolite (25%).

git:// protocol and SSH have the same popularity for fetching; both
around 76%.  Only 46% responders use HTTP for fetching (somewhere).
Deprecated rsync protocol is used only by 20 responders (0.3%).


Other version control systems
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The question about other version control systems was lacking the
"N/A (I use only Git)" answer; in fact presence or absence of N/A
answer is quite inconsistent in this year survey.

Most popular other version contsol systems used alongside or as an
alternative to Git are Subversion (81%), followed after a large gap by
Mercurial (31%).


What do you think of Git
^^^^^^^^^^^^^^^^^^^^^^^^
Most responders are "very happy" with Git, and this answer seems to be a 
center of responses.

User interface, documentation and tools need improvement; performance 
rather doesn't need to be improved; people mostly don't care about 
improving communities or localization (but please remember that this 
survey was in English, and announced on English-speaking sites / 
lists).


Documentation. Getting and giving help.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Most used way to request help about Git (help 'channel') is asking on
StackOverflow or other StackExchange site, with 36% of responders (!),
slightly higher than previous year winner of asking somebody better
versed in Git personally, with 32%.

Note that this year responses will require processing to be able to
compare with results from previous surveys, as in this survey we have
"N/A (didn't request help)" answer with 40% of responses.

On the other hand 72% of responders *gave* help via talk / private
explanation, i.e. answered questions about Git from colleaugue.
Around the same number (about 20%) didn't give help about Git as gave
help via email or instant messaging.  Note that only 14% of responders
gave help via StackOverflow or similar site.

-- 
Jakub Narebski
Poland

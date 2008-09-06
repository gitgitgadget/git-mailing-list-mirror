From: Jakub Narebski <jnareb@gmail.com>
Subject: Git User's Survey 2008 partial summary, part 4 - how do we use Git
Date: Sun, 7 Sep 2008 00:17:08 +0200
Message-ID: <200809070017.09463.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 00:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc66s-0001nA-So
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 00:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbYIFWRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 18:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYIFWRS
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 18:17:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:15592 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbYIFWRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 18:17:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1027069fgg.17
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2IgRhOE5YxzYTKNHqoqW/wRBvRok/1T2OR4s/dIOq9o=;
        b=amuwNvo6Ss+2h7Sihi9Te5xIldtqy/TtvEx9MxFILyCdP657r22JREBWSQPoKFMvqx
         4XQvnmKnhfajmrjRqlBIoeJvaiz32n6a9QmBpS3D/fY4LBJWprU/J/C/yeJuMVSHzSx5
         bAFlMRUMR4wCxpEcy7Y6i5KwMKnXK5CIDNiTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SvW7aZfw63EFAUePo0EnSh79pAxvTuo/X9CWYO015WPqY9YXPvakg7QZQsVCPRNAN9
         6kXsQzyISO6iFw86al2lvBXah/2uFPAie2vlbwYXOKYrajlntdKZ654FnQnqHEfWcl95
         lqv2mQf3iIcvJfFRKn1qLV8tvODwsYpR5sMyc=
Received: by 10.86.59.2 with SMTP id h2mr9979255fga.40.1220739435284;
        Sat, 06 Sep 2008 15:17:15 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.117])
        by mx.google.com with ESMTPS id d4sm3075096fga.5.2008.09.06.15.17.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Sep 2008 15:17:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200809031607.19722.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95098>

This is partial summary of Git User's Survey 2008 after more that 2000 
(yes, that is more than _two thousands_ responses) just after the 6 days
of running the survey.  It is based on "Analysis" page for this survey:
  http://www.survs.com/shareResults?survey=M3PIVU72&rndm=OKJQ45LAG8

Please think of ways to examine this data, and about conclusions that we 
can draw from those statistics.



27 & 28. How often do you use the following forms of git commands or
         extra git tools? (Matrix - One answer per row)
       + never / rarely / sometimes / often

First, even though those questions looks a bit terryfying on first
glance, with this large matrix of commands, most people (around 3/4)
filled those two questions: 1562 responses with 540 skipped for 27.,
and 1454 total and 648 skipped for its continuation, question 28.

This large matrix had the additional advantage of teaching newcomers
to git about some rarer or newer git commands or versions of git
commands.

Below there is very simple statistics based on individual columns,
without taking into consideration any correlation between columns, or
any relation. For example it doesn't take into account that for some
'often' is somene's else 'sometimes'.


Top 10 often used commands

===================================
Command + options      | often [%]
-----------------------------------
git push               | 72% (1120)
git add + git commit   | 65% (1012)
git commit -a          | 63%  (981)
git pull (no remote)   | 44%  (682)
git pull <remote>      | 37%  (578)
git commit <file>...   | 34%  (528)
git merge              | 31%  (482)
gitk                   | 28%  (404)
git rebase             | 25%  (365)
git stash              | 22%  (320)
...................................
git remote update      |   6%  (92)

Analysis: strangely "git add + git commit" is slightly more used than
"git commit -a"; I would suspect that "git commit -a" would dominate a
bit over other forms of committing.  What is for me more suprising is
that "git commit <file>..." has such large presence in often used
commands; I would think that it should be mostly used as 'sometimes'
command.

Pity there was no "git pull . <branch>" to compare if people swith to
newer "git merge <branch>" for merging local branches.


Top 10 sometimes used commands

===================================
Command + options      | sometimes
-----------------------------------
git merge              | 28% (443)
git pull <remote>      | 27% (429)
git stash              | 26% (380)
git remote             | 26% (379)
git revert             | 24% (346)
git rebase             | 23% (332)
gitk                   | 23% (328)
git fetch [<options>]  | 21% (331)
git commit --amend     | 20% (314)
git commit <file>...   | 20% (311)

Analysis: "git commit --amend" and "git commit <file>" are here. That
is understandable, and for me expected.


Top 10 rarely used commands

===================================
Command + options      | rarely [%]
-----------------------------------
git revert             | 31% (454)
git pull <URL> <ref>   | 22% (348)
git blame              | 21% (328)
git fetch [<options>]  | 20% (313)
git rebase             | 20% (291)
git remote             | 20% (289)
git merge              | 18% (286)
git apply              | 18% (284)
git pull --rebase      | 18% (283)

Analysis: "git pull <URL> <ref>", direct pull without using
remote-tracking branches, is quite popular among rarely used
commands.  Strange that "git pull ---rebase" is among rarely
used; I would think it is question of workflow... but perhaps
rarely encountered workflow.

Notice that "git blame" is more 'rare' than gitk, which is in top 10
of both 'often' and 'sometimes' table. I guess that this is caused by
the fact that git has other, often better, ways to examine and browse
history.


Top 12 never used (or not well known) commands

==========================================================
Command + options       never    rarely  sometime   often
----------------------------------------------------------
git relink             1217-84%   37- 3%    6- 0%    1- 0%
git cvsserver          1255-80%   23- 1%    8- 1%    3- 0%
git imap-send          1245-80%   35- 2%    6- 0%    2- 0%
git cvsexportcommit    1227-79%   26- 2%   16- 1%   12- 1%
git citool             1191-76%   51- 3%   15- 1%   17- 1%
git bundle             1184-76%   80- 5%   22- 1%    8- 1%
git request-pull       1110-76%  105- 7%   32- 2%   16- 1%
git instaweb           1142-73%   97- 6%   31- 2%    8- 1%
git ... --dirstat      1141-73%   93- 6%   39- 2%    8- 1%
git am -i              1129-72%  130- 8%   48- 3%    8- 1%
git blame -L           1123-72%  103- 7%   50- 3%   11- 1%
git daemon (pushing)   1110-71%   99- 6%   38- 2%   36- 2%

It is sorted by percentage; note that commands from different
questions might have higher percentage even though lower number of
replies: it is caused by the fact that number of replies (non skipped
responses) is different.

Analysis: Nobody is I think suprised by the commands that appear in
this table...



29. Which of the following features do or did you use? 
30. Which features do you find unique and/or useful ones,
    compared to other systems (other SCMs)?
    (Choice - Multiple answers)

There were 1387 responses / 715 skipped for question 29., and
there were 1190 responses / 912 skipped for question 30.

These two questions were a bit related, but first deals with the
features one uses (even if they are not unique to Git, or very
interesting), while second deals with which features one think to be
useful (even if one doesn't use them).

The 'use' columns conatin percentage of replies for question 29.,
while 'think' column is about question 30.

==================================================
Feature description                     use  think
--------------------------------------------------
gitk or other history viewer            72%   ---
stash                                   56%   63%
the index                               ---   44%
shell completion of commands            42%   ---
add --interactive
  or other partial commit helper        35%   38%
git-gui or other commit tool            31%   ---
interactive rebase                      31%   39%
submodules (subprojects)                30%   25%
bisect                                  28%   37%
my own scripts / scriptability          25%   28%
git-aware shell prompt                  23%   ---
integration with IDE/editor             20%   ---
working with dirty tree                 18%   14%
mergetool                               17%   13%
reflog                                  16%   16%
detaching HEAD                          14%    9%
non-default hooks / hooks system        11%   19%
shallow clone                            9%    6%
eol conversion (crlf)                    8%    6%
separate worktree                        7%   11%
git-filter-branch                        7%    7%
alternates mechanism                     6%    7%
gitattributes                            6%    4%
patch management interface               5%   ---
git bundle (off-line transport)          5%   10%
multiple worktrees (git-new-worktree)    3%   ---
commit templates                         2%    3%

About items which are missing in one of columns: either it is a broad
concept so it is hard to say that one can "use" such feature, or
feature is not unique enough, or is not part of git... or I forgot to
add it to second part.

Analysis: most popular is using history viewer (such as gitk, qgit,
giggle, GitNub, git-cola, etc.); stash even though it is quite new
feature also is very popular.  For me a bit strange is that partial
commits has more users than graphical commit tools like
git-gui/git-citool.  Most (well, 44%) think that the index is unique
and/or useful feature.  Biggest difference in number of replies
between 29. and 30. question belongs, from what I see, to bisect.


31. If you use some important Git features not mentioned above, what
    are those? (Open ended text - Essay)

Total respondents: 115, skipped this question: 1987.

This I guess mean that we were exhaustive in our list of features,
as it doesn't seem to be many omissions...

-- 
Jakub Narebski
Poland

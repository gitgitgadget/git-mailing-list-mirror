From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: [GSOC/RFC] GSoC Proposal Draft | Git Beginner
Date: Sun, 20 Mar 2016 22:04:19 +0530
Message-ID: <56EED10B.4010604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, philipoakley@iee.org,
	Kevin Daudt <me@ikke.info>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jacob Keller <jacob.keller@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 17:36:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahgKu-0007VV-2h
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 17:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbcCTQe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 12:34:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35447 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbcCTQeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 12:34:24 -0400
Received: by mail-pf0-f195.google.com with SMTP id u190so26020459pfb.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 09:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=VPxzOHIDxzXEEu/Lk9iQQlj5B88jaYcb6GMGlfwkok0=;
        b=I62LwU5j22bLQxH02UEcy6DbSTnJaBDnwkcNbLkVITiudZd3XdjF3xeiuc14E6ErCK
         GYIvnSEcDnJxIJ5rx0GNfuXcLZ1/jy5u8ZaiE4Bdh/xCEe1sZvl0QyrzpGvceXyPOZvW
         Jvrj5X6wucWIVgKyqlsw9VpyewLDYSfMO7god54ZSEG8IAHQFE3vPTGVUTlUNQGmHf59
         2pMovJWw6AetTI6Zy1Uo98iFZCIUeY6oTZaR2peFQr3uSSoSFuJCvYTMsXYyYexhJf1F
         2FduOOW5HAiMKnbgLpScdgRRRk1bEMRZJTLoabPjEnrgFN/agFW96xJeCZZtoMsKeLYD
         98iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=VPxzOHIDxzXEEu/Lk9iQQlj5B88jaYcb6GMGlfwkok0=;
        b=L2MiHHSogoE7qQFlquPt7XOSkFaIDXc3jOPxpNIVJLOeEzY1JVqFTQHengFsYghBt+
         lHIh4Szv85ui+f4HKqZxSlhL8U3hmAqJHqZOOw4t9fuRrozj8n5s/0GpLTbz7cTf0QNO
         g/6rN10EjcDy9Yy6kXPL0IVfUU+WON2s0tUUP98jTicTcxpsu3bWYJgJ92tzkCK/UR7H
         KfSiza6SOlFg53u7fSslBvqkU4bEQHFS4SWRO6yDypU2lMIBLYIi5ZrHBcVXTo7vwSPY
         BgNg1X5P8Uj5jxJgIQ4zNBqgoIMDKnbGrERQ2FdTKmqJGvBHHgsh3q11mLisXLFqJEZr
         NEBA==
X-Gm-Message-State: AD7BkJLdzTcoar9zLI1CUE+gmtLyx2HvS2KqAbXycvggQ1TWgjtd5kqdhzWPDK3FQwXgvg==
X-Received: by 10.98.72.16 with SMTP id v16mr1569896pfa.5.1458491663999;
        Sun, 20 Mar 2016 09:34:23 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.159.75])
        by smtp.gmail.com with ESMTPSA id y7sm28456066pfa.82.2016.03.20.09.34.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2016 09:34:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289365>

Hi,

I have drafted my proposal for the project 'Git Beginner', and would
like to request your suggestions on improving it. I'm also reading up the Git 
documentation and the Git ProBook (again) to make notes for the beginner
documentation. Would be great to hear your comments on it.

Thanks and regards,
Sidhant Sharma

---

Implement a beginner mode for Git.

Abstract

Git is a very powerful version control system, with an array of features
that lend the user with great capabilities. But it often so happens that some
beginners are overwhelmed by its complexity and are unable to fully understand
and thus, utilize Git. Moreover, often beginners do not fully understand
the command they are using and end up making destructive (and occasionally,
irreversible) changes to the repository.

The beginner mode will assist such  users in using Git by warning them
before making possibly destructive changes. It will also display tips and
short snippets of documentation for better understanding the Git model.

About Me

Name : Sidhant Sharma
Email [1] : Sidhant.Sharma1208 <at> gmail.com
Email [2] : Tigerkid001 <at>  gmail.com
College : Delhi Technological University
Studying : Software Engineering
IRC : tk001 (or _tk_)
Phone : 91-9990-606-081
Country : India
Interests : Computers, Books, Photography
Github : Tigerkid001
LinkedIn : https://in.linkedin.com/in/sidhantsharma12

Technical Experience

Authored several Mozilla Firefox and Google Chrome extensions.
Developed a robust Plugin framework for Android for a startup. Learning Linux
kernel programming via the Eudyptula Challenge.
Developed natural language processor for sarcasm detection in tweets.
Developed gesture detection module as a college minor project.
Active Firefox Add-ons Editor at AMO (addons <dot> mozilla <dot> org).
Currently working on a restaurant image classification project as second college
minor project.



Why I chose Git

I have been using Git for about two years now, and it has become an
indispensable daily-use tool for me. Getting a chance to participate in GSoC
for the first time under Git is very exciting. It will give me an opportunity
to intimately know the system and a chance to help in making it better and more
powerful.

Proposal

Ideas Page: Git Beginner

The following tasks summarize the project:

Implement a wrapper around Git

A wrapper is to be implemented around (currently called 'ggit'), which will
provide the following user interface:
`ggit <git-command> <options>`
For example, `ggit add --all`
The wrapper will assess the arguments passed to it, and if they are detected to
be safe, it will simply pass them through to 'git'.

Warning for potentially destructive commands

For every command that is entered, the wrapper will assess the subcommand and
its options. In that, it will first check if the subcommand (eg. add,
commit, rebase) is present in a list of predefined 'potentially destructive'
commands. This can be done by searching through a radix tree for the subcommand.
If found, then the arguments to the subcommand will be checked for specific
flags. The graylisted flags for the destructive commands will be stored as an
array of regular expressions, and the current command's arguments will be
checked against them. If matches are found, a warning is displayed. 'ggit'
for the warning would be
"You are about to do X, which will permanently destroy Y. Are you sure you wish
to continue? [Y/n] "
If the user enters Y[es], the command will be executed as is (by passing it
unaltered to git). In the case of Y[es], 'ggit' will also give tips for undoing
the changes made by this command (by referring the user to correct commands and
reflog),  if the command can be undone. In case the command cannot be undone,
'ggit' will display an additional line in the warning like
"The changes made by this command cannot be undone. Please proceed cautiously".
In the case of n[o], 'ggit' will exit without executing the command.
Usage tips and documentation

The wrapper will also be responsible for showing a short description of every
command that is entered through 'ggit'. This shall be done for every command
unconditionally. The description will be derived from the actual documentation,
but  will primarily aim to help the beginner understand the Git workflow and the
Git model.

Timeline

Community Bonding Period

Week 1 : Discuss the flow of course with the mentor. Discuss adequate data
structures and search techniques to be used.

Week 2-3 : Discuss over an extensive list of commands that should be classified
as destructive. Discuss appropriate short descriptions for commands.

Week 4 : Discuss code structure, tests, optimization for least overhead and
other details.

Coding Starts

Week 1-2 : Submit code for a basic wrapper that will warn for a subset of the
potentially destructive command, and continue if the command is safe.
and this is stored as per to provide backward compatibility.

Week 3-6 : Extend the wrapper to warn for all commands in the list, along with
proper instructions for undoing them.

Mid Term Evaluation

Week 7-10 : Add beginner-friendly documentation snippets to various git commands.

Week 10-12 : Write tests, evaluate performance.

Week 13 : Final cleanup, final touches suggested by mentors and community.

Pens Down Date
Submission of Code to GSOC


Post GSoC 2016
After GSoC 2016 is over, I believe there will stilll be further work required
for improving and perfecting the 'ggit' interface before it can be merged with
the main distribution. I would like to continue my work on this project and
contribute to Git in general as well.

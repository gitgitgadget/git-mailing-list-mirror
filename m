From: "Justin Leung" <jleung@redback.com>
Subject: Verilog/ASIC development support is insufficient in git , help!
Date: Sat, 10 May 2008 22:08:43 -0700
Message-ID: <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <justin0927@hotmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 11 07:10:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv3oy-0003dQ-1l
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 07:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbYEKFIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 01:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbYEKFIu
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 01:08:50 -0400
Received: from prattle.redback.com ([155.53.12.9]:37507 "EHLO
	prattle.redback.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbYEKFIu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 01:08:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by prattle.redback.com (Postfix) with ESMTP id AD88357C7E5;
	Sat, 10 May 2008 22:08:49 -0700 (PDT)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14696-07; Sat, 10 May 2008 22:08:49 -0700 (PDT)
Received: from justinuTop (unknown [172.31.253.90])
	by prattle.redback.com (Postfix) with ESMTP id 68E8D57C7E4;
	Sat, 10 May 2008 22:08:49 -0700 (PDT)
In-Reply-To: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6001.18000
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6001.18000
X-Virus-Scanned: by amavisd-new at redback.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81732>

Hi all,

* This email probably represent the whole hardware ASIC community about git 
*

I'm evaluating Git as the replacement of CVS for the ASIC group in my 
company,
but things are moving along very bumpy.

I (and many others doing the evaluation) love the tool dearly; we love the 
local repository and inter-db sync'ing .
I see a lot of potential in productivity and changes in work model that 
helps efficiency in ASIC dev.

BUT, my managers, some veterans, and directors are EXTREMELY concerned about 
the ease-of-use..
so much that they are going to pick SVN !  uh-oh....i m serious =(

Alot of people argued, why not SVN ? it's CVS++ and it's ease of use not a 
problem when comparing to Git.

here are the things not fitting right in ASIC dev:

- no incremental revision numbers (they are so scared of the 40hex SHA1)

- Inability to reference without SHA1, they want simple numbering (ie, 
version 100, 120, 120.1, 130.4.5)

- Inability to refer to a file by a simple number
(the backend guys will be confused by SHA1; they can't work with anything 
more than 4-5 digits)

- Complexity of commands (although we can have warpper, but real git 
commands for non-sw guys is not going to happen)

Most hardware chip designers were using CVS since their first job.
It suited the purpose very well.

Most RTL design veterans only use less then 5-6 cvs commands in their whole 
life (LOL, i m serious) :

$ cvs checkout
$ cvs update
$ cvs log
$ cvs diff (tkdiff)
$ cvs status
$ cvs commit

We don't use branches.
Our model is strict forward with a centralized, one main branch model to 
avoid mistakes .
We see branches as evil ; some merges in Verilog codes means another 10+ 
hours of simulation and regression.

I'm a verification engineers for the hardware chips designers, there we use 
Vera and SystemVerilog which requires much in
depth use of SCM functions.  So, the choice of tools is much more important 
on our side (the designers only checkin and out, diff, and minimal merging)

I m frustrated about the situration, i truly want Git in ASIC world !!!
(yell out loud... no p4, no svn, no clearcase... or i rather keep cvs)

Is there a way to specify the use of a simple GIT model in config, or like, 
info/attribute,
such that (in git main repository model of course) :

(1) SHA1s are hidden, but replaced by simple numbers
(2) Simple, incremental numbers (like 'git-5432' ; what we use 
'git-describe' to generate)
(3) Reference of simple revision numbers in all git commands and tools like 
gitk, not SHA1

I personally have no problem with the SHA1 . but many are allergic to it .

As I have learned so much about the power of git,
I understand that:

- 'git-show-branch' actually show reversed serialized version numbers (we 
want it the other way, accending)
- 'git-describe' gives you commit numbers since your last annotated tags ( 
ie, git-5423-g7def45b)

so, i understand that a simple numbering scheme can be done .

I truly hope that the in the main repository model of git this can be turned 
on by a switch or in the git config .

Is it too complicated to incorporate this model ?

I m eager to hear about the options

Thanks,

  Justin Leung

  ASIC Verification Engineering

  Redback Networks
  a company of Ericsson 

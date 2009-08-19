From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: New to Git / Questions about single user / multiple projects
Date: Wed, 19 Aug 2009 00:59:42 -0700 (PDT)
Message-ID: <m3ab1wnsie.fsf@localhost.localdomain>
References: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Rob (gmail)" <robvanb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 09:59:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdg5L-0007LL-Gd
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 09:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbZHSH7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 03:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbZHSH7n
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 03:59:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:21344 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbZHSH7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 03:59:42 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1006015fga.17
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=rrTYqwLO9MUtwzzPw1mGGskkF1F1QLEgmi5Ct2J25PY=;
        b=ZJNwOLpEblA7LGlYWqNX9nMZ6ophYiNRe/qlbd1qWDipGJdYIgEZhEgkeZgDry2Lbi
         R6wxzufv8rrDvSJgQlKRUwNXAzwIs2ynoVD2RFfqmmkz+QEYntZE8cl32L6Rtm5/G7CZ
         iLZHin7+j8s3rjVKbciuWR0ktuUsE0a+/qu1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=UQSt0fx8vXhnxfPUmktKy23c4lDOHw9myFkC+71FaWnwoT5YJatC+rVcZtLPcRafCn
         QdbBVTbZruIVW4Sb9J+lBN0RDFqdspBVstLRqoc7AWWtMVaz0Rih2oFDv73qhFL0N7g3
         gzpyrxe00xeGgWOHPNOyrmqPPeFW75Qqn7Mvk=
Received: by 10.86.20.8 with SMTP id 8mr3953546fgt.44.1250668783511;
        Wed, 19 Aug 2009 00:59:43 -0700 (PDT)
Received: from localhost.localdomain (abvk137.neoplus.adsl.tpnet.pl [83.8.208.137])
        by mx.google.com with ESMTPS id l12sm10515156fgb.13.2009.08.19.00.59.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 00:59:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7J7xdKr004599;
	Wed, 19 Aug 2009 09:59:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7J7xc5j004595;
	Wed, 19 Aug 2009 09:59:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126514>

"Rob (gmail)" <robvanb@gmail.com> writes:

> I'm new to git and have some (I think) basic questions that I have
> not been able to find answers to in the documentation.  It's very
> possible that these are the result of my lack in understanding git /
> version control, so feel free to point me to documentation that
> might contain the answers.

Documentation you might want to read: 

* "Git User's Manual", distributed with Git (installed at least on
  Linux at $sharedir/doc/git-$version/user-manual.html), also at
  http://www.kernel.org/pub/software/scm/git/docs/user-manual.html

* "The Git Community Book", available at
  http://book.git-scm.com/

* "Pro Git.  Professional version control", available at
  http://progit.org/book/

> Q1:
> Can I create a single repository (project?) for all my code, knowing
> that there are multiple small, unrelated projects. Or should I create
> a new repository for each project ?

You should create a new repository for each project.  In git each
commit is about state of whole repository.


If you have single unrelated files, you might want to consider using
Zit tool (see http://git.or.cz/gitwiki/InterfacesFrontendsAndTools for
details), but beware that it is in early stages of development.

(Although if you choose one big repository, you can split it later
with some effort using git-filter-branch (or git-split somewhere in
mailing list archives) if you didn't publish your repositories).
 
> Q2:
> After initalizing my repository, and comitting the 1st batch of code:
> When further working on the code, will the command "git add ." add all
> changed and new files ? Or do I specifically need to list the new
> files ?

"git add ." would add _all_ new not ignored files, and would stage all
changed files.  But you would have to be sure that all files you don't
want to be comitted, like generated files (*.o, *.log,...) and backup
files of your editor (*~ or *.bak), are ignored using .gitignore
(usually for generated files) and .git/info/excludes or
core.excludesFile (usually for specific patterns like backup files).

> Q3: Can I run 'git add x' in any subdirectory, or do I need to issue
> if from the root of the project ?

Most git commands take subdirectory they are in into consideration
when acting.  "git add <filename>" in subdirectory works as expected.

Note that some commands need to have '.' as filename / pattern to be
limited to current subdirectory / act on current directory.

> --
> When in trouble or in doubt, run in circles, scream and shout

:-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git

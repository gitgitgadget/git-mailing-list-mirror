From: Andreas Ericsson <ae@op5.se>
Subject: Re: default aliases (ci, di, st, co)
Date: Thu, 09 Jul 2009 09:00:30 +0200
Message-ID: <4A55958E.1050401@op5.se>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Thu Jul 09 09:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOnec-0000Pt-71
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 09:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760053AbZGIHAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 03:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760034AbZGIHAj
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 03:00:39 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:40268 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760039AbZGIHAg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 03:00:36 -0400
Received: from source ([209.85.219.225]) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSlWVkcSNNx8jvV83QFAxV/bovDOr0Xfy@postini.com; Thu, 09 Jul 2009 00:00:36 PDT
Received: by ewy25 with SMTP id 25so7352756ewy.8
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 00:00:33 -0700 (PDT)
Received: by 10.210.65.16 with SMTP id n16mr480446eba.87.1247122833044;
        Thu, 09 Jul 2009 00:00:33 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 10sm4479342eyd.18.2009.07.09.00.00.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 00:00:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122937>

Ondrej Certik wrote:
> Hi,
> 
> coming to git from mercurial and svn, here is the alias part of my .gitconfig:
> 
> [alias]
>     ci = commit
>     di = diff --color-words
>     st = status
>     co = checkout
> 
> 
> And all is fine until I share commands to checkout my branch (for
> example) with other people, then basically I have to write those
> commands in full (e.g. commit, checkout, ...), since I cannot assume
> they have their .gitconfig setup the same way I do. Especially for
> people who are new to git.
> 
> What is the view on this in the git community?


Personally I think "plain" aliases like you use above are evil.
git is not svn or mercurial. If you use it like svn you'll be
surprised sooner or later and your workflow will feel awkward or
just plain wrong. hg and git are very similar, but the fact that
hg assumed the svn shorthands implies to me that they've tried
to retain a compatibility that does not, in fact, exist. DVCS
systems are enormously different from centralized ones. Borrowing
from centralized ones to a DVCS one feels utterly backwards.


> Do most of you write
> 
> git checkout -b branch ...
> 
> (possibly with TAB completion) or do most of you write
> 
> git co -b branch ...
> 
> (like I do all the time, except when sharing my commands with other people)?
> 

I have no simple aliases for any of the commands. There's just no reason
for them since tab completion works so well.

I do have one alias, which is "wsfix". It fixes whitespace fsckups I've
added to the index but not yet committed to the worktree. It's not a
particularly complex one, but not exactly simple either.


> Could in principle those aliases be even made default by git? Or is
> this not a good idea.
> 

I see no reason to add default aliases. It will make a mess of things
when trying to explain workflows to people who have older versions of
git where those default aliases aren't available. It'll add complexity
to explanations, which is never a good thing.

If I have a vote, I vote no.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Sun, 5 Aug 2007 14:26:11 +0200
Message-ID: <D17F92F4-3FF9-46CD-9E55-449C07DE2820@zib.de>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <20070803030459.GJ20052@spearce.org> <20070803125846.GC28323@fieldses.org> <20070804062010.GQ20052@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 14:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHfAl-00065r-FF
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbXHEMZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755648AbXHEMZY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:25:24 -0400
Received: from mailer.zib.de ([130.73.108.11]:53746 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755146AbXHEMZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 08:25:23 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75CPJOt014883;
	Sun, 5 Aug 2007 14:25:19 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10786.pool.einsundeins.de [77.177.7.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75CPIip002533
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 5 Aug 2007 14:25:19 +0200 (MEST)
In-Reply-To: <20070804062010.GQ20052@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55007>


On Aug 4, 2007, at 8:20 AM, Shawn O. Pearce wrote:

>>
>> Though I'd like to keep the main body of the manual focused on the  
>> major
>> command line tools, I'd have no objection to a separate chapter (or
>> appendix?) devoted to git-gui; then you could point directly at that.
>> Would that make sense?
>
> Yea, that makes a lot of sense.  git-gui isn't a full replacement
> for the command line anyway, so I would never suggest a wholesale
> rewrite of the user manual to slant the entire thing towards git-gui.
> Doing so would only point out the many shortcomings in git-gui.  :)

I partially disagree.

When users start to learn git they are mostly interested in how to
achieve a specific goal, e.g. how to create a commit. I think most
users either accept a command line or a gui, whatever is the easiest
and fastest way to do something.

I strongly believe that the sections in the manual should be organized
along the tasks that users want to solve and discuss available  
approaches.
Obviously each chapter should start with simple tasks and simple tools
(the commandline) and only later add advanced usage scenarios. But I
don't think it makes sense to put git gui into a separate chapter.

I personally use the command line for most of my work, but for adding
single diff hunks to the index I use git gui. It's much simple than
'git add -i'.

In the chapter on history browsing, the manual pretty early states

"The best way to see how this works is using the gitk(1) command;
running gitk now on a git repository and looking for merge commits
will help understand how the git organizes history."

which makes absolutely sense to me. If a gui is the best tool to
do the job 'understanding history', then there's no reason to first
restrict the manual to the command line tools, like 'git log'.


	Steffen

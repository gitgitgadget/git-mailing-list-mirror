From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 14:05:55 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703231357170.11744@qynat.qvtvafvgr.pbz>
References: <20070322224829.GA7048@c3sl.ufpr.br>  <20070323004335.GA17773@spearce.org>
  <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> 
 <20070323012422.GC17773@spearce.org>  <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk>
  <20070323103426.GA15923@diana.vm.bytemark.co.uk>  <20070323152102.GA4818@c3sl.ufpr.br>
  <Pine.LNX.4.64.0703231758020.8105@reaper.quantumfyre.co.uk>
 <20070323193427.GA12126@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Fri Mar 23 23:32:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUsJE-0008W8-Bj
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 23:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbXCWWcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 18:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbXCWWcX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 18:32:23 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:64292 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751674AbXCWWcO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 18:32:14 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 23 Mar 2007 14:32:13 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Fri, 23 Mar 2007 15:31:14 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20070323193427.GA12126@c3sl.ufpr.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42969>

On Fri, 23 Mar 2007, Bruno Cesar Ribas wrote:

> On Fri, Mar 23, 2007 at 06:13:16PM +0000, Julian Phillips wrote:
>> On Fri, 23 Mar 2007, Bruno Cesar Ribas wrote:
>>
>> Having said that, I don't think it would be a _bad_ thing if this work
>> went far enough that one could replace a Subversion server without any
>> users even noticing ;)
>
> I began to think about it... the idea to have a git-svnserver is to move from
> svn to git and get my dev team not to worry about the transition at the
> start, but it is a good idea to make people get moving to git idea of
> devlopment, right?
> Or the main idea is that we will have a group devloping under git repo and a
> group under svn-gateway for the same project? I don't see a point to have
> this! when a repo type is defined everyone must begin to understand that way,
> even if it was changed in the middle of the project.
>
> When decided above, we can define our dev of this project. Because as people
> make those 'strange' stuff at svn repo that git won't support we will have to
> make some workarounds to get git understand those things, and if we have some
> people migrated do git and some using svn they will not see some 'svn tags'
> on git repo.
>
> That's why i think it should be a transition thing from svn to git.

if you just want to transition everyone on a project from svn to git then you 
don't need a git-svn server, you just need a translation tool

what a git-svn server gives you is the ability to have some people use svn 
(becouse 'git is too complicated') while others use git.

think about sourceforge as an example. they only want to provide one version 
control tool, they started with cvs and are migrating to svn, but if they could 
put in a git server and git-svn server and support both.

think of it as 'one version control server to rule them all' (and then encourage 
people to do git-hg-server, git-arch-server, git-darc-server, etc)

as far as I can tell (with the exception of recording explicit renames) the git 
functionality is a strict superset of all the other version control tools, so it 
should be possible to emulate them with git. svn is just the biggest 
bang-for-the-buck in terms of number of users.

David Lang

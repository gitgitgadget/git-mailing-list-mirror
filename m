From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Wish: make commiter email address configurable per-repo
Date: Fri, 07 Jan 2011 19:01:54 +0100
Message-ID: <ig7kej$j4p$1@dough.gmane.org>
References: <ig73o1$lbg$1@dough.gmane.org> <201101071420.40570.trast@student.ethz.ch> <ig7449$lbg$2@dough.gmane.org> <201101071443.51574.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 07 19:02:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbGdj-000311-4u
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab1AGSCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:02:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:48655 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754660Ab1AGSCH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:02:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PbGda-0002xs-F6
	for git@vger.kernel.org; Fri, 07 Jan 2011 19:02:06 +0100
Received: from 188.111.54.34 ([188.111.54.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 19:02:06 +0100
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 19:02:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164727>

Thomas Rast wrote:

> Stephen Kelly wrote:
>> Thomas Rast wrote:
>> > See user.email in git-config(1).  Most people set it globally, as in
>> > 
>> >   git config --global user.email "author@example.com"
>> > 
>> > but there's nothing stopping you from doing
>> > 
>> >   git config user.email "alias@example.com"
>> > 
>> > to set it on a per-repo level.  (Or just edit .git/config, of course.)
>> 
>> Doesn't this set both the author and the committer?
> 
> Oh, I see.  Yes, it does.
>
> Stephen Kelly wrote earlier:
>> If my email address that I use for committing is not the same as that
>> configured in the bugzilla, the automated bug closing does not work.
> 
> 
> Probably if KDE has this use-case then that means we need to implement
> it as a feature on size alone, but I briefly looked into the code and
> it requires a bit more restructuring than I'm willing to do over
> coffee.
> 
> I think as a stop-gap measure you'll have to use an alias such as
> 
>   ci = commit --author="your usual <author>"
> 
> along with a local setting for user.email to force them to be
> different.  (Note that this will re-set the author when saying 'git
> ci --amend' on other people's commits!)
> 

Thanks for looking into it!

I'll consider the alias you suggest. Git command aliases can be configured 
per repo, right?

Is there a bug tracker used for git so that this issue doesn't get lost?

All the best,

Steve.

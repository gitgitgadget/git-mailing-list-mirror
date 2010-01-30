From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 16:18:45 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-4F99DE.16184529012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <op.u7a909hf4oyyg1@alvarezp-ws> <ron1-1F1799.13340029012010@news.gmane.org> <op.u7bfjni44oyyg1@alvarezp-ws> <ron1-0EE62E.14474929012010@news.gmane.org> <bd7fb2a884e55e176eea3002fd0c68dd@212.159.54.234> <ron1-A99355.16145629012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 01:20:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb14S-0007Kx-3d
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 01:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab0A3AUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 19:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247Ab0A3AUJ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 19:20:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:48733 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185Ab0A3AUI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 19:20:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nb14H-0007Cu-LU
	for git@vger.kernel.org; Sat, 30 Jan 2010 01:20:05 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 01:20:05 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 01:20:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138407>

In article <ron1-A99355.16145629012010@news.gmane.org>,
 Ron Garret <ron1@flownet.com> wrote:

> In article <bd7fb2a884e55e176eea3002fd0c68dd@212.159.54.234>,
>  Julian Phillips <julian@quantumfyre.co.uk> wrote:
> 
> > On Fri, 29 Jan 2010 14:47:49 -0800, Ron Garret <ron1@flownet.com> wrote:
> > > My actual use case is very complicated, but here's a simplified version:
> > > 
> > > Suppose I'm using git as a back-end for a wiki.  I want to look at the 
> > > state of the entire wiki as it was in some point in the past, and I also
> > 
> > > want to be able to look at the diffs between individual pages as they 
> > > were then and as they are now.  The most straightforward way I can think
> > 
> > > of to do that is to simply copy an old commit into my working tree 
> > > without changing anything else.  Then I can look at the old version by 
> > > simply looking at the files, and I can get the diffs by simply doing a 
> > > git diff.
> > > 
> > > If I do a git reset --hard then I get the old version, but I lose my 
> > > HEAD pointer so that git diff doesn't give me what I want any more.
> > > 
> > > BTW, it turns out that git checkout [commit] . doesn't do the right 
> > > thing either.  Apparently, it still updates my index, so git diff still 
> > > doesn't do the right thing.
> > 
> > If I understand what you want correctly, then:
> > 
> > git diff --cached -R [path]
> > 
> > should be the appropriate command after the "git checkout <commit> .".
> 
> Yep, that works.  Alternatively, is there a way to clear the index?  
> Seems like that would be better.

Well, whaddyaknow: git reset without any arguments has a use after all 
:-)

rg

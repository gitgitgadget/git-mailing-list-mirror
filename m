From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:24:04 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-953427.13240429012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <hjvgs1$rep$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 22:24:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayKN-0004Yu-R7
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab0A2VY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176Ab0A2VY0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:24:26 -0500
Received: from lo.gmane.org ([80.91.229.12]:41564 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801Ab0A2VY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:24:26 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NayKG-0004Vo-IW
	for git@vger.kernel.org; Fri, 29 Jan 2010 22:24:24 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:24:24 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:24:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138363>

In article <hjvgs1$rep$1@ger.gmane.org>,
 "Scott R. Godin" <scottg.wp-hackers@mhg2.com> wrote:

> On 01/29/2010 03:20 PM, Ron1 wrote:
> > [ron@mickey]$ git checkout master
> > Already on 'master'
> > [ron@mickey]$ git checkout master^
> > Note: moving to 'master^' which isn't a local branch
> > If you want to create a new branch from this checkout, you may do so
> > (now or later) by using -b with the checkout command again. Example:
> >    git checkout -b<new_branch_name>
> > HEAD is now at 7be05e0... test
> > [ron@mickey]$ git branch
> > * (no branch)
> >    master
> > [ron@mickey]$
> >
> > Huh?!?
> >
> > This is a test repository which has never been pulled from nor pushed to
> > anywhere.  So how is it possible that I have a non-local branch?
> >
> > Thanks,
> > rg
> >
> 
> I believe what you're seeing is known as a detached head (see 
> <http://www.kernel.org/pub/software/scm/git/docs/git-checkout.html> 
> though I could be wrong about this.)
> 
> I think you may have intended to do git checkout HEAD^ or something 
> similar?

Yes, in fact that is exactly what I am trying to do.  But that has the 
same result.

> basically what you did was (I think) checkout (or attempt to 
> checkout) the parent commit on master.

Yes.  I posted it that way simply because 'git commit HEAD' depends on 
what HEAD is.  If HEAD is the head of master (which it was) then the 
result is the same.

> 
> this may offer some additional food for thought: 
> <http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html#_exploring_h
> istory>

Yes, I read that.  But what I'm trying to do is not just *look* at the 
history, I want to restore my working tree to a previous version.  The 
"Exploring History" section of the docs doesn't say how to do that.

rg

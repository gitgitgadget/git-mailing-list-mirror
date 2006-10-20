From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 12:32:43 +0200
Organization: At home
Message-ID: <eha8k6$uc$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <200610170155.10536.jnareb@gmail.com> <Pine.LNX.4.64.0610161704240.3962@g5.osdl.org> <45345CBE.8020209@utoronto.ca> <loom.20061019T205327-196@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 20 12:33:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Garh2-00074d-6c
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 12:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWJTKda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 06:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422923AbWJTKda
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 06:33:30 -0400
Received: from main.gmane.org ([80.91.229.2]:6274 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422781AbWJTKd2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 06:33:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Garge-0006xv-L3
	for git@vger.kernel.org; Fri, 20 Oct 2006 12:33:12 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 12:33:12 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 12:33:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29439>

Nathaniel Smith wrote:

> Aaron Bentley <aaron.bentley <at> utoronto.ca> writes:
>
>> Bazaar also supports multiple unrelated branches in a repository, as
>> does CVS, SVN (depending how you squint), Arch, and probably Monotone.
> 
> It's quite common in Monotone.  You could probably do it in Mercurial as well,
> though I don't know that anyone does.  SVK definitely does it (since each user
> has a single repo that's shared by all the projects they work on).

I think that GIT separation of root, repository, and branches
namespaces is why there are so many calls for adding subproject
support to GIT; people want to change to GIT literally, for example
putting everything in one large repository.

In GIT there is no concept of root, like in CVS or SVN. You can
put repository anywhere. By default GIT looks for repository 
in current directory or one of its parents; otherwise you have to
provide location of repository either by using GIT_DIR environment
variable, or by using --git-dir option to git wrapper.

And the branch namespace is totally separate. There are some
restrictions on branch names (caused by notation GIT uses, for
example <branch>^ means [first] parent of commit given by <branch>),
but really few. Branch names can be hierarchical, like "jc/diff".

So there is no "store everything in URL/path" of
  /root/repo/branch
notation in GIT.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

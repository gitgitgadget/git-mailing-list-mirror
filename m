From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Sun, 02 Jul 2006 23:46:20 +0200
Organization: At home
Message-ID: <e89eqj$npu$1@sea.gmane.org>
References: <e8954u$srh$1@sea.gmane.org> <e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jul 02 23:46:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx9lf-0002XI-UP
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 23:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWGBVqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWGBVqM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 17:46:12 -0400
Received: from main.gmane.org ([80.91.229.2]:65259 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750991AbWGBVqM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 17:46:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fx9lR-0002Vt-CZ
	for git@vger.kernel.org; Sun, 02 Jul 2006 23:46:01 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 23:46:01 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 23:46:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23126>

Marco Costalba wrote:

> On 7/2/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Currently in qgit one can git-format-patch a commit. It woul be nice 
>> if one would be able to git-cherry-pick and git-cherry-pick -n a commit
>> (denoting the head, i.e. where cherry pick would be applied to). It would
>> be very usefull in reordering patches (cleaning up history).   
> 
> Currently in qgit you can git-format-patch a commit series and git-am
> a given patch file series.
> This can be done transparently with a drag & drop mechanic:
> 
> 1) Open the source repository
> 2) Then open a new qgit instance (File->Open in a new window...)
> 3) Open the destination repository in the new qgit window
> 4) Drag & drop selected commits (multi selection in supported) from
> source to destination.

Does multi selection commits all selected commits as one merged commit?

> I normally use this instead of git-cherry-pick  that, I admit, I don't
> know very well, so please I need some more hints on how to upgrade
> this behaviour introducing git.cherry-pick support.

I use git-cherry-pick -n to join few patches into one, or with editing the
result to split one patch/commit into few smaller.

git-cherry-pick [-n] <commit> picks up a commit and drops it on top of
current branch. I'd like to see it in context menu for current commit,
i.e. "cherry-pick to <head>", where <head> will be replaced by current
branch name, or/and "cherry-pick -n to <head>". 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

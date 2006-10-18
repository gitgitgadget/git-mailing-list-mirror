From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 17:50:32 +0200
Message-ID: <200610181750.32888.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <1161147348.3423.24.camel@localhost.localdomain> <Pine.LNX.4.64.0610180820210.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Robert Collins <robertc@robertcollins.net>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 17:52:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaDgx-0004u1-Ey
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 17:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWJRPuB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 11:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161188AbWJRPuA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 11:50:00 -0400
Received: from qb-out-0506.google.com ([72.14.204.228]:42702 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161088AbWJRPt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 11:49:58 -0400
Received: by qb-out-0506.google.com with SMTP id p36so745385qba
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 08:49:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iCCiCTdQ7eP0zW4XEvhXQPpD0MH6jHa//q5L1dze7WqPQN5mz3oOczwYfF4VNTvM8mYm6Ry1PREacYL2awZOHJmfMH40VtdHloTyS5WLMkPTUMysfXzZ8tlwvtLKzIpXT/Zbvqva+ZmukmkfJM26cyOGFWe2rJ0lz5ie7e3FKvI=
Received: by 10.66.220.17 with SMTP id s17mr12051834ugg;
        Wed, 18 Oct 2006 08:49:56 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id 55sm1188878ugq.2006.10.18.08.49.55;
        Wed, 18 Oct 2006 08:49:56 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0610180820210.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29240>

Linus Torvalds wrote:
> 
> On Wed, 18 Oct 2006, Robert Collins wrote:
>> 
>> More commonly though, like git users have 'origin' and 'master'
>> branches, bzr users tend to have a branch that is the 'origin' (for bzr
>> itself this is usually called bzr.dev), as well as N other branches for
>> their own work, which is probably why we haven't seen the need to have a
>> ui command to spit out the revnos for an arbitrary branch.
> 
> You mis-understand.
> 
> git doesn't have a "ui command to spit out the revnos for an arbitrary 
> branch" either.
> 
> Normally, you'd just use the branch-name. Nobody ever uses the SHA1's 
> directly.

With the exception of having sometimes commit-ids in the commit messages,
for example "Fixes bug introduced by aabbcc00" (although usually you just
write "Fixes bug in some_function in some_file"), and automatically
generated 
  This reverts d119e3de13ea1493107bd57381d0ce9c9dd90976 commit.
(in addition to 'Revert "<Commit title>") for git-revert generated
commit messages.

And it is true that you usually use branchname, or branchname~n syntax.
Git even has git-name-rev to convert from sha1 to temporary, local
ref^m~n... syntax.


By the way, git has very powerfull syntax to get revisions, and
revision lists. For example "git-rev-list foo bar  ^baz" means
"list all the commits which are included in foo and bar lineage,
but not in baz", or more useful "git log origin..next".

How's that in bzr?
-- 
Jakub Narebski
Poland

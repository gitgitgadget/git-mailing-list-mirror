From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Tracking a branch using StGIT
Date: Fri, 15 Sep 2006 14:09:34 +0200
Organization: At home
Message-ID: <eee551$mtc$1@sea.gmane.org>
References: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com> <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com> <64de5c8b0609150432o5d6835a8pb578082746576864@mail.gmail.com> <eee3i5$ib6$1@sea.gmane.org> <64de5c8b0609150459i2e678a02r86bb678ea420054f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Sep 15 14:09:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOCVe-0002Fj-Rg
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 14:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWIOMJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 08:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWIOMJ1
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 08:09:27 -0400
Received: from main.gmane.org ([80.91.229.2]:65187 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751311AbWIOMJ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 08:09:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOCVQ-0002CS-HG
	for git@vger.kernel.org; Fri, 15 Sep 2006 14:09:16 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 14:09:16 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 14:09:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27082>

Rajkumar S wrote:

> On 9/15/06, Jakub Narebski <jnareb@gmail.com> wrote:
> 
>> git pull is git fetch + merge of first head in remotes file with _current_
>> branch.
> 
> I was under the impression that git pull is git pull + merge of
> corresponding branches in remotes files. ie master -> origin and
> RELENG_1 -> RELENG_1. Is such a pull possible, for all lines in
> remotes file?

GIT-PULL(1)
DESCRIPTION
       Runs  git-fetch with the given parameters, and calls git-merge to merge the
       retrieved head(s) into the current branch.

Besides in remotes file you have only specified which remote branch
is tracked by which local branch. Additionally all but first are marked
as not-for-merge. There is no place for default branch to merge with.

There was some discussion about moving remotes information into config
file, including marking tracking branches as read-only, marking default
branch to merge (or marking branch as for-merge/not-for-merge), marking
branch as of not fast-forwarding type (like 'pu' in git.git) on the
_server_ side etc. But it petered out, unfortunately.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: git-svn mergeinfo support performance problem
Date: Sun, 20 Dec 2009 01:28:32 +0100
Message-ID: <4B2D6FB0.6080103@gmail.com>
References: <6b2f9b1d0912181708g32645b48j3886b74101e77d80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 01:29:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM9fi-0006Ui-IL
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 01:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbZLTA3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 19:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbZLTA3L
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 19:29:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:47212 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259AbZLTA3F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 19:29:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NM9fS-0006Ss-40
	for git@vger.kernel.org; Sun, 20 Dec 2009 01:29:02 +0100
Received: from dsl-083-247-086-199.solcon.nl ([83.247.86.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 01:29:02 +0100
Received: from johanthart by dsl-083-247-086-199.solcon.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 01:29:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-083-247-086-199.solcon.nl
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <6b2f9b1d0912181708g32645b48j3886b74101e77d80@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135511>

Andrew Myrick schreef:
> I've been testing git-svn v1.6.6-rc3's mergeinfo support on a large
> svn repository (60,000+ revisions, 20+ GiB) that uses a very
> branch-heavy integration model in which every change gets its own
> branch before being committed to trunk.  As a result of the model,
> there are currently over 1000 lines in the svn:mergeinfo property on
> trunk.

Just wondering: Isnt this workflow stalling svn itself alot too?

And also:
Do you delete the branches after you reintegrated them? If so, I think 
its safe for you to cleanup the svn mergeinfo once in a while. That 
should not affect 'svn log -g' because the mergeinfo is still there in 
older revisions. I think svn benefits from this too...

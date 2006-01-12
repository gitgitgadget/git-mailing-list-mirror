From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: RFC: Subprojects
Date: Thu, 12 Jan 2006 18:20:13 +1100
Message-ID: <pan.2006.01.12.07.20.12.411828@progsoc.org>
References: <43C52B1F.8020706@hogyros.de> <200601120919.08354.lan@ac-sw.com> <46a038f90601112046u13d7075dsc2108111e2462152@mail.gmail.com> <200601121125.33696.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jan 12 08:19:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewwjh-00085n-Bz
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 08:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWALHTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 02:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWALHTA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 02:19:00 -0500
Received: from main.gmane.org ([80.91.229.2]:49044 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030271AbWALHTA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 02:19:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ewwja-00084V-G2
	for git@vger.kernel.org; Thu, 12 Jan 2006 08:18:58 +0100
Received: from 203.7.227.170 ([203.7.227.170])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jan 2006 08:18:58 +0100
Received: from wildfire by 203.7.227.170 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jan 2006 08:18:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203.7.227.170
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14549>

On Thu, 12 Jan 2006 11:25:33 +0600, Alexander Litvinov wrote:

> On Thursday 12 January 2006 10:46, Martin Langhoff wrote:
>> > I really miss this feature. This is the last stopper for moving from CVS
>> > to git for out project.
>>
>> What about using nested checkouts? They work great with git as-is,
>> just add an .gitignore file.
>>
>> As Linus points out, there are many good reasons why a top-level
>> commit should _not_ commit the nested subproject. And once you are
>> observing that rule, what's left then? git status and git diff <HEAD>
>> can show an aggregate of top-level and nested subprojects, but that's
>> ease-of-use -- not something only.
>>
>> What is your show stopper?
> 
> I would agree to make separate commits for each sub project.
> 
> 1. I need to have ability to make tags, branches thru all subprojects.
> 2. Update (pull) sould update each subproject, it is hard to update them by 
> hands.
> 3. The need of some sort of checkout script (can be solved by storing this 
> script in base project, but it would be much nicer allow git fetch all 
> subprojects)
> 
> Nothing else I can imagine.

It sounds like you want 'config-manager',
http://packages.debian.org/unstable/devel/config-manager, it doesn't
support git (yet) but I can't imagine it is hard to add that support in.

Cheers,
Anand

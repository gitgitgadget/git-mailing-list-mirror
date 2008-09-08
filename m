From: david@lang.hm
Subject: Re: Is incremental staging really the common mode? [Was: Re: Git
 User's Survey 2008 partial summary, part 4 - how do we use Git]
Date: Sun, 7 Sep 2008 17:32:09 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0809071729310.8096@asgard.lang.hm>
References: <51419b2c0809071317g6f916b19p1c2792595be58047@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 02:32:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcUgR-0008Gb-Gz
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 02:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYIHAbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 20:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbYIHAbT
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 20:31:19 -0400
Received: from mail.lang.hm ([64.81.33.126]:55982 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbYIHAbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 20:31:19 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m880VCtO028497;
	Sun, 7 Sep 2008 17:31:12 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <51419b2c0809071317g6f916b19p1c2792595be58047@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95199>

On Sun, 7 Sep 2008, Elijah Newren wrote:

> Hi,
>
> On Sat, Sep 6, 2008 at 4:17 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> This is partial summary of Git User's Survey 2008 after more that 2000
>> (yes, that is more than _two thousands_ responses) just after the 6 days
>> of running the survey.  It is based on "Analysis" page for this survey:
>>  http://www.survs.com/shareResults?survey=M3PIVU72&rndm=OKJQ45LAG8
>>
> <snip>
>> git add + git commit   | 65% (1012)
>> git commit -a          | 63%  (981)
> <snip>
>> Analysis: strangely "git add + git commit" is slightly more used than
>> "git commit -a"; I would suspect that "git commit -a" would dominate a
>> bit over other forms of committing.  What is for me more suprising is
>> that "git commit <file>..." has such large presence in often used
>> commands; I would think that it should be mostly used as 'sometimes'
>> command.
>
> Does this data really compare usage of incremental staging of commits
> vs. non-incremental all-changes-included commits?
>
> You didn't have a git add + git commit -a, so if people feel like they
> have brand new files to add to the repository often, adding new files
> alone would cause them to mark the git add + git commit box as "often"
> (or maybe I was the only one dumb enough to think this was
> significantly related to adding new files?).  That alone could account
> for the difference, assuming others misunderstood as I did.

also, how many are doing 'git add .' or 'git add *' followed by git 
commit?

there were several commands listed that I have never heard of before and 
will want to research to see what they do to see if I should be using 
them.

next survey it would be handy to have links from each command you are 
asking about to a page that describes what it does and why you would use 
it (_not_ just a link to the man page for git add in the example above)

David Lang

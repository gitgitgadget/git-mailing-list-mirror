From: Andreas Ericsson <ae@op5.se>
Subject: Re: Help designing work flow
Date: Mon, 09 Mar 2009 14:28:52 +0100
Message-ID: <49B51994.1040200@op5.se>
References: <450196A1AAAE4B42A00A8B27A59278E709F07D30@EXCHANGE.trad.tradestation.com>	 <49B4F5A9.5060304@op5.se>	 <43d8ce650903090444n352f310fs9cd4b8b0184be010@mail.gmail.com>	 <49B50B3C.50700@op5.se> <43d8ce650903090622j51b73801gb4be62a7f50029a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Dlugosz <JDlugosz@tradestation.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 14:31:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgfZX-0003KB-65
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 14:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbZCIN26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 09:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZCIN26
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 09:28:58 -0400
Received: from spsmtp02oc.mail2world.com ([74.202.142.148]:1985 "EHLO
	spsmtp02oc.mail2world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbZCIN24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 09:28:56 -0400
Received: from mail pickup service by spsmtp02oc.mail2world.com with Microsoft SMTPSVC;
	 Mon, 9 Mar 2009 06:27:20 -0700
auth-sender: exon@home.se
Received: from 212.112.174.166 unverified ([212.112.174.166]) by spsmtp02oc.mail2world.com with Mail2World SMTP Server; 
	Mon, 09 Mar 2009 06:27:19 -0700
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <43d8ce650903090622j51b73801gb4be62a7f50029a4@mail.gmail.com>
X-OriginalArrivalTime: 09 Mar 2009 13:27:20.0545 (UTC) FILETIME=[C6251510:01C9A0BA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112695>

John Tapsell wrote:
> 2009/3/9 Andreas Ericsson <ae@op5.se>:
>> John Tapsell wrote:
> 
>> Not really. If bugs are in "unrelated" areas (if the topic changed some
>> API without changing its' other callers, fe), you can backstep between
>> each commit on the merged branch, remerge that commit (instead of the
>> tip) and then run the tests again.
> 
> Doing that manually?  Sounds really complicated, especially if the
> merge is nontrivial.
> 

Well, using git bisect should work.

>> But really, such bugs should have
>> been detected prior to merging the branch, and in any case "git bisect"
>> will find the commit that introduced the bug for you either way.
> 
> How will you detect bugs that arise from merging two trees, before you
> merge them?
> 

Assuming you don't start each topic-branch from a completely empty tree
and that you have *some* tests, you can run those tests at every single
commit just as if you had done those on the 'master' branch. API changes
that break things should break earlier, unless another branch made those
changes.

Aside from that, it's quite simple to run tests before publishing the
results of the merge, and it's absolutely trivial to undo the merge
in case tests don't pass.

>> For next time, please cut away those parts of the email you didn't
>> reply to. I had to scroll down to the bottom to make sure you hadn't
>> written more.
> 
> I'll try sorry.  Most email clients will hide the quoted text - there
> might be an option for that in your client?
> 

I'm sure there is, but then I wouldn't have seen what you were replying
to, so that's not a very good option. In the space between me sending
and you replying, I wrote six other emails. Keeping track of them all
in my head is not something I'm prepared to even consider trying.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

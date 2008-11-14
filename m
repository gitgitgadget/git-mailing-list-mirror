From: Andreas Ericsson <ae@op5.se>
Subject: Re: git to libgit2 code relicensing
Date: Fri, 14 Nov 2008 23:57:03 +0100
Message-ID: <491E023F.9030605@op5.se>
References: <491DE6CC.6060201@op5.se>	 <20081114213352.GA12134@auto.tuwien.ac.at> <bd6139dc0811141346w194ae4c5m9f7b0fdb106108fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Nov 14 23:58:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L17cP-0004pf-TS
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 23:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYKNW5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 17:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbYKNW5L
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 17:57:11 -0500
Received: from mail.op5.se ([193.201.96.20]:55419 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbYKNW5K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 17:57:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E8AD31B80088;
	Fri, 14 Nov 2008 23:51:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u5lBhSbVM7pS; Fri, 14 Nov 2008 23:51:37 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 695D61B8009E;
	Fri, 14 Nov 2008 23:51:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <bd6139dc0811141346w194ae4c5m9f7b0fdb106108fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101025>

Sverre Rabbelier wrote:
> On Fri, Nov 14, 2008 at 22:33, Martin Koegler
> <mkoegler@auto.tuwien.ac.at> wrote:
>> On Fri, Nov 14, 2008 at 09:59:56PM +0100, Andreas Ericsson wrote:
>>> I've put everyone who "owns" more than 500 lines of code
>>> on the bcc list, figuring your permission is important
>>> but that you don't want the hundreds (well, one can hope)
>>> of emails from people saying "ok". The list of major owners
>>> was generated with "git showners *.c" in a worktree from
>>> the next branch of git.git.
>> I don't think, that your way for relicensing is bullet proof:
>>
>> I consider many of my GIT patches as derived work from other parts of
>> GIT, even if git blame is stating me as author. I can gurantee you,
>> that I comply with the "Developer's Certificate of Origin 1.1" point
>> b, as its based on code out of git.git. But I can't tell you, from
>> which files I reused code anymore.
>>
>> Probably other people did the same.
>>
>> Your method is ignoring such derived code.
> 
> Perhaps git stats can be of assistance here, it can summarize how much
> lines a person changed (per file, or in total), that should be a
> better metric (at least for code reused from within git.git, ofcourse
> GPL-ed code taken from somewhere else is not covered).
> 

That will almost certainly not be a problem. I'm working on reading stuff
into git-specific structures and then updating those structures. I doubt
any such code exists outside git. If it does, it's more likely derived
from git than the other way around.

It's also worth noting that I'm aiming for the really low-level core
stuff at first. It would be beneficial to get such simple things going
as updating the index (with an entire file) and then creating a commit
from that index. Such a thing would definitely be enough for (very basic)
IDE integration, and then we can build further on that but utilizing
developers from other projects than the git developer community.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

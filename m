From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 20:07:12 +0200
Message-ID: <4DF25D50.5020107@ira.uka.de>
References: <201106051311.00951.jnareb@gmail.com> <201106082056.38774.jnareb@gmail.com> <4DF0B4B2.7080007@ira.uka.de> <201106101844.16146.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 20:06:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV667-0008VH-0D
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 20:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757735Ab1FJSGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 14:06:14 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48197 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752889Ab1FJSGN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2011 14:06:13 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1QV65l-0003L6-Ta; Fri, 10 Jun 2011 20:06:05 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1QV65l-0001qu-HN; Fri, 10 Jun 2011 20:05:57 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <201106101844.16146.jnareb@gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1307729165.219839000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175613>

On 10.06.2011 18:44, Jakub Narebski wrote:
> On Thu, 9 Jun 2011, Holger Hellmuth wrote:
>> Also there are no good words for what someone wants to see in this case.
>> At least I would assume the git project would have found them if they
>> existed. '--cached' is definitely not one of them. But we have fitting
>> and widely known names for the targets, i.e 'working tree', 'index' and
>> 'head'.
>
> "I want to see if there are any remiaining changes", "I want to see what
> 'git commit' would bring", "I want to see what 'git commit -a' would bring".
> Neither of those is about targets for diff.

Are you proposing a command "git 
--I-want-to-see-if-there-are-any-remaining-changes" ? ;-). I was looking 
for short command or parameter names that are easy to remember, not for 
definitions of the output of cryptic commands.

But lets see. If I didn't know much git, where would I look for the 
right command for your three needs? Where would I expect the solution? 
(note I'm not proposing any of these commands)

"I want to see if there are any remiaining changes"?
git status
git status --full
git status --detailed

"I want to see what 'git commit' would bring"
git commit --dry-run

"I want to see what 'git commit -a' would bring"
git commit -a --dry-run

Now I'll add a question I would want to ask:
"I want to see the changes between what I have in my working tree and 
what I already added to the index"
git diff WTREE INDEX


Btw. even the 'git diff' man page emphasizes that diff is about a 
comparision between two things. Citation: "Show changes *between* two 
trees, a tree and the working tree, a tree and the index file,...".


> [...]
>>> The "git diff NEXT WTREE" looks like training wheels to me.  And like
>>> training wheels they could become obstacles and not help to learning
>>> git.  Neverthemind they can snag on sharp corners^W corner-cases. ;-)))
>>
>> If your goal is that anyone who uses git is a git expert, they may be a
>> hindrance (as are all the porcelain commands really). If you also want
>> to make git friendly to people who will never get past intermediate or
>> beginner stage or will only use a small part of git or use git seldomly,
>> training wheels are good.
>
> Those "training wheels" are useless for beginner, and might be not very
> useful to middle expert user either, depending on corner cases.

"useless for beginner". No reasoning, just a fat road block for my opinion?
As git expert you are so far removed from any beginner status. Are you 
sure you still know how a beginner thinks?

Holger.

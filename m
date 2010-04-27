From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Re: Metadata and checkin file date
Date: Tue, 27 Apr 2010 22:00:20 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004272152190.11216@bbs.intern>
References: <alpine.LFD.2.00.1004270719320.17234@bbs.intern> <4BD6ACEF.1040909@op5.se> <alpine.LFD.2.00.1004272111540.5630@bbs.intern> <4BD73F64.1070604@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 27 22:01:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6qyM-000076-B4
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab0D0UB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 16:01:28 -0400
Received: from chello084112167138.7.11.vie.surfer.at ([84.112.167.138]:37540
	"EHLO wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999Ab0D0UB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:01:27 -0400
Received: from bbs.intern (localhost [127.0.0.1])
	by wiesinger.com (8.14.4/8.14.4) with ESMTP id o3RK0M2T013821;
	Tue, 27 Apr 2010 22:00:22 +0200
Received: from localhost (gerhard@localhost)
	by bbs.intern (8.14.4/8.14.4/Submit) with ESMTP id o3RK0Kg0013814;
	Tue, 27 Apr 2010 22:00:20 +0200
In-Reply-To: <4BD73F64.1070604@op5.se>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-MailScanner-Information-wiesinger-com: Please contact the ISP for more information
X-wiesinger-com-MailScanner-ID: o3RK0M2T013821
X-MailScanner-wiesinger-com: Found to be clean
X-MailScanner-SpamCheck-wiesinger-com: not spam, SpamAssassin (not cached,
	score=-4.353, required 4.5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.05, BAYES_00 -2.60)
X-MailScanner-From: lists@wiesinger.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145941>

On Tue, 27 Apr 2010, Andreas Ericsson wrote:

> On 04/27/2010 09:38 PM, Gerhard Wiesinger wrote:
>> On Tue, 27 Apr 2010, Andreas Ericsson wrote:
>>
>>> On 04/27/2010 07:23 AM, Gerhard Wiesinger wrote:
>>>> Hello,
>>>>
>>>> I'm new to git and I'm looking for the following features:
>>>> 1.) Metadata for
>>>> a.) directory versioning (e.g. add/rm, mv)
>>>
>>> If you're talking about empty directories, that feature doesn't
>>> exist and I can't imagine why you'd want it to. If you'd care to
>>> explain why you want it, I'm sure we can find a different way of
>>> achieving your goal.
>>
>> Git focuses on content but I think git should also focus on metadata.
>> For example restructuring source code moves (git mv file1.c file2.c, git
>> mv dir1 dir2) should be documented also in the repository like e.g.
>> subversion and commercial SCM like clearcase do. Otherwise we are on
>> "CVS" level.
>>
>> Empty directories is a special case and sometimes you need just
>> versioned empty directies.
>>
>
> This has been discussed to death several times before on this mailing
> list. Browse the archives. There haven't been any new arguments the
> last 14 times it came up, so I doubt you'll be able to come up with
> a single good reason to track file renames explicitly.

As it pops up that often by git users I think it is an issue which 
shouldn't be ignored as users should be king :-)

>>>> b.) rights (basic: chmod, chow, chgrp, extended: extended attributes
>>>> like ACLs and selinux), necessary for versioning e.g. /etc
>>>
>>> Sounds like you want a backup-program. Some projects have been
>>> aimed towards this goal already. I'm sure google can provide
>>> more information. AFAIR, most of them work with two hook-scripts
>>> that update a regular file with the meta-data of all tracked
>>> files. This makes committing and checking out slower than it
>>> would otherwise be, but since it's doing more I suppose that's
>>> to be expected.
>>>
>>> Adding it to core git would mean re-designing git's basic data
>>> model, which is obviously not something we're about to do on
>>> a whim.
>>
>> No, I'm NOT looking for a backup program. Every admin has the problem of
>> versioning config files (for example /etc). Versioning of config files
>> makes sense because one can track the changes and e.g. correlate to
>> problems. A backup program doesn't have features like history, committer
>> and comments on file changes. Therefore git would be a perfect tool also
>> for versioning configuration. (Software development doesn't end with the
>> build but typically also has deployment&configuration issues).
>>
>
> Right. So you want a *fancy* backup program and not just any random
> backup solution. There are solutions for this. Someone else already
> mentioned them elsewhere in this thread, so I'll refrain from further
> comments on this.
>
> In short: What you want can be (and has been) done, but it's written
> as addons and not integral parts of git.

A first quick look on them: They are only a workaround to the real 
problem. For example subversion therefore has generic properties which 
also can be user defined (e.g. svn propset/propget) and I think such a 
concept should also be integrated part of git.

Only my 2 cents making git (one of the SCM where I think it is very 
powerful and has also potential in the future) even better than 
competition.

Ciao,
Gerhard

--
http://www.wiesinger.com/

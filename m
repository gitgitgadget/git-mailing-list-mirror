From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv2 27/56] string-list: Add API to remove an item from an
 unsorted list
Date: Sat, 13 Aug 2011 11:08:17 +0200
Message-ID: <4E463F01.5060301@kdbg.org>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>	<1313126429-17368-28-git-send-email-newren@gmail.com>	<4E44CF9D.8030501@viscovery.net> <CABPp-BFsqDhVnxDa9u3tV0yZky_az0MTCT_N5y+Oqm84+fOyvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jim Foucar <jgfouca@sandia.gov>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 11:10:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsAEl-0008O2-D9
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 11:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000Ab1HMJIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 05:08:24 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:9107 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750847Ab1HMJIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 05:08:23 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 228A913004B;
	Sat, 13 Aug 2011 11:08:17 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9539E19F43F;
	Sat, 13 Aug 2011 11:08:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <CABPp-BFsqDhVnxDa9u3tV0yZky_az0MTCT_N5y+Oqm84+fOyvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179272>

Am 13.08.2011 00:14, schrieb Elijah Newren:
> On Fri, Aug 12, 2011 at 1:00 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 8/12/2011 7:20, schrieb Elijah Newren:
>>> Here's an attempt for a delete_item API (note: only compile-tested).
>>
>> Seriously? You haven't even tested this patch, and still don't mark it
>> with RFC?
> ...
> However, I am unclear what you mean by not even testing the patch,
> though.  I couldn't find any unit-test harness or any other kind of
> testsuite for the string_list API.  I did review the code to make sure
> it looked right to me, added a use of your new function, and ran the
> standard testsuite in addition to my "re-merge all merges from
> git.git" testcase.  I even single stepped through the code in a
> debugger for good measure.  What testing did you want to see in
> particular?

This kind of testing is fine. And I appologize for asking a provocative
question. Of course, I know that you did test the new function suitably,
otherwise you wouldn't have submitted the series.

So, the question is rather, why did that sentence remain in the commit
message? The commit message should not be deceptive (and in particular
not blindly copy-pasted from an email that throws out a patch in the
hopes that somebody picks it up and massages into a good shape - I
thought it was clear that my patch was not a proper patch submission).

Think about someone browses history constrained by pathspec
'string-list.c'. This person will see this commit without any hint about
the merge-recursive series or that the new API is used in the next
commit, and will have to ask: "Why the heck is did someone introduce
this code and didn't even test it?"

-- Hannes

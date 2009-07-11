From: Kurt Milligan <kurt@surfmerchants.com>
Subject: Re: commit hooks on merge
Date: Sat, 11 Jul 2009 07:56:36 -0400
Message-ID: <4A587DF4.6090602@surfmerchants.com>
References: <4A43D37B.20203@surfmerchants.com> <e1a5e9a00907102211m43522a09l49093ae50ea16e2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, kurt@surfmerchants.com
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 13:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPbCE-0006Vy-Qa
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 13:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbZGKL4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 07:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbZGKL4o
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 07:56:44 -0400
Received: from mail.quanetic.com ([71.248.185.19]:53663 "EHLO
	mail.quanetic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbZGKL4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 07:56:43 -0400
Received: by mail.quanetic.com (Postfix, from userid 5001)
	id 14679147F33; Sat, 11 Jul 2009 07:55:57 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on rook
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.5
Received: from [192.168.2.100] (static-71-248-185-21.bstnma.fios.verizon.net [71.248.185.21])
	by mail.quanetic.com (Postfix) with ESMTP id 39615147C0D;
	Sat, 11 Jul 2009 07:55:51 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <e1a5e9a00907102211m43522a09l49093ae50ea16e2a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123111>

Tim -

Thanks for the reply!

For completeness, my reason for wanting this hook is to be able to run 
some automated tests on the code.
I understand why you wouldn't want to execute a pre-commit hook on a 
merge that is just a fast-forward, but if it's not a fast-forward, then 
code is changing and automated tests could potentially fail...but the 
pre-commit hook is not run, and there is no pre-merge hook.

I searched the mailing lists, and it appears folks have submitted 
patches for both of these problems, but either they never made it into 
the tree or got rejected...but in any case, it implies that I'm not the 
only one with this concern.

Anyway, thanks for your suggestion...I will try that route!

Thanks

-Kurt


Tim Harper wrote:
> Kurt
>
> I don't think there is a hook to prevent a merge from occurring.  I
> mean, you could probably rename git-merge, and then put a wrapper
> script in its place.  That script could call the hook for the current
> repository, if it exists and you could implement pre-merge.
>
> This is if you REALLY REALLY want to do it :)
>
> Tim
>
> On Thu, Jun 25, 2009 at 1:43 PM, Kurt Milligan<kurt@surfmerchants.com> wrote:
>   
>> Hi
>>
>> I asked this in #git, and did a quick Google search to no avail...
>>
>> According to the docs, merge does an auto-commit, but it seems that the
>> pre/post commit hooks are not run for this commit. Is that intentional? Is
>> there a way I can make them run for the merge commit? I see there is a
>> post-merge hook, but that doesn't really help me if I want to stop the
>> merge...
>>
>> Thanks in advance
>>
>> -Kurt
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>     

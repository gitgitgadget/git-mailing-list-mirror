From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: full kernel history, in patchset format
Date: Tue, 19 Apr 2005 09:33:21 +0100
Message-ID: <tnxfyxngo8e.fsf@arm.com>
References: <20050416131528.GB19908@elte.hu> <tnx4qe49z4h.fsf@arm.com>
	<426437A2.7080903@cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 10:30:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNo7J-0000mD-6C
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 10:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVDSIdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 04:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDSIdr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 04:33:47 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:13491 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261276AbVDSIdd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 04:33:33 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j3J8X14G022140;
	Tue, 19 Apr 2005 09:33:01 +0100 (BST)
Received: from localhost.localdomain (cmarinas@pc1117.cambridge.arm.com [10.1.69.141])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id JAA15060;
	Tue, 19 Apr 2005 09:33:22 +0100 (BST)
To: David Mansfield <david@cobite.com>
In-Reply-To: <426437A2.7080903@cobite.com> (David Mansfield's message of
 "Mon, 18 Apr 2005 18:41:38 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Mansfield <david@cobite.com> wrote:
> Catalin Marinas wrote:
>> AFAIK, cvsps uses the date/time to create the changesets. There is a
>> problem with the BKCVS export since some files in the same commit can
>> have a different time (by an hour). I posted a mail some time ago
>> about this -
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=110026570201544&w=2
>> I read that the old history won't be merged into the new repository
>> but, if you are interested, I have a script that can do this based on
>> the "(Logical change ...)" string in the file commit logs and it is
>> quite fast at generating the patches.
>>
>
> Hmmm.  I read that message just now.  Is it a matter of 'perfection'
> that is the issue here, or actual correctness when applying the
> patches in order?

I see it as a matter of correctness since in a given BKCVS changeset
(i.e. revision in the ChangeSet,v file) you may miss files. You would
eventually get them, with the same log, but in a different patch. If
you don't care about this, you can call it 'perfection'.

At that time I thought about modifying cvsps to use the "(Logical
change ...)" string instead of time/date for grouping the files but I
realised it is easier with a shell script.

> (perhaps this has now been fixed).

There was no reply to this e-mail. It might have been fixed in the
meantime but I don't think the history was fixed as well.

-- 
Catalin


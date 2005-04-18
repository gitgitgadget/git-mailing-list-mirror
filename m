From: David Mansfield <david@cobite.com>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 18:41:38 -0400
Message-ID: <426437A2.7080903@cobite.com>
References: <20050416131528.GB19908@elte.hu> <tnx4qe49z4h.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 00:38:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNes9-00022Y-E3
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVDRWln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVDRWlm
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:41:42 -0400
Received: from iris.cobite.com ([208.222.83.2]:58571 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S261178AbVDRWlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 18:41:40 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 325F597D59; Mon, 18 Apr 2005 18:41:37 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22220-08; Mon, 18 Apr 2005 18:41:37 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id EE889987DD; Mon, 18 Apr 2005 18:41:36 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id EB49097D59; Mon, 18 Apr 2005 18:41:35 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <tnx4qe49z4h.fsf@arm.com>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> 
>>i've converted the Linux kernel CVS tree into 'flat patchset' format, 
>>which gave a series of 28237 separate patches. (Each patch represents a 
>>changeset, in the order they were applied. I've used the cvsps
>>utility.)
> 
> 
> AFAIK, cvsps uses the date/time to create the changesets. There is a
> problem with the BKCVS export since some files in the same commit can
> have a different time (by an hour). I posted a mail some time ago
> about this - 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110026570201544&w=2
> 
> I read that the old history won't be merged into the new repository
> but, if you are interested, I have a script that can do this based on
> the "(Logical change ...)" string in the file commit logs and it is
> quite fast at generating the patches.
> 

Hmmm.  I read that message just now.  Is it a matter of 'perfection' 
that is the issue here, or actual correctness when applying the patches 
in order?

(perhaps this has now been fixed).



David


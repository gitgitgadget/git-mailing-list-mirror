X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Sat, 16 Dec 2006 01:58:35 -0800
Message-ID: <7vejr0i2lw.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 09:58:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 13 Dec 2006 13:35:08 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34603>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvWJW-0003qv-AB for gcvg-git@gmane.org; Sat, 16 Dec
 2006 10:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965400AbWLPJ6k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 04:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965383AbWLPJ6j
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 04:58:39 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:41043 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965400AbWLPJ6j (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 04:58:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216095835.NIAK25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 04:58:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zMxv1V00L1kojtg0000000; Sat, 16 Dec 2006
 04:57:56 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

>> I am hoping that we can start a stabilization cycle for v1.5.0
>> based on what we have in 'master'.  The theme is "usability and
>> teachability".
>> 
>> Things that need to be done to complete what have been merged to
>> 'master' are:
>> 
>>  - 'git-rm' needs to be fixed up as Linus outlined; remove
>>    working tree file and index entry but have a sanity check to
>>    make sure the working tree file match the index and HEAD.
>> 
>>  - 'git-branch' may need to be taught about renaming the
>>    matching per-branch configuration at the same time.
>> 
>>  - 'git-merge-file' needs to be documented and linked from
>>    git.txt.
>> 
>>  - 'git-clone' probably should be updated to use wild-card in
>>    remote.origin.fetch, instead of listing all the branches it
>>    found when the clone was made.
>> 
>>  - tutorials and other Porcelain documentation pages need to be
>>    updated to match the updated 'git-add' and 'git-rm' (to be
>>    updated), and their description should be made much less
>>    about implementation; they should talk in terms of end-user
>>    workflows.  I will send a draft for 'git diff' out later, but
>>    somebody needs a full sweep on Porcelain-ish documentation.
>> 
>>  - 'git diff --index' patch should be reverted (already done in
>>    'next'), although we may have to come up with a better
>>    wording for --cached.

I'm done with 2 out of the above six ("diff --index", and
"clone") and a bit of the "documentation" item so far, and will
go to bed now.  Any takers for the remaining tasks while I'll be
sleeping ;-)?





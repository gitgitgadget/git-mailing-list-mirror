From: Andreas Ericsson <ae@op5.se>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 11:11:29 +0200
Message-ID: <48D8B2C1.5070800@op5.se>
References: <20080922155749.c8070681.stephen@exigencecorp.com>	<20080922231927.ef18f420.stephen@exigencecorp.com>	<48D88813.9060400@viscovery.net>	<20080923024653.a3bb8666.stephen@exigencecorp.com>	<48D8A6EA.4020805@op5.se> <20080923040302.c4d0d33b.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 11:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki3ws-0002AP-9A
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 11:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbYIWJLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 05:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbYIWJLf
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 05:11:35 -0400
Received: from mail.op5.se ([193.201.96.20]:59891 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbYIWJLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 05:11:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 53CFD24B0D2A;
	Tue, 23 Sep 2008 11:02:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.313
X-Spam-Level: 
X-Spam-Status: No, score=-4.313 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.086, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H-kQKZlVjqst; Tue, 23 Sep 2008 11:02:00 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B826F24B0D29;
	Tue, 23 Sep 2008 11:02:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080923040302.c4d0d33b.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96541>

Stephen Haberman wrote:
>>>  ---A--B--C--D           <-- origin/stable
>>>      \       |
>>>       E--F   |           <-- origin/topica
>>>           \  |
>>>              g--h        <-- topica
>>>
>>> All the upper case commits have been published to origin. Other
>>> devs, etc., know about them, their hashes are in the bug tracking
>>> system.
>>>
>>> I'm bringing topica up to date, but with a merge because I have
>>> published history already on topica, so I merge stable and get a
>>> new merge commit: g. And maybe make another change: h.
>>>
>> Why do you merge stable at this point?
> 
> Good question--I appreciate the sanity check.
> 
> I merged stable because we had a new release of the software. E.g.
> A=1.0, B=1.1, C=1.2, and finally D=1.3.
> 
> So, topica is a new feature, "Add widgets/whatever", but it's not ready
> for stable (production) yet, so, yes, I think it is a topic branch.
> 
> However, D=1.4 is now out the door, I've had two commits E and F on
> topica that I had already committed and pushed out for code review, our
> email list, and our bug tracker, and now, post-1.4, qa wants to see
> topica up and running to see if it's good enough to go into the next
> release.
> 
> If our deployment guy pushes out F, qa is going to (and did) complain
> that they're not seeing the latest features from 1.4 in topica.
> 
> As you said, integration testing.
> 
> Okay, so I merge g, however, I really want to push it back out so that
> the deployment guy can push it to qa (he would rather not resolve my
> conflicts by making his own local g). And even if I did the deployment
> myself, locally against g, I would prefer to share g in case another
> dev working on the same topic gets feedback about funkiness from qa and
> would like to see the code as it is in qa. E.g.: g.
> 
> I can appreciate that if I was doing integration testing all by myself,
> with only automated tests, I could throw g away. However, even then, I
> would prefer to push g out and let our integration server run the tests
> for me.
> 
> Does this sound reasonable?
> 

It sounds very reasonable indeed, but then I don't understand why you
held off pushing the merge.

That's beside the point though, as I firmly believe git should be more
helpful in this situation. If "git rebase -i -p" doesn't help you fix
the problems, I'll see what I can do to help.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

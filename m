From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4.4
Date: Sun, 09 Mar 2008 17:42:45 -0400
Message-ID: <47D459D5.2020101@garzik.org>
References: <7vr6f31iwj.fsf@gitster.siamese.dyndns.org> <7vr6eknpjf.fsf@gitster.siamese.dyndns.org> <47D416C8.1020903@garzik.org> <7v1w6jod54.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 22:43:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYTJ9-0007P9-Rc
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 22:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbYCIVmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 17:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbYCIVmu
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 17:42:50 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:46002 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbYCIVmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 17:42:49 -0400
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JYTI6-0007c1-4V; Sun, 09 Mar 2008 21:42:47 +0000
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <7v1w6jod54.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.4 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76673>

Junio C Hamano wrote:
> Jeff Garzik <jeff@garzik.org> writes:
> 
>> Junio C Hamano wrote:
>>> The latest maintenance release GIT 1.5.4.4 is available at the
>>> usual places:
>>>
>>>   http://www.kernel.org/pub/software/scm/git/
>>>
>>>   git-1.5.4.4.tar.{gz,bz2}			(tarball)
>>>   git-htmldocs-1.5.4.4.tar.{gz,bz2}		(preformatted docs)
>>>   git-manpages-1.5.4.4.tar.{gz,bz2}		(preformatted docs)
>>>   RPMS/$arch/git-*-1.5.4.4-1.$arch.rpm	(RPM)
>> Does it address the following issue, present in git-core-1.5.4.1-1.fc8?
>>
>> http://marc.info/?l=git&m=120423022832530&w=2
> 
> I do not think so.
> 
> Is it really an issue, or is it just a warning message unread/unfollowed?

It's not a warning message, it is an annoying delay that has been added 
to almost -every- local pull, impacting my main kernel workflow.

Further -- as my email demonstrated with examples -- it would repeatedly 
'git gc' on the same repository over and over again, for each 'git pull' 
or 'git rebase' that I did.  That is overly excessive.


> I am comparing the last line you quoted from the command output in that
> message, which suggests the user to run 'git prune', and your comment on
> the next line in that message that says "I regularly run 'git gc'", and
> scratching my head.  I cannot tell if you regularly run 'git prune' or not
> from it...

Yes, I regularly run both 'git gc' and 'git prune'.

But since (ref original email) I was doing some rebasing, there are 
inevitably changesets left dangling after such an operation.

	Jeff

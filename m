From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Mon, 7 Jul 2008 23:24:23 -0400
Message-ID: <35BBB0D4-B3E1-4097-AF11-E0F6223125EA@silverinsanity.com>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com> <7v7iby9ucx.fsf@gitster.siamese.dyndns.org> <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com> <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org> <7vod591hlp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 05:25:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG3pj-0002yU-VO
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 05:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbYGHDYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 23:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756038AbYGHDYa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 23:24:30 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59528 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbYGHDY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 23:24:29 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 2CE8B1FFC023;
	Tue,  8 Jul 2008 03:24:16 +0000 (UTC)
In-Reply-To: <7vod591hlp.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87693>


On Jul 7, 2008, at 5:58 PM, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> And to answer your "git rebase --onto this from that-branch"  
> question, I
> think ORIG_HEAD should record the tip of that-branch before rebase  
> takes
> place, not the commit you happened to be at before running it.   
> Switching
> branch to that-branch is not the drastic and unforseeable part.  The
> drastic and unforseeable change is rebasing and seeing that the  
> rebased
> result does not work with the new upstream `from`, and the user  
> would want
> to have a way to quickly rewind the tip of the branch back to the  
> state
> before the rebase.  The new paragraph added by this patch should  
> hopefully
> make this reasoning more clear.

I just wanted to make sure there was a clear reasoning and to see if  
someone could word it clearly, as I was getting a little cross-eyed.

> -- >8 --
> Documentation: update sections on naming revisions and revision ranges
>
> Various *_HEAD pseudo refs were not documented in any central place.
> Especially since we may be teaching rebase and am to record ORIG_HEAD,
> it would be a good time to do so.

My only objection is to the "may".  ;-)

Also, perhaps we should either list the commands that set ORIG_HEAD,  
or add a note to that effect in their manpages.  I'll see what wording  
I can come up with, unless you (or someone else) gets to it first of  
course.

> While at it, reword the explanation on r1..r2 notation to reduce
> confusion.

Looks good.

~~ Brian

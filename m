From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Wed, 25 Jun 2008 12:59:59 +0300
Message-ID: <4862171F.6070505@panasas.com>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <7vr6al3m24.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 12:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBRp0-0003th-J9
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 12:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbYFYKAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 06:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754439AbYFYKAb
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 06:00:31 -0400
Received: from gw-colo-pa.panasas.com ([66.238.117.130]:1721 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753673AbYFYKAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 06:00:30 -0400
Received: from daytona.int.panasas.com (daytona.int.panasas.com [172.17.28.41])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id m5PA0IcX023920;
	Wed, 25 Jun 2008 06:00:19 -0400
Received: from bh-buildlin2.bhalevy.com ([172.17.28.123]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Jun 2008 06:00:02 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <7vr6al3m24.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 25 Jun 2008 10:00:02.0926 (UTC) FILETIME=[3C9548E0:01C8D6AA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86265>

Junio C Hamano wrote:
> Boaz Harrosh <bharrosh@panasas.com> writes:
> 
>> Junio C Hamano wrote:
>>
>>> "reset --hard" has *ALWAYS* meant to be destructive --- discarding
>>> potential local cruft is the whole point of the operation.
>> I was under the impression that --hard means working-directory-also
>> as opposed to tree-and-index-only. Nothing to do with 
>> destructive-discarding.
> 
> Then you should revise your impression, as it is simply *WRONG*.  When
> I say something about history of git, I know what I am talking about ;-)
> 
> Reset has been about nuking local changes from the very beginning.  That
> is why it removes MERGE_HEAD, rr-cache/MERGE_RR as well as removing
> conflicted stages in the index and reverts local changes from the worktree.
> 
> It is "my worktree state is a mess, and I cannot even describe nor care
> which paths are dirty --- just get rid of the local changes so that I can
> start working cleanly from a checkout of HEAD".

OK Thanks, I see.

I have made myself that git-move-head script that uses checkouts and
renames so I guess I'm happy. I used to use the --hard as a shortcut.

Boaz

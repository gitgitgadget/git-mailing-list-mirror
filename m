From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cloning from a repo without "current branch"
Date: Wed, 20 Jun 2007 15:29:39 -0700
Message-ID: <7vwsxy5kfg.fsf@assigned-by-dhcp.pobox.com>
References: <200706162226.l5GMQBss004492@mi0.bluebottle.com>
	<7vbqff1c3w.fsf@assigned-by-dhcp.pobox.com>
	<200706202150.l5KLoHkE002843@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 00:29:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I18gI-0007UA-3t
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 00:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbXFTW3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 18:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbXFTW3l
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 18:29:41 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43722 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbXFTW3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 18:29:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070620222940.JXQE2558.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Jun 2007 18:29:40 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DyVe1X00L1kojtg0000000; Wed, 20 Jun 2007 18:29:39 -0400
In-Reply-To: <200706202150.l5KLoHkE002843@mi0.bluebottle.com> (Nanako
	Shiraishi's message of "Wed, 20 Jun 2007 14:50:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50577>

Nanako Shiraishi <nanako3@bluebottle.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Nanako Shiraishi <nanako3@bluebottle.com> writes:
>> 
>> > diff --git a/git-clone.sh b/git-clone.sh
>> >  	?*)
>> 
>> Whitespace breakage?
>> 
>> > @@ -384,21 +391,20 @@ then
>> >  		git-config branch."$head_points_at".merge
>> > "refs/heads/$head_points_at"
>> > +		;;
>> 
>> Again...?
>
> Sorry, I'll re-send from a different mail addr.
> Is it alright to send attachments?

Well, the breakage was trivial enough to fix at my end; no need
to resend.

Thanks for your patch; it is a real fix (well, at least one of
the necessary ones) to a breakage we discussed on the list
recently.

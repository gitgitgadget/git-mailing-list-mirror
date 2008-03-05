From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Wed, 05 Mar 2008 14:51:23 -0800
Message-ID: <7v1w6olr84.fsf@gitster.siamese.dyndns.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
 <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>
 <alpine.LSU.1.00.0802281159550.22527@racer.site>
 <200803052221.12495.johannes.sixt@telecom.at>
 <alpine.LSU.1.00.0803052317350.15786@racer.site>
 <7vir00lski.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803052327570.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:52:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX2T7-00067T-OX
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 23:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763633AbYCEWvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 17:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763470AbYCEWvb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 17:51:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763153AbYCEWva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 17:51:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 40BA619C0;
	Wed,  5 Mar 2008 17:51:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 77654193A; Wed,  5 Mar 2008 17:51:25 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803052327570.15786@racer.site> (Johannes
 Schindelin's message of "Wed, 5 Mar 2008 23:28:15 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76283>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I think Reviewed-by: would indeed be a very good addition to our
>> patch flow convention, borrowing from the kernel folks.
>
> You mean you have more people to blame, then? ;-)

No.  The procedure would help me keep my impatience from making
me merge patches that have not been adequately reviewed on the
list.

Recently, I ended up wasting two nights because I was not
careful enough earlier, when I was short of time and apparent
backlog was beginning to get larger and larger.

I queued some patches from the backlog to 'next' saying "ah,
they look good enough, people will notice breakages anyway," but
the breakage was not caught until 'master' got broken.

Not good.  And the list is not to blame.

By merging to 'next' I am sending a message that I think they
have been adequately reviewed (either by me or by people whose
judgement I trust), so I shouldn't have applied them to 'next'
in the first place.  I instead should have ignored them, and
waited until I had enough time and concentration to properly
review them.  Or until somebody else did --- by that time,
hopefully other people might have commented on them, saying
"these look all ok to me", or "ah that's crap".

These wasted two nights was all my fault, and as a result, there
are more patches on the list archive that I have seen (notice I
did not say "have read") that are unapplied.

As to those "more patches on the list that are unapplied", I'll
keep them unapplied for now, until there are positive feedbacks
on them.

The positive feedback may come from myself.  I am not saying I
will stop reviewing and/or applying patches nobody else
commented on.

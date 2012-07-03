From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] add test case for rebase of empty commit
Date: Tue, 3 Jul 2012 19:40:48 -0400
Message-ID: <20120703234048.GA10224@neilslaptop.think-freely.org>
References: <1340814121-23813-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vr4t079jp.fsf@alter.siamese.dyndns.org>
 <20120703182000.GB10864@hmsreliant.think-freely.org>
 <7vtxxovfec.fsf@alter.siamese.dyndns.org>
 <20120703203136.GC10864@hmsreliant.think-freely.org>
 <7vpq8ctune.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 01:41:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmCiN-0006xY-M4
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 01:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab2GCXk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 19:40:58 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:43568 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2GCXk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 19:40:57 -0400
Received: from neilslaptop.think-freely.org ([2001:470:8:a08:4a5d:60ff:fe96:79da] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SmCiA-0000no-6Y; Tue, 03 Jul 2012 19:40:52 -0400
Content-Disposition: inline
In-Reply-To: <7vpq8ctune.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200976>

On Tue, Jul 03, 2012 at 02:13:57PM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > On Tue, Jul 03, 2012 at 12:00:27PM -0700, Junio C Hamano wrote:
> >> 
> >> The changelog might be similar or textually identical, but it is
> >> entirely a different matter if it makes sense taken out of the
> >> context (i.e. cherry-picked).  So I would personally do not bother
> >> "filtering" about them too much---if you ask for empties, you will
> >> get all empties.
> >> 
> > Ok, copy that.
> 
> That was somewhat unexpected, though ;-) It was 30% tongue-in-cheek
> comment.  People who want to keep the empty commits in the history
> may want some filtering. As I am not among them, I do not think of
> anything useful (other than "filter all empty ones away", that is).
> 
> 
I understand what you're saying (for the record, I'm ok with the duplicates, to
be fixed up at a later date, as opposed to dropping them all). But the fact
remains, theres not obvious differentiator, other than some fuzzy search on the
changelog we can use to differentiate empty commits.  Let me think about it some
more, maybe theres some sort of policy specification we can make regarding the
changelog that would let us intellegently filter empty commits appropriately.
Best
Neil

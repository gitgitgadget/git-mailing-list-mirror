From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] Simplify and fix --first-parent implementation
Date: Sat, 26 Apr 2008 13:59:56 +0200
Message-ID: <20080426115956.GB19558@cuci.nl>
References: <20080425234556.D60FD5461@aristoteles.cuci.nl> <7viqy5o4om.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 14:00:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpj5F-00061y-Fu
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 14:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbYDZL76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 07:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbYDZL76
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 07:59:58 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:51836 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYDZL76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 07:59:58 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 01052545E; Sat, 26 Apr 2008 13:59:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7viqy5o4om.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80370>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>> ---
>No explanation of what the patch does, nor justification of why it is a
>good change?

Sorry, thought that one-line description was enough.  I'll resubmit this
one more verbosely.

>Please also sign your patch.

Just with git-commit -s ?  Or do I need to get gpg involved?

>The original code makes sure all the parents of the given commits are
>marked as SEEN (and SYMMETRIC_LEFT if needed), even when only it traverses
>the first parent.  By leaving the loop early, you are changing the
>semantics of the code.  Other parents, when reached from other paths while
>traversing the commit ancestry chain, will behave differently between the
>version with your patch and without.

Yes, I was and am aware of that.  The previous behaviour appears to be bogus.
I'll elaborate on resubmission.

P.S. No reaction on the other patches means that they're accepted, or do
I need to resubmit them as well (signed)?
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.

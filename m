From: Sergei Organov <osv@javad.com>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Thu, 01 Nov 2007 15:13:32 +0300
Message-ID: <87ve8m2mfn.fsf@osv.gnss.ru>
References: <87d4uv3wh1.fsf@osv.gnss.ru>
	<20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0710312111170.4362@racer.site>
	<7vhck7gdzs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 13:14:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYwM-0002oR-96
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 13:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118AbXKAMOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbXKAMOL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:14:11 -0400
Received: from javad.com ([216.122.176.236]:4639 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbXKAMOL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:14:11 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA1CDcm37776;
	Thu, 1 Nov 2007 12:13:38 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1InYvU-0000zW-2G; Thu, 01 Nov 2007 15:13:32 +0300
In-Reply-To: <7vhck7gdzs.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 31 Oct 2007 14\:39\:51 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62947>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Wed, 31 Oct 2007, Sergei Organov wrote:
>>
>>> Yes, and that's the problem. Why 'git --continue' didn't just skip this 
>>> patch that *already became no-op* after conflict resolution and forced 
>>> me to explicitly use 'git --skip' instead?
>>
>> Isn't that obvious?  To prevent you from accidentally losing a commit.
>
> In case it is not obvious...
>
> A rebase conflict resolution that results in emptiness is a
> rather rare event (especially because rebase drops upfront the
> identical changes from the set of commits to be replayed), but
> it does happen.

Funny how 2 of my first 3 commits suffer from this "rather rare event",
and it was not Friday, 13 ;)

-- 
Sergei.

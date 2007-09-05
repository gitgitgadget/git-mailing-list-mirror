From: David Kastrup <dak@gnu.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 10:16:49 +0200
Message-ID: <861wddedce.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 10:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISq4a-0004lN-GU
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbXIEIRM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755913AbXIEIRL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:17:11 -0400
Received: from main.gmane.org ([80.91.229.2]:58598 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbXIEIRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:17:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISq4L-0004KI-AK
	for git@vger.kernel.org; Wed, 05 Sep 2007 10:17:01 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 10:17:01 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 10:17:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> (Linus Torvalds's message of "Wed\, 5 Sep 2007 00\:09\:27 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:1Iv+tf/Nd3EJbsNAy8LCk0zlSAc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57684>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Now, it may be that James didn't realize how important the
> occasional garbage collect is exactly *because* he is an old-timer
> and used BK long before he used git, and just continued using git
> simply as a BK replacement, but it did make me wonder whether maybe
> this lack of repacking awareness is fairly common.
>
> I've been against automatic repacking, but that was really based on
> what appears to be potentially a very wrong assumption, namely that
> people would do the manual repack on their own. If it turns out that
> people don't do it, maybe the right thing for git to do really is to
> at least notify people when they have way too many pack-files and/or
> loose objects.
>
> I personally repack everything way more often than is necessary, and
> I had kind of assumed that people did it that way, but I was
> apparently wrong.  Comments?

Can it be that getting rid of unused objects is harder once they are
packed?  If that is the case, an automatic pack while mucking about
with temporary branches and/or confidential files would be quite a
nuisance.

Automatic packing maybe would be acceptable if packing was really
transparent to what you do with your repo (including janitoring work).
And it would be nice if automatic packing could be done in an
incremental manner, not bogging down normal work.

-- 
David Kastrup

From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 18:43:48 +0200
Message-ID: <20080912164348.GC2915@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org> <20080912054739.GB22228@cuci.nl> <20080912145802.GV5082@mit.edu> <20080912155427.GB2915@cuci.nl> <20080912161911.GA12096@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:45:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeBlR-0007UM-Uj
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 18:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbYILQnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 12:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYILQnu
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 12:43:50 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:47230 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbYILQnt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 12:43:49 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 86BCC5465; Fri, 12 Sep 2008 18:43:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080912161911.GA12096@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95751>

Jeff King wrote:
>On Fri, Sep 12, 2008 at 05:54:27PM +0200, Stephen R. van den Berg wrote:

>> True.  But repopulating this cache after cloning means that you have to
>> calculate the patch-id of *every* commit in the repository.  It sounds
>> like something to avoid, but maybe I'm overly concerned, I have only a
>> vague idea on how computationally intensive this is.

>For a rough estimate, try:

>  time git log -p | git patch-id >/dev/null

On my system that results in 2ms per commit on average.  Not huge, but
not small either, I guess.  Running it results in real waiting time, it
all depends on how patient the user is.
-- 
Sincerely,
           Stephen R. van den Berg.

"Father's Day: Nine months before Mother's Day."

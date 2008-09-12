From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 22:56:18 +0200
Message-ID: <20080912205618.GA8711@cuci.nl>
References: <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org> <20080912054739.GB22228@cuci.nl> <20080912145802.GV5082@mit.edu> <20080912155427.GB2915@cuci.nl> <20080912161911.GA12096@coredump.intra.peff.net> <20080912164348.GC2915@cuci.nl> <20080912184406.GB5082@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Sep 12 22:57:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeFhy-0002zd-4o
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 22:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759097AbYILU4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 16:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757588AbYILU4V
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 16:56:21 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:49290 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760568AbYILU4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 16:56:19 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 4E2C05465; Fri, 12 Sep 2008 22:56:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080912184406.GB5082@mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95762>

Theodore Tso wrote:
>On Fri, Sep 12, 2008 at 06:43:48PM +0200, Stephen R. van den Berg wrote:
>> On my system that results in 2ms per commit on average.  Not huge, but
>> not small either, I guess.  Running it results in real waiting time, it
>> all depends on how patient the user is.

>For a local clone, git could be taught to copy the cache file.  For a
>network-based clone, the percentage of time needed to download is
>roughly 2-3 times that (although that will obviously depend on your
>network connectivity).  Building this cache can be done in the
>background, though, or delayed until the first time the cache is
>needed.

Fair enough.  If noone beats me to it, I'll probably take a stab at
implementing something like this and see how it fares for my own
application.
-- 
Sincerely,
           Stephen R. van den Berg.

"Father's Day: Nine months before Mother's Day."

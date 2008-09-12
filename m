From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 07:47:39 +0200
Message-ID: <20080912054739.GB22228@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 07:48:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke1WS-000894-Oc
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 07:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbYILFrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 01:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbYILFrl
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 01:47:41 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:55936 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbYILFrk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 01:47:40 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id EF2B85467; Fri, 12 Sep 2008 07:47:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95685>

Linus Torvalds wrote:
>On Fri, 12 Sep 2008, Sam Vilain wrote:
>It can happen even without any conflicts, just because the context 
>changed. So it really isn't about merge conflicts per se, just the fact 
>that a patch can change when it is applied in a new area with a three-way 
>diff - or because it got applied with fuzz.

Quite.

>You could add it as a 

>	Original-patch-id: <sha1>

That will probably work fine when operating locally on (short) temporary
branches.

It would probably become computationally prohibitive to use it between
long lived permanent branches.  In that case it would need to be
augmented by the sha1 of the originating commit.  Which gives you two
hashes as reference, and in that case you might as well use the two
commit hashes of which the difference yields the patch.
-- 
Sincerely,
           Stephen R. van den Berg.

"Father's Day: Nine months before Mother's Day."

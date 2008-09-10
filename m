From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 07:42:44 +0200
Message-ID: <20080910054244.GB15715@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 07:43:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdIUa-0006Dt-Go
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 07:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbYIJFmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 01:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbYIJFmq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 01:42:46 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:55825 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbYIJFmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 01:42:45 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id C97055465; Wed, 10 Sep 2008 07:42:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95484>

Linus Torvalds wrote:
>On Wed, 10 Sep 2008, Stephen R. van den Berg wrote:

>> As you might have noticed, the actual process of pulling/fetching
>> explicitly does *not* pull in the objects being pointed to.

>.. which makes them _local_ data, which in turn means that they should not 
>be in the object database at all.

>IOW, i you want this for local reasons, you should use a local database, 
>like the index or the reflogs (and I don't mean "like the index" in the 
>sense that it would look _anything_ like that file, but in the sense that 
>it's a purely local thing and doesn't show up in the object database).

But then how would someone who clones the repository get at the information?
The information is essential to understand backports between the various
stable branches.

The origin links describe the evolving state of a patch (i.e. just like
regular commits/parents store snapshots of the whole tree, the origin
links store snapshots of a patch as it evolves through time).
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"

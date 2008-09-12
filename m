From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 10:40:27 +0200
Message-ID: <20080912084027.GB15391@cuci.nl>
References: <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org> <20080911192356.GC1451@cuci.nl> <alpine.LFD.1.10.0809111534300.23787@xanadu.home> <20080911195516.GE1451@cuci.nl> <20080911210118.GO5082@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Sep 12 10:41:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke4Dt-00026F-2r
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 10:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbYILIka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 04:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbYILIka
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 04:40:30 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:38894 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbYILIk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 04:40:29 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id D05D45465; Fri, 12 Sep 2008 10:40:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080911210118.GO5082@mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95692>

Theodore Tso wrote:
>On Thu, Sep 11, 2008 at 09:55:16PM +0200, Stephen R. van den Berg wrote:
>> >  Having it versionned also 
>> >means that older git versions will be able to carry that information 
>> >even if they won't make any use of it, and that also solves the 
>> >cryptographic issue since that data is part of the top commit SHA1.

>> It would allow the data to be faked, that is undesirable for "git blame".

>Why would this matter?  The information is largely
>self-authenticating.  If a commit claims to have come from some other

Attack-wise, you're right, it's not a big deal.
I think the comforting feeling one gets about the hashes protecting
integrity is what matters more for me here.
-- 
Sincerely,
           Stephen R. van den Berg.

"Father's Day: Nine months before Mother's Day."

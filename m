From: Junio C Hamano <junkio@cox.net>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Thu, 05 Apr 2007 14:18:58 -0700
Message-ID: <7vodm2o6yl.fsf@assigned-by-dhcp.cox.net>
References: <17940.59514.150325.738141@lisa.zopyra.com>
	<20070405134954.GA18402@coredump.intra.peff.net>
	<17941.655.192938.792088@lisa.zopyra.com>
	<20070405204604.GA24779@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 23:19:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZZME-0000p6-PB
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 23:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767311AbXDEVTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 17:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767312AbXDEVTA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 17:19:00 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52693 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767311AbXDEVS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 17:18:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405211859.LNAO25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 17:18:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jZJy1W00E1kojtg0000000; Thu, 05 Apr 2007 17:18:58 -0400
In-Reply-To: <20070405204604.GA24779@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Apr 2007 16:46:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43857>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 05, 2007 at 09:07:11AM -0500, Bill Lear wrote:
>
>> Here is the local:
>> 
>> [core]
>>         repositoryformatversion = 0
>>         filemode = true
>>         bare = false
>>         logallrefupdates = true
>> [remote "origin"]
>>         url = ssh://poire/home/jml/repos/new/fusion
>>         fetch = +refs/heads/*:refs/remotes/origin/*
>> [branch "master"]
>>         remote = origin
>>         merge = refs/heads/master
>
> I don't see anything there that should cause branches under refs/remotes
> to be pushed. Was he using 'git-push --all' by any chance?

IIRC "git push" without explicit refspecs push the matching
refs, but I am a bit under the weather and feverish, so don't
take my word literally but look at git-push manual page please.

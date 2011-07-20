From: david@lang.hm
Subject: Re: Git commit generation numbers
Date: Wed, 20 Jul 2011 16:26:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1107201624510.5222@asgard.lang.hm>
References: <20110720221632.14223.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: nico@fluxnic.net, anthonyvdgent@gmail.com, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 01:26:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjgAI-0003IS-8T
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 01:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713Ab1GTX0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 19:26:49 -0400
Received: from mail.lang.hm ([64.81.33.126]:55065 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab1GTX0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 19:26:48 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p6KNQcP1006335;
	Wed, 20 Jul 2011 16:26:39 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20110720221632.14223.qmail@science.horizon.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177562>

On Wed, 20 Jul 2011, George Spelvin wrote:

>> The alternative of having to sometimes use the generation number,
>> sometimes use the possibly broken commit date, makes for much more
>> complicated code that has to be maintained forever.  Having a solution
>> that starts working only after a certain point in history doesn't look
>> eleguant to me at all.  It is not like having different pack formats
>> where back and forth conversions can be made for the _entire_ history.
>
> It seemed like a pretty strong argument to me, too.

except that you then have different caches on different systems. If the 
generation number is part of the repository then it's going to be the same 
for everyone.

in either case, you still have the different heristics depending on what 
version of git someone is running

David Lang

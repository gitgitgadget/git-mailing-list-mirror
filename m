From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 11:23:10 -0700
Message-ID: <4FA41E8E.20900@palm.com>
References: <86mx5rmx32.fsf@red.stonehenge.com> <4FA055D0.7040102@palm.com> <86aa1rmvhb.fsf@red.stonehenge.com> <4FA05E9F.9090709@palm.com> <CAJsNXTmo1B86nSm7u923jJuGX0zajz3iqVu-onANMN-5BE5DfQ@mail.gmail.com> <4FA2D1D7.3020807@palm.com> <CA+7g9JzZ36RgsniT4UN0Zk+z1ohZYW5u+0AoGMjJZqsoBjqvqA@mail.gmail.com> <4FA2D97A.8090504@palm.com> <86ipgdhvjo.fsf@red.stonehenge.com> <4FA2F013.3020904@palm.com> <20120504155606.GB30130@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Nathan Gray <n8gray@n8gray.org>,
	PJ Weisberg <pj@irregularexpressions.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
X-From: git-owner@vger.kernel.org Fri May 04 20:23:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQNA7-0002DW-KR
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 20:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab2EDSXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 14:23:23 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:48533 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab2EDSXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 14:23:22 -0400
X-IronPort-AV: E=Sophos;i="4.75,532,1330934400"; 
   d="scan'208";a="13316545"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 04 May 2012 11:23:22 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q44IN9Xr020498;
	Fri, 4 May 2012 11:23:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120504155606.GB30130@sirena.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197046>

On 5/4/12 08:56 , Mark Brown wrote:
> On Thu, May 03, 2012 at 01:52:35PM -0700, Rich Pixley wrote:
>
>> It's not just hg.  It's other source code control systems as well.
>> Check out any of the other daggy guys.  So sure, I'll admit a bias
>> for current technology over older tech.
>
> I'm still not sure what's missing here without a central server?   The
> other DVCSs I've used (which don't include hg) do require that the user
> trigger a merge operation somehow; they don't magically go and merge
> things without being asked.

Nor does hg.  Rather, it allows the collision to be tracked within the 
source code control tool so that anyone who wants to see it can do so, 
and so that anyone who wants to merge it can do so.  The data flow paths 
for collisions and proposed changes can follow precisely the same paths 
as any other code changes.  No meta channel is required.

This is a different situation from either the one where I, specifically 
me, must merge or the one where I intend my changes to stay separated 
from other development, (a new "branch").  The situation with multiple 
heads allows the merge, the branch, even the decision about whether to 
merge or branch, to be delayed indefinitely.

The fact that it allows for this also allows for a number of different 
repository network architectures, all of which are blocked in git 
because of the push problem.  In git, those decisions must be made 
_before_ the push.

There's also a possibility of nonterminating merges.  That is, if my 
team is making changes faster than you can merge them, then you'll never 
get to push your changes.  With dual heads, you still can.  And then 
anyone who wants to can merge them.

--rich

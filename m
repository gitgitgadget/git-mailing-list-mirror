From: alex@bellandwhistle.net
Subject: Re: gitignore vs. exclude vs =?UTF-8?Q?assume-unchanged=3F?=
Date: Thu, 17 Apr 2014 17:36:56 -0700
Message-ID: <4dd8389939fbf3dc77b58adcca7b17c1@bellandwhistle.net>
References: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>
 <xmqqy4z5go1y.fsf@gitster.dls.corp.google.com>
 <dee7ee673c8c4d81fb5aaecea25e9709@bellandwhistle.net>
 <20140416234555.GA4309@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 02:37:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wawnk-0006ux-60
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 02:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbaDRAhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 20:37:04 -0400
Received: from selene.fortifiedserver.net ([98.158.151.224]:56798 "EHLO
	selene.fortifiedserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750893AbaDRAhC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2014 20:37:02 -0400
Received: from localhost.uu.net ([127.0.0.1]:46216 helo=selene.fortifiedserver.net)
	by selene.fortifiedserver.net with esmtpa (Exim 4.82)
	(envelope-from <alex@bellandwhistle.net>)
	id 1WawnZ-0000Ye-2B; Thu, 17 Apr 2014 17:36:57 -0700
In-Reply-To: <20140416234555.GA4309@google.com>
X-Sender: alex@bellandwhistle.net
User-Agent: Roundcube Webmail/0.9.5
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - selene.fortifiedserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bellandwhistle.net
X-Get-Message-Sender-Via: selene.fortifiedserver.net: authenticated_id: alex@bellandwhistle.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246461>

On 2014-04-16 16:45, Jonathan Nieder wrote:
> Hi,
> 
> alex@bellandwhistle.net wrote:
> 
>> In particular, 'exclude' is spottily documented.
> 
> Where did you expect to read about it?  I see some mention of
> .git/info/exclude in the gitignore(5) page, but I wouldn't be
> surprised if there's room for improvement there (improvements
> welcome).

I suppose I might consider amending the opening sentence at:

http://git-scm.com/docs/gitignore

from:

"A gitignore file specifies intentionally untracked files that Git 
should ignore."

to something that makes the point earlier about the similarity:

"Both gitignore and $GIT_DIR/info/exclude files specify intentionally 
untracked files that Git should ignore."

or:

"Like the $GIT_DIR/info/exclude file, gitignore files specify 
intentionally untracked files that Git should ignore. The difference is 
that files matched by a pattern in a gitignore file will be untracked 
for all users of the repository."

or somesuch.

The other thing is that there is no warning in the docs that 
assume-unchanged is not an absolute promise to ignore. This is news to 
me. I don't see this anywhere. I understand now that the use case is 
performance, but that could be clearer.

thanks again
Alex

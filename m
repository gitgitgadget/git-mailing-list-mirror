From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 09:46:32 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0806130946060.8043@alchemy.localdomain>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com> <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 15:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K79dL-0006d7-Sm
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 15:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbYFMNqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 09:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbYFMNqj
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 09:46:39 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:50898 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753050AbYFMNqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 09:46:38 -0400
Received: from alchemy (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id C74F2A0127;
	Fri, 13 Jun 2008 09:48:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by alchemy (Postfix) with ESMTPS id E405F6CCD3;
	Fri, 13 Jun 2008 06:46:32 -0700 (PDT)
X-X-Sender: paulproteus@alchemy.localdomain
In-Reply-To: <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84875>

On Fri, 13 Jun 2008, Denis Bueno wrote:

> On Fri, Jun 13, 2008 at 09:26, Denis Bueno <dbueno@gmail.com> wrote:
>> That line simply calls perl by the $PERL variable, which is set at the
>> top of the script, like so:
>>
>>    PERL='/usr/bin/env perl'
>>
>> If I change this line to point to my perl directly, it works.  On a
>> hunch, I changed it to:
>>
>>    PERL="/usr/bin/env perl"  # note the double-quotes
>
> [snip lies]
>
> Apparently I didn't test this thoroughly enough, and I was wrong.
> Changing the quotes has no effect.
>
> So git-instaweb only works for me if I manually specify my perl path.
> Can anyone think of why this might be?

Does OS X ship /usr/bin/env?

If you type "/usr/bin/env perl" in a Terminal window, do you get Perl?

-- Asheesh.

-- 
Hark ye, Clinker, you are a most notorious offender.  You stand convicted of
sickness, hunger, wretchedness, and want.
 		-- Tobias Smollet

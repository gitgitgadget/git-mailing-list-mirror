From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix the remote note the fetch-tool prints after storing a fetched reference
Date: Wed, 06 Jun 2007 12:28:51 -0700
Message-ID: <7vodjs3mrw.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com>
	<7v3b157b4j.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0706060142h2df41f11pa0157a360831736@mail.gmail.com>
	<7vps495uvs.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0706060427l1846bde7racabcfea5d15bdb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 21:30:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw1Dc-0000K9-Io
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 21:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbXFFT27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 15:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbXFFT27
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 15:28:59 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64484 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbXFFT25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 15:28:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606192850.EJPD9600.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 15:28:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8KUr1X00l1kojtg0000000; Wed, 06 Jun 2007 15:28:51 -0400
In-Reply-To: <81b0412b0706060427l1846bde7racabcfea5d15bdb4@mail.gmail.com>
	(Alex Riesen's message of "Wed, 6 Jun 2007 13:27:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49308>

"Alex Riesen" <raa.lkml@gmail.com> writes:

>> > Besides, I just noticed git-clone is broken WRT the .git
>> > as well: I can clone a "a.git" into "b" (and it ignores -l and -s!),
>> > but I can't fetch the "a" (aka "origin") being in "b". And of
>> > course, "origin" in "b" is setup as "/path/a", not "/path/a.git".
>>
>> This probably is worth fixing, independent from what the message
>> says before or after your patch.
>
> And "probably" means: it is broken, but this is ok?

No; it means "patches welcome".  Regardless of the patch you are
promoting, that would be a real fix.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-index-pack really does suck..
Date: Fri, 06 Apr 2007 15:55:10 -0700
Message-ID: <7vhcrti04x.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> <Pi
	ne.LNX.4.64.0704031413200.6730@woody.linux-foundation.org>
	<alpine.LFD.0.98. 0704031836350.28181@xanadu.home>
	<Pine.LNX.4.63.0704031532390.21680@qynat.qv tvafvgr.pbz>
	<81b0412b0704040251j34b0bc5eh1518eadcfa2ed299@mail.gmail.com> <P
	ine.LNX.4.63.0704061455380.24050@qynat.qvtvafvgr.pbz>
	<7vslbdi0hf.fsf@assign ed-by-dhcp.cox.net>
	<7vlkh5i0e7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0704061521320.24050@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 02:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZxKw-0001BA-9R
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 00:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933310AbXDFWzO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933313AbXDFWzO
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 18:55:14 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40807 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933310AbXDFWzM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 18:55:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070406225512.INJC27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 18:55:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id jyvA1W00F1kojtg0000000; Fri, 06 Apr 2007 18:55:11 -0400
In-Reply-To: <Pine.LNX.4.63.0704061521320.24050@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Fri, 6 Apr 2007 15:22:19 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43938>

David Lang <david.lang@digitalinsight.com> writes:

> On Fri, 6 Apr 2007, Junio C Hamano wrote:
>
>> Subject: Re: git-index-pack really does suck..
>>
>> Junio C Hamano <junkio@cox.net> writes:
>>
>>> David Lang <david.lang@digitalinsight.com> writes:
>>>
>>>> On Wed, 4 Apr 2007, Alex Riesen wrote:
>>>> ...
>>>>> You never know what pull is networked (or should I say: remote enough
>>>>> to cause a collision).
>>>>
>>>> so leave it on for all pulls, but for other commands don't turn it on.
>>>>
>>>> remember that the command that linus ran into at the start of the
>>>> thread wasn't a pull.
>>>
>>> Are you referring to this command
>>>
>>>  $ git index-pack --stdin --fix-thin new.pack < .git/objects/pack/pack-*.pack
>>>
>>> in this message?
>>
>>  From: Linus Torvalds <torvalds@linux-foundation.org>
>>  Subject: git-index-pack really does suck..
>>  Date: Tue, 3 Apr 2007 08:15:12 -0700 (PDT)
>>  Message-ID: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
>>
>> (sorry, chomped the message).
>
> probably (I useually don't keep the mail after I read or reply to it)

Well, then you should remember that the command linus ran into
was pretty much about pull, nothing else.

The quoted command was only to illustrate what 'git-pull'
invokes internally.  I do not think of any reason to use that
command for cases other than 'git-pull'.  What's the use case
you have in mind to run that command outside of the context of
git-pull?

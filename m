From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-branch.txt: document -f correctly
Date: Tue, 17 Mar 2009 17:46:22 +0100
Message-ID: <49BFD3DE.4030901@drmicha.warpmail.net>
References: <7vtz5ssk0s.fsf@gitster.siamese.dyndns.org> <1237298780-11304-1-git-send-email-git@drmicha.warpmail.net> <7vy6v4qf4o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:48:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjcSW-00084c-Kv
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996AbZCQQqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756233AbZCQQqj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:46:39 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:33758 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756851AbZCQQqi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 12:46:38 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 49AB62F38D2;
	Tue, 17 Mar 2009 12:46:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 17 Mar 2009 12:46:36 -0400
X-Sasl-enc: N4Nx5w870wKA6F0xsZr28ak4LWTiayCjSFDWmie9Z0j7 1237308395
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9AD3324869;
	Tue, 17 Mar 2009 12:46:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090317 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vy6v4qf4o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113503>

Junio C Hamano venit, vidit, dixit 17.03.2009 17:37:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> 'git branch -f a b' resets a to b when a exists, rather then deleting a.
>> Say so in the documentation.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> Something like this?
>>
>> BTW, I noticed that 'git-subcmd' is used everywhere in here which does
>> not feel right, but I followed the existing style, leaving a consistent
>> clean-up for a later patch. Also, typesetting is inconsistent:
>> We have <branch> as well as `<branch>` when the text talks about the
>> options. Do we have a style guide or such?
>>
>>  Documentation/git-branch.txt |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>> index 6103d62..27b73bc 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -76,8 +76,8 @@ OPTIONS
>>  	based sha1 expressions such as "<branchname>@\{yesterday}".
>>  
>>  -f::
>> -	Force the creation of a new branch even if it means deleting
>> -	a branch that already exists with the same name.
>> +	Reset <branchname> to <startpoint> if <branchname> exists
>> +	already. Without `-f` 'git-branch' refuses to change an existing branch.
> 
> And what happens if the branchname does not exist?

Well, the standard behaviour of "git branch" is described in the
"description", the meaning of the options under "options"...
We could add

	If <branchname> does not exist it is created and '-f' has no effect.

although that seems a bit talkative.

> 
>>  
>>  -m::
>>  	Move/rename a branch and the corresponding reflog.
>> -- 
>> 1.6.2.149.g6462

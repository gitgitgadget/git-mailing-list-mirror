From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Disallow empty GIT_AUTHOR_NAME or GIT_COMMITTER_NAME
Date: Mon, 09 Jul 2007 11:41:31 -0500
Message-ID: <4692653B.1090803@nrlssc.navy.mil>
References: <468E80D3.5060706@nrlssc.navy.mil> <7vlkdsdaxo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 18:42:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7wJJ-00041E-KX
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 18:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761527AbXGIQlj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 12:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761520AbXGIQlj
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 12:41:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51349 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761064AbXGIQlh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 12:41:37 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l69GdXAO019741;
	Mon, 9 Jul 2007 11:39:35 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Jul 2007 11:41:32 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <7vlkdsdaxo.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 09 Jul 2007 16:41:32.0297 (UTC) FILETIME=[018F9790:01C7C248]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15282001
X-TM-AS-Result: : Yes--15.763200-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMTYwLTcwMzczMS0xODgwMTktNzA3NjU0LTcwMzk2OS03?=
	=?us-ascii?B?MDA2MTgtNzAyMDQ0LTcwMjM1OC03MDQ5ODMtNzA5MjUxLTcwMDEw?=
	=?us-ascii?B?Ny03MDMwOTYtNzAxNDU1LTEwNTI1MC03MDIxNTctNzA0NDMwLTcw?=
	=?us-ascii?B?NzM2MS0xMTMyMTEtNzAwNDc2LTcwNTczMy03MDI3OTEtNzAxNTc2?=
	=?us-ascii?B?LTEwNTA0MC0xMjE1OTQtNzAzODUxLTcwNDQyNS03MDM5MDctNzA0?=
	=?us-ascii?B?NDIxLTcwMzc4OC03MDAxMTUtNzA3ODAwLTE0ODA1MS0yMDA0Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52005>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
...
>> This still allows an empty GIT_AUTHOR_EMAIL or GIT_COMMITTER_EMAIL.
>> Possibly someone would want to use these variables to disable
>> the respective email address string?
>>
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> 
> Thanks.  But this makes me wonder why you do not do the same
> check for !*email

I thought someone may want to disable the author or committer email
address by setting GIT_AUTHOR_EMAIL or GIT_COMMITTER_EMAIL to an
empty string. I wasn't sure this was useful that's why I put a '?'
at the end of my commit message.


>> Then I send the patch to myself using git-format-patch and then
>> git-send-email. These two format the patch appropriately for
>> submission and allow me to set the message-id.
>>
>> Then I select the message, right-click and choose "Edit As New...",
>> edit, select the recipients, and send. I also now have a record of
>> the sent message which I would not have if I used only git-send-email.
> 
> I would just add myself to --bcc when running send-email; much
> simpler ;-). 

currently I can only use send-email to send email to myself, so this
was an alternative to setting up an external editor in thunderbird.
It's currently the path of least resistance for me.

-brandon

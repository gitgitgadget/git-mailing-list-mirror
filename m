From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 12:34:31 -0600
Message-ID: <505CB337.706@workspacewhiz.com>
References: <505C7C80.3000700@workspacewhiz.com> <m2d31fbedd.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 20:35:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF83x-0004D8-2k
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 20:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982Ab2IUSel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 14:34:41 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:50923 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab2IUSei (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 14:34:38 -0400
Received: (qmail 8309 invoked by uid 399); 21 Sep 2012 12:34:02 -0600
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@204.238.46.101)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Sep 2012 12:34:02 -0600
X-Originating-IP: 204.238.46.101
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <m2d31fbedd.fsf@igel.home>
X-Antivirus: avast! (VPS 120921-0, 09/21/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206147>

----- Original Message -----
From: Andreas Schwab
Date: 9/21/2012 9:10 AM
> Joshua Jensen <jjensen@workspacewhiz.com> writes:
>
>> Background: To tie Perforce changelists to Git commits, I add a note to a
>> commit with the form "P4@123456".  Later, I use the note to sync down the
>> closest Perforce changelist matching the Git commit.
>>
>> I search for these notes by getting a list of revisions:
>>
>>          git rev-list --max-count=1000
>>
>> I iterate those revisions and run git show and grep on each:
>>
>>          git show -s --format=%N%n%s --show-notes=p4notes COMMIT
> How about "git grep P4@123456 notes/p4notes"?
>
> Andreas.
>
Thanks for the reply.

I should have labeled the format above as "P4@#######".  The numeric 
part will change.  The "P4@" will not.

So, I run "git grep P4@ notes/p4notes".  I get a bunch of responses.  I 
need the closest commit to HEAD that contains the P4@ text.

Any ideas?

-Josh

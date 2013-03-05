From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: rebase destroys branches
Date: Tue, 5 Mar 2013 22:04:02 -0000
Organization: OPDS
Message-ID: <BF397CFFF4D4468384AEB32BC18A0D2B@PhilipOakley>
References: <C057AC9B02D06A49810E9597C11F55BF14DFE51C9F@dnzwgex2.datacom.co.nz> <64FF012BC4AF45C4A5067DE93FD9FE17@PhilipOakley> <C057AC9B02D06A49810E9597C11F55BF14DFE5214F@dnzwgex2.datacom.co.nz>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Gene Thomas [DATACOM]" <Gene.Thomas@datacom.co.nz>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 05 23:04:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCzy9-0000sv-4T
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 23:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410Ab3CEWDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 17:03:54 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:13915 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753317Ab3CEWDy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 17:03:54 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar4MAJxiNlFZ8rke/2dsb2JhbABEjiO2QgEDAYFwF3N0AQGBGwEBEQIFAQEFCAEBLh4BASwBAQMFAgEDEQQBAQoeBxQBBBoGBwYJCAYBEggCAQIDAYU4BwGCRqw8kCONSzsedoJZYQOINoVlmR2DCA
X-IronPort-AV: E=Sophos;i="4.84,791,1355097600"; 
   d="scan'208";a="402045212"
Received: from host-89-242-185-30.as13285.net (HELO PhilipOakley) ([89.242.185.30])
  by out1.ip04ir2.opaltelecom.net with SMTP; 05 Mar 2013 22:03:51 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217486>

From: "Gene Thomas [DATACOM]" <Gene.Thomas@datacom.co.nz>
Sent: Tuesday, March 05, 2013 1:05 AM
> Philip,
>        Thanks for your reply.
>
>>The original branch is not 'destroyed', rather the pointer to the
>>previous tip is within the logs.
>
> Is that the 'git log' log or internal logs? Are you sure? There
> doesn't appear to be a way to checkout that tip of see the log back
> from that tip.

Double checking the [rebase] manual page... [The ref] "ORIG_HEAD is set
to point at the tip of the branch before the reset."

So your original branch starts there (I just checked one of mine).
Obviously this is only for the machine that did the rebase, and only has
the last rebase tip. But then until it's pushed to an open repo no one 
knows ;-)

>
>>All the content is still available until the logs expire.
>
> So we will be unable to checkout content after a time?
>
> Gene Thomas.
>
> -----Original Message-----
> From: Philip Oakley [mailto:philipoakley@iee.org]
> Sent: Tuesday, 5 March 2013 12:44
> To: Gene Thomas [DATACOM]; Git List
> Subject: Re: rebase destroys branches
>
> From: "Gene Thomas [DATACOM]" <Gene.Thomas@datacom.co.nz>
> Sent: Monday, March 04, 2013 11:06 PM
>>Hello,
>>I am evaluating git for use in a company. Please correct if I am
>>wrong.
>>I am concerned that an inexperienced developer could mistakenly rebase
>>branches, destroying the original branch.
>
> The original branch is not 'destroyed', rather the pointer to the
> previous tip is within the logs. All the content is still available
> until the logs expire.
>
>>   Attached is a script (Windoze)
>>that shows the 'topic' branch being moved!, after the rebase we are
>>unable to see the original branch, read it's history or find it's
>>commit points.
>
>>Surely no operation should remove anything from the repository.
>>Operations like this irreversibly break the repository . When rebasing
>>the original branch must be retained.
>
> It's easy to misread some of Git's strengths if you have come from
> other historic corporate 'version control systems' which are often
> based on drawing office practice of old (e.g. the belief there is a
> single master to be protected is one misconception for software).
>
> Rebase, at the personal level, is an important mechanism for staff to
> prepare better code and commit messages. Trying to hide the reality
> will just make your management 'control' less effective as staff work
> around it and delay check-ins, etc.
>
> The broader access control and repo management issues are deliberately
> not part of Git, and there are good tools for that. e.g. Gitolite.
>
>>Yours faithfully,
>
>
>>Gene Thomas.
>
> Philip
>

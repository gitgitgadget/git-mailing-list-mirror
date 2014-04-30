From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 18:06:45 -0400
Message-ID: <536173F5.7010905@xiplink.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com> <xmqqoazlqot4.fsf@gitster.dls.corp.google.com> <536106EA.5090204@xiplink.com> <xmqqppjyhnom.fsf@gitster.dls.corp.google.com> <536152D3.5050107@xiplink.com> <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 01 00:06:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfceF-0007sG-On
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 00:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbaD3WGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 18:06:21 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:53132 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933602AbaD3WGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 18:06:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp25.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 561353F0AA2;
	Wed, 30 Apr 2014 18:06:19 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp25.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 0D04A3F0156;
	Wed, 30 Apr 2014 18:06:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247796>

On 14-04-30 04:14 PM, Felipe Contreras wrote:
> Marc Branchaud wrote:
>> All that said, I don't object to any attempts at improving the command
>> either.  But I also don't see any kind of improvement that would lead
>> me to start using "git pull" let alone recommending it to new users.
> 
> What is wrong when `git pull` merges a fast-forward?

Nothing.  Everything.  It depends.

> The problems with `git pull` come when you can't do a fast-forward merge, right?

Some of them, maybe most of them.

But the reason "git pull" is broken is that any solution to the problems that
arise depend on the project's workflow.  That would be fine if there was a
workflow that suited some large majority of users, but there doesn't seem to
be one.

<aside>

I dug up the workflows question from the 2012 user survey[1], but it's less
revealing than one might like:

 19. What git workflow(s) is used by projects in which development you
participate?

single developer, only private repository (no interaction)		67%

centralized workflow (push to common repository)			69%

branched centralized (push to different branches in common repository)	50%

peer-to-peer workflow (all repositories roughly equal)			 9%

integration-manager workflow (maintainer pulls/applies patches to "blessed"
repository))	19%

dictator and lieutenants workflow (hierarchical workflow)		 5%

using collaborative code review tool, e.g. Gerrit			13%

other workflow, please explain						 2%

Total respondents	4352

Respondents who skipped this question	135

(IIRC, this was a "check all that apply" question.)

I don't think this lets us conclude anything about the popularity of merging
or rebasing, even though many respondents use a centralized workflow.  I use
a centralized workflow, and I will sometimes merge and sometimes rebase.  It
depends on the work I'm doing.

</aside>

		M.

[1] https://www.survs.com/results/QPESOB10/ME8UTHXM4M

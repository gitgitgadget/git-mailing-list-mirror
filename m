From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2] gitk: Add a horizontal scrollbar for commit history
Date: Wed, 30 Oct 2013 11:04:55 -0400
Message-ID: <52712017.7080408@xiplink.com>
References: <1383130702-4966-1-git-send-email-ncornu@aldebaran-robotics.com>	<5270F4FC.60900@viscovery.net>	<CAMXp-VMku0eSQmmbdy-NQDedH4VSgZN5XmpTeBHvN8qX1=ersg@mail.gmail.com>	<52711BB3.9040004@xiplink.com> <CAMXp-VMOpBu1iUi4iQ008KyBJ5nKOpRntSSFyK+C0X8y0-J8tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	paulus@samba.org
To: Nicolas Cornu <ncornu@aldebaran-robotics.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 16:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbXK4-0000H9-96
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 16:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378Ab3J3PEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 11:04:33 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:59566 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab3J3PEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 11:04:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp29.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 18A771082DA;
	Wed, 30 Oct 2013 11:04:32 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp29.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id AFEFE10837C;
	Wed, 30 Oct 2013 11:04:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CAMXp-VMOpBu1iUi4iQ008KyBJ5nKOpRntSSFyK+C0X8y0-J8tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237021>

On 13-10-30 10:49 AM, Nicolas Cornu wrote:
> 2013/10/30 Marc Branchaud <marcnarc@xiplink.com>:
>> On 13-10-30 08:47 AM, Nicolas Cornu wrote:
>>> This is useful on all our repos, every times, as we put a tag per day.
>>> If the HEAD didn't move during 150 days, we got 150 tags.
>>> So, it depends, maybe can I put it as an option in Edit > Preferences?
>>
>> Eek, even with a scrollbar, 150 tags seems like a lot to pan over.
>
> Now, it works pretty well and is easier than mouse middle-click which
> acts strangely for me.

Yes, it's a bit weird for me too.  I think it's because the
middle-button-dragging can only be horizontal *xor* vertical.

>> I've often thought it would be good for gitk to combine multiple ref names
>> into some kind of dropdown or view-on-hover list.  (I don't know anything
>> about Tcl/Tk, so I don't know what's feasible.)  So if a commit has more than
>> a couple of branches (and/or tags), only show the first branch name along
>> with a glyph indicating that there are more, and let the user click on (or
>> hover over) that glyph to see all the branches (or tags -- that is, still
>> keep the tags and branches displayed separately).
>
> It doesn't change that if you got 150 tags, when you will show them
> up, you will need to scroll.

True, but it would mean that there's no horizontal scroll bar taking up space
in the main display.  The scrolling would also vertically oriented, which is
mousewheel-friendly.  Also, the display would be a lot less cluttered.

		M.

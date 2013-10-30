From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2] gitk: Add a horizontal scrollbar for commit history
Date: Wed, 30 Oct 2013 10:46:11 -0400
Message-ID: <52711BB3.9040004@xiplink.com>
References: <1383130702-4966-1-git-send-email-ncornu@aldebaran-robotics.com>	<5270F4FC.60900@viscovery.net> <CAMXp-VMku0eSQmmbdy-NQDedH4VSgZN5XmpTeBHvN8qX1=ersg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, paulus@samba.org
To: Nicolas Cornu <ncornu@aldebaran-robotics.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 15:45:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbX1u-0001tP-NN
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 15:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491Ab3J3Opr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 10:45:47 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:51188 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab3J3Opr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 10:45:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp29.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 84B35108477;
	Wed, 30 Oct 2013 10:45:46 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp29.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 401741083E0;
	Wed, 30 Oct 2013 10:45:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CAMXp-VMku0eSQmmbdy-NQDedH4VSgZN5XmpTeBHvN8qX1=ersg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237019>

On 13-10-30 08:47 AM, Nicolas Cornu wrote:
> This is useful on all our repos, every times, as we put a tag per day.
> If the HEAD didn't move during 150 days, we got 150 tags.
> So, it depends, maybe can I put it as an option in Edit > Preferences?

Eek, even with a scrollbar, 150 tags seems like a lot to pan over.

I've often thought it would be good for gitk to combine multiple ref names
into some kind of dropdown or view-on-hover list.  (I don't know anything
about Tcl/Tk, so I don't know what's feasible.)  So if a commit has more than
a couple of branches (and/or tags), only show the first branch name along
with a glyph indicating that there are more, and let the user click on (or
hover over) that glyph to see all the branches (or tags -- that is, still
keep the tags and branches displayed separately).

		M.

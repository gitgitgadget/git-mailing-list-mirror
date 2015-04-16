From: Chris Webb <chris@arachsys.com>
Subject: Re: rebase --root conflicts with --committer-date-is-author-date
Date: Thu, 16 Apr 2015 23:15:11 +0100
Message-ID: <43BA47EB-FA7B-4D33-8ECA-F8051B16E78E@arachsys.com>
References: <55296823.4010409@gmail.com> <xmqqwq1h50na.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Elliot Wolk <elliot.wolk@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 00:36:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YisOM-0002VE-H3
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 00:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbbDPWgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 18:36:10 -0400
Received: from cdw.me.uk ([91.203.57.136]:43294 "EHLO cdw.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbbDPWgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 18:36:09 -0400
X-Greylist: delayed 1242 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2015 18:36:08 EDT
Received: from [81.2.114.212] (helo=chris.lan)
	by alpha.arachsys.com with esmtpa (Exim 4.80)
	(envelope-from <chris@arachsys.com>)
	id 1Yis4B-000515-CH; Thu, 16 Apr 2015 23:15:24 +0100
In-Reply-To: <xmqqwq1h50na.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.2098)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267338>

Junio C Hamano <gitster@pobox.com> wrote:

> Chris, do you remember if there was a reason why it was a bad idea
> to teach the normal rebase codepath to handle "--root"?  I think we
> would have needed to allow "am" to apply a creation patch and start
> a new history on an unborn branch in order to do so, but I am not
> sure if there was a valid reason why such a change to "am" would
> have been a bad idea.

Hi. It's a long time ago, but I don't remember any reason and it feels
sensible that am should be able to create an unborn branch in the same way
interactive rebase can.

I suspect I had done the necessary work for rebase -i but not for am, and
incorrectly assumed that interactive rebase was in any case a superset of
non-interactive.

Best wishes,

Chris.

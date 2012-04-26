From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Why aren't tag refs namespaced?
Date: Thu, 26 Apr 2012 16:06:36 -0400
Message-ID: <4F99AACC.2050409@xiplink.com>
References: <CA+7g9Jxc6eaCUR8aVhqKH--sOrvQVrZn+se7wtFJsOiKNjz9Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 22:05:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNUwY-0002Jw-UB
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759111Ab2DZUF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:05:29 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:51902 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab2DZUF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 16:05:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp25.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 672553F0176;
	Thu, 26 Apr 2012 16:05:28 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp25.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1D8E43F0160;
	Thu, 26 Apr 2012 16:05:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <CA+7g9Jxc6eaCUR8aVhqKH--sOrvQVrZn+se7wtFJsOiKNjz9Pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196400>

On 12-04-26 02:40 PM, Nathan Gray wrote:
> Hey guys,
> 
> Namespacing works really well for branch refs.  I know that
> remotes/origin/master is origin's master branch.  I may or may not
> have a master branch, and it may or may not have anything in common
> with origin's.  Our repositories are independent, after all, so it
> makes sense that our refs would live in different namespaces.
> 
> So why is it that tag refs don't follow this model?  Why is my
> "best-commit-ever" tag assumed to be the same as origin's?  Given a
> ref in refs/tags it's unclear if the ref is public, private, on origin
> or not on origin.  Will pushing my tags create anything new or not?
> Who knows?  Compare this to branches, where the same questions are
> easy to answer thanks to namespacing.

There was lengthy, but inconclusive, discussion about this a year ago:

http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=166290

		M.

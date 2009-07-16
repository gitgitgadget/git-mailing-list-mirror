From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Wed, 15 Jul 2009 23:59:20 -0400
Message-ID: <4A5EA598.5050801@garzik.org>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751524AbZGPEBJ@vger.kernel.org Thu Jul 16 06:01:46 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751524AbZGPEBJ@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRIA7-0002of-QR
	for glk-linux-kernel-3@gmane.org; Thu, 16 Jul 2009 06:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbZGPEBJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Jul 2009 00:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbZGPEBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jul 2009 00:01:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43087 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbZGPEBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jul 2009 00:01:07 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1MRI9W-0005mj-Ln; Thu, 16 Jul 2009 04:01:06 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123360>

Junio C Hamano wrote:
> GIT v1.6.4 Release Notes (draft)
> ================================
> 
> With the next major release, "git push" into a branch that is
> currently checked out will be refused by default.  You can choose
> what should happen upon such a push by setting the configuration
> variable receive.denyCurrentBranch in the receiving repository.
> 
> To ease the transition plan, the receiving repository of such a
> push running this release will issue a big warning when the
> configuration variable is missing.  Please refer to:
> 
>   http://git.or.cz/gitwiki/GitFaq#non-bare
>   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
> 
> for more details on the reason why this change is needed and the
> transition plan.
> 
> For a similar reason, "git push $there :$killed" to delete the branch
> $killed in a remote repository $there, if $killed branch is the current
> branch pointed at by its HEAD, gets a large warning.  You can choose what
> should happen upon such a push by setting the configuration variable
> receive.denyDeleteCurrent in the receiving repository.
> 
> When the user does not tell "git push" what to push, it has always
> pushed matching refs.  For some people it is unexpected, and a new
> configuration variable push.default has been introduced to allow
> changing a different default behaviour.  To advertise the new feature,
> a big warning is issued if this is not configured and a git push without
> arguments is attempted.
> 
> 	Side note: we might want to tone this down, as it does not seem
> 	likely for us to change the default behaviour when this option is
> 	not set.


Is there some sort of guide to the new best practices for handling trees 
such as git.kernel.org, where one pushes into "foo.git" directly, and 
there is no checked-out source code at all?

I've been getting the multi-line "warning: Updating the currently 
checked out branch may cause confusion" message, but ignoring it for 
now, because it does not appear to apply to my situation (no checked-out 
work tree).

Advice appreciated...

	Jeff

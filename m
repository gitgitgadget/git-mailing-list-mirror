From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH 1/7] "git" calls help_unknown_cmd(""); "git help" and "git help -a" return 0
Date: Sat, 27 Oct 2007 00:16:32 -0700
Message-ID: <20071027071631.GA16359@srparish.net>
References: <1193283437-1706-1-git-send-email-srp@srparish.net> <7vd4v33iy0.fsf@gitster.siamese.dyndns.org> <20071025045228.GE759@srparish.net> <7v640twka3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 09:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilfub-0003C6-23
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 09:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbXJ0HQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 03:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbXJ0HQh
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 03:16:37 -0400
Received: from smtp-gw8.mailanyone.net ([208.70.128.73]:44574 "EHLO
	smtp-gw8.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbXJ0HQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 03:16:36 -0400
Received: from mailanyone.net
	by smtp-gw8.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP quinn@srparish.net)
	id 1IlfuK-0003KZ-M7; Sat, 27 Oct 2007 02:16:34 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 501
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sat, 27 Oct 2007 00:16:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v640twka3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62466>

On Fri, Oct 26, 2007 at 04:03:48PM -0700, Junio C Hamano wrote:

> > Regarding "git: '' is not a git-command" the way i was seeing that
> > is that git is usually only called with commands, and '' isn't a
> > valid command, hence the reason to exit 1, the help is just a nice
> > user experience.
> 
> But think who would type "git<Enter>".  They are either people
> who (1) do not even know that "git" alone is not useful and that
> it always wants a subcommand, or (2) know "git<Enter>" is the
> same as "git help" and wants to get the "common command list"
> quickly.  Technically, "'' is not a git-command" is correct, but
> the message does not help either audience, does it?

Fair enough, i'll drop that in the updated patch set i'm about ready
to send. Incidentally i was also missing the "usage" string.

sRp

-- 
Scott Parish
http://srparish.net/

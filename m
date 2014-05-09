From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Pull is Mostly Evil
Date: Fri, 09 May 2014 15:49:25 -0400
Message-ID: <536D3145.7080305@xiplink.com>
References: <5363BB9F.40102@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 09 21:49:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqnL-000728-Kr
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972AbaEITtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:49:20 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:57107 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765AbaEITtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:49:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id CEE1A198A42;
	Fri,  9 May 2014 15:49:18 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp24.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 972871989E3;
	Fri,  9 May 2014 15:49:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5363BB9F.40102@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248633>

After poking this hornet's nest I pretty much have stood back and not
participated in the ensuing discussions.  But having unleashed the hornets I
feel I should at least say something, if only to assure people that I'm not
ignoring their plight.

There have been various proposals to modify git-pull's defaults, and/or
extend it with new configuration settings, and/or add a new command.  As I
don't use "git pull" I feel I'm not in any position to comment about the
particulars of these proposals.

However I remain skeptical that these proposals, in any form, will really be
all that helpful to new users.  That's because in order to know whether or
not "git pull" (or "git update") does what the user wants, the user has to
understand the intricacies of both their own workflow and how git can work
within that workflow.  By the time a user gains that understanding, she is no
longer a new user.

Still, I do think the pull command is useful.  In particular I think that a
project can benefit greatly by tailoring pull's behaviour to match its
workflow, and that a project's participants can be told how to configure git
so that pull works properly for that project.  Maybe even such configuration
-- a "workflow blueprint" if you will -- can be tracked inside the project
itself, so that a fresh project clone can automatically have "git pull"
properly configured.   To me this seems like a fabulous feature for git.

But for now I go back to what I said before:  Give "git pull" enough knobs to
let people tailor it to their individual projects' needs.  But also disable
"git pull" by default, because nobody should run it until they've considered
how they want it to work.

		M.

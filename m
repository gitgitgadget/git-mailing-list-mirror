From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] cherry-pick: add --allow-empty-message option
Date: Mon, 6 Aug 2012 06:57:29 -0400
Message-ID: <20120806105729.GC16873@hmsreliant.think-freely.org>
References: <20120802085554.GI19416@arachsys.com>
 <86938f900c630d983852a250090f2aa6112fcc3c.1343903931.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 12:57:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyL0S-0006J2-Ln
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 12:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab2HFK5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 06:57:41 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:33893 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867Ab2HFK5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 06:57:40 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SyL06-0001W5-3W; Mon, 06 Aug 2012 06:57:34 -0400
Content-Disposition: inline
In-Reply-To: <86938f900c630d983852a250090f2aa6112fcc3c.1343903931.git.chris@arachsys.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202959>

On Thu, Aug 02, 2012 at 11:38:51AM +0100, Chris Webb wrote:
> Scripts such as git rebase -i cannot currently cherry-pick commits which
> have an empty commit message, as git cherry-pick calls git commit
> without the --allow-empty-message option.
> 
> Add an --allow-empty-message option to git cherry-pick which is passed
> through to git commit, so this behaviour can be overridden.
> 
> Signed-off-by: Chris Webb <chris@arachsys.com>
Sorry for the late response, but I just pulled back into town.

Having read over this thread, I think this is definately the way to go.  As
discussed having cherry-pick stop and give the user a chance to fix empty
history messages by default, and providing a switch to override that behavior
makes sense to me.  That said, shouldn't there be extra code here in the rebase
scripts to automate commit migration in that path as well?
Neil

> 

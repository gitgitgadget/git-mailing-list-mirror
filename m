From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] cherry-pick: add --allow-empty-message option
Date: Mon, 6 Aug 2012 07:11:22 -0400
Message-ID: <20120806111122.GD16873@hmsreliant.think-freely.org>
References: <20120802085554.GI19416@arachsys.com>
 <86938f900c630d983852a250090f2aa6112fcc3c.1343903931.git.chris@arachsys.com>
 <20120806105729.GC16873@hmsreliant.think-freely.org>
 <20120806110016.GA8587@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 13:11:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyLDh-00074G-Ip
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 13:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab2HFLL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 07:11:28 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:34064 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab2HFLL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 07:11:28 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SyLDX-0001aq-IV; Mon, 06 Aug 2012 07:11:25 -0400
Content-Disposition: inline
In-Reply-To: <20120806110016.GA8587@arachsys.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202961>

On Mon, Aug 06, 2012 at 12:00:16PM +0100, Chris Webb wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Having read over this thread, I think this is definately the way to go.  As
> > discussed having cherry-pick stop and give the user a chance to fix empty
> > history messages by default, and providing a switch to override that behavior
> > makes sense to me.  That said, shouldn't there be extra code here in the rebase
> > scripts to automate commit migration in that path as well?
> 
> Yes, this patch just adds the support to the low-level git cherry-pick as
> you say. I'll follow up with a patch to use the new feature in rebase [-i]
> when I get some free time, hopefully later this week.
> 
> Cheers,
> 
> Chris.
> 
Ok, then
Acked-by: Neil Horman <nhorman@tuxdriver.com>

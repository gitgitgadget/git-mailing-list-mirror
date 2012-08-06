From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH] cherry-pick: add --allow-empty-message option
Date: Mon, 6 Aug 2012 12:00:16 +0100
Message-ID: <20120806110016.GA8587@arachsys.com>
References: <20120802085554.GI19416@arachsys.com>
 <86938f900c630d983852a250090f2aa6112fcc3c.1343903931.git.chris@arachsys.com>
 <20120806105729.GC16873@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 13:00:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyL2z-00081I-HM
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 13:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab2HFLAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 07:00:25 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:60626 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab2HFLAY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 07:00:24 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SyL2p-0006dB-Ff; Mon, 06 Aug 2012 12:00:22 +0100
Content-Disposition: inline
In-Reply-To: <20120806105729.GC16873@hmsreliant.think-freely.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202960>

Neil Horman <nhorman@tuxdriver.com> writes:

> Having read over this thread, I think this is definately the way to go.  As
> discussed having cherry-pick stop and give the user a chance to fix empty
> history messages by default, and providing a switch to override that behavior
> makes sense to me.  That said, shouldn't there be extra code here in the rebase
> scripts to automate commit migration in that path as well?

Yes, this patch just adds the support to the low-level git cherry-pick as
you say. I'll follow up with a patch to use the new feature in rebase [-i]
when I get some free time, hopefully later this week.

Cheers,

Chris.

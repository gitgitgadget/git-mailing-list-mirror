From: Mike Crowe <mac@mcrowe.com>
Subject: Re: [PATCH] describe: Add --left-only option
Date: Fri, 17 May 2013 16:16:23 +0100
Message-ID: <20130517151623.GA3083@mcrowe.com>
References: <1368800666-5222-1-git-send-email-mac@mcrowe.com>
 <20130517150329.GA27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 17 17:22:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdMUN-0007RW-Qg
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 17:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab3EQPWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 11:22:32 -0400
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:37104 "EHLO
	smtpout.karoo.kcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab3EQPWb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 11:22:31 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 May 2013 11:22:31 EDT
X-IronPort-AV: E=Sophos;i="4.87,693,1363132800"; 
   d="scan'208";a="14145221"
Received: from deneb.mcrowe.com ([82.152.148.4])
  by smtpout.karoo.kcom.com with ESMTP; 17 May 2013 16:16:23 +0100
Received: from mac by deneb.mcrowe.com with local (Exim 4.80)
	(envelope-from <mac@mcrowe.com>)
	id 1UdMON-0000oV-3H; Fri, 17 May 2013 16:16:23 +0100
Content-Disposition: inline
In-Reply-To: <20130517150329.GA27005@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224695>

On Fri, May 17, 2013 at 04:03:29PM +0100, John Keeping wrote:
> On Fri, May 17, 2013 at 03:24:26PM +0100, Mike Crowe wrote:
> > Only consider the first parent commit when walking the commit history. This
> > is useful if you only wish to match tags on your branch after a merge.
> 
> For consistency with "git log" should this be called "--first-parent"?
> 
> In "git log" --left-only takes effect only when considering a symmetric
> range, which "git describe" isn't.  Whereas --first-parent triggers
> precisely the behaviour described here.

I think you're right.

I'm happy to rename it and resubmit if the rest of the patch passes muster.

Thanks.

Mike.

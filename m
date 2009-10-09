From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv2 2/2] completion: fix alias listings with newlines
Date: Fri, 9 Oct 2009 07:29:50 -0700
Message-ID: <20091009142950.GS9261@spearce.org>
References: <1255069304-8953-1-git-send-email-bebarino@gmail.com> <1255069304-8953-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 16:40:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwGdd-0007iK-GJ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 16:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760949AbZJIOa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 10:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756503AbZJIOa1
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 10:30:27 -0400
Received: from george.spearce.org ([209.20.77.23]:56463 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbZJIOa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 10:30:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B5B65381FF; Fri,  9 Oct 2009 14:29:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1255069304-8953-2-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129805>

Stephen Boyd <bebarino@gmail.com> wrote:
> Aliases with newlines have been a problem since commit 56fc25f (Bash
> completion support for remotes in .git/config., 2006-11-05). The chance
> of the problem occurring has been slim at best, until commit 518ef8f
> (completion: Replace config --list with --get-regexp, 2009-09-11)
> removed the case statement introduced by commit 56fc25f. Before removing
> the case statement, most aliases with newlines would work unless they
> were specially crafted as follows
...
> Hannes has convinced me to go this route. I don't really see a problem, it
> basically reverts to broken behavior that nobody's complained about in 3
> years. At least it's less broken?

Yay.  Given that we have no better solution easily available,
I like the idea of just reverting to the behavior we have had
for the past 3 years.  Thanks.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
-- 
Shawn.

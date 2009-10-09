From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] completion: fix completion of git <TAB><TAB>
Date: Fri, 9 Oct 2009 07:26:54 -0700
Message-ID: <20091009142654.GR9261@spearce.org>
References: <1255069304-8953-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 16:40:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwGdc-0007iK-ES
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 16:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760934AbZJIO1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 10:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760906AbZJIO1a
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 10:27:30 -0400
Received: from george.spearce.org ([209.20.77.23]:56455 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760852AbZJIO1a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 10:27:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0AA28381FE; Fri,  9 Oct 2009 14:26:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1255069304-8953-1-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129804>

Stephen Boyd <bebarino@gmail.com> wrote:
> After commit 511a3fc (wrap git's main usage string., 2009-09-12), the
> bash completion for git commands includes COMMAND and [ARGS] when it
> shouldn't. Fix this by grepping more strictly for a line with git
> commands. It's doubtful whether git will ever have commands starting
> with anything besides numbers and letters so this should be fine. At
> least by being stricter we'll know when we break the completion earlier.
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.

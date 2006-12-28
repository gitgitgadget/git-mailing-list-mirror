From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/3] t9200-git-cvsexportcommit.sh: quiet down commit
Date: Thu, 28 Dec 2006 10:14:49 -0800
Message-ID: <20061228181448.GA17775@localdomain>
References: <11672970521665-git-send-email-normalperson@yhbt.net> <11672970542015-git-send-email-normalperson@yhbt.net> <11672970561224-git-send-email-normalperson@yhbt.net> <11672970581666-git-send-email-normalperson@yhbt.net> <7vfyb0wexo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 19:15:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzzmN-0006uN-2S
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 19:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbWL1SOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 13:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbWL1SOz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 13:14:55 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43303 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754909AbWL1SOv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 13:14:51 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3E7437DC08E;
	Thu, 28 Dec 2006 10:14:49 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 28 Dec 2006 10:14:49 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyb0wexo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35559>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Also, fixed an unportable use of 'export'.
> 
> As a traditionalist, I tend to prefer "var=val; export var" over
> "export var=val" myself, but I wonder how unportable this is
> these days.
> 
> Just wondering, no objection.
> 
> Do you have a specific shell in mind that groks other constructs
> used in our tests but not "export var=val" form?

I can't remember, and I can't seem to find one, either.  Even posh
(latest debian unstable) and ash (from woody) seem to support it...

On a related note, how portable is mkdir -p these days?  I remember
seeing systems that don't have it, too.

-- 
Eric Wong

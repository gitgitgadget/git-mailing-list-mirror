From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Strange behavior of gitweb
Date: Fri, 27 Nov 2009 00:58:07 +0100
Message-ID: <m24oogyh2o.fsf@igel.home>
References: <Pine.LNX.4.44L0.0911261225130.17259-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
X-From: git-owner@vger.kernel.org Fri Nov 27 00:58:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDoE4-0003Ti-Tu
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 00:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbZKZX6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 18:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbZKZX6F
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 18:58:05 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37629 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbZKZX6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 18:58:04 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 49CB71C15D60;
	Fri, 27 Nov 2009 00:58:08 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id D0EA390BB7;
	Fri, 27 Nov 2009 00:58:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id mDyJBHJxggaY; Fri, 27 Nov 2009 00:58:07 +0100 (CET)
Received: from igel.home (DSL01.83.171.145.99.ip-pool.NEFkom.net [83.171.145.99])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 27 Nov 2009 00:58:07 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 28623CA28C; Fri, 27 Nov 2009 00:58:07 +0100 (CET)
X-Yow: Yow!  Are we wet yet?
In-Reply-To: <Pine.LNX.4.44L0.0911261225130.17259-100000@netrider.rowland.org>
	(Alan Stern's message of "Thu, 26 Nov 2009 12:32:48 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133850>

Alan Stern <stern@rowland.harvard.edu> writes:

> I recently ran across this strange behavior in the gitweb server at 
> git.kernel.org.  The following URL:
>
> http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.27.y.git;a=commit;h=2d93148ab6988cad872e65d694c95e8944e1b62
>
> brings up a page containing commit 2d93148[...].  But that commit isn't
> part of the 2.6.27.y tree!  It belongs to Linus's main tree, and it was
> added long after 2.6.27.y was forked off.  The actual commit applied to
> 2.6.27.y was 070bb0f3b6df167554f0ecdeb17a5bcdb1cd7b83.
>
> So what's going on here?

Nothing mysterious.  Every tree on kernel.org borrows from Linus' main
tree via .git/objects/info/alternates, thus includes its whole object
database by reference.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

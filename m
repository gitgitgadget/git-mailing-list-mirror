From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] gitk - Make selection highlight color configurable
Date: Tue, 26 Jun 2007 12:54:52 -0500
Message-ID: <20070626175452.GS4087@lavos.net>
References: <1182825801300-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, paulus@samba.org, git@vger.kernel.org
To: mdl123@verizon.net
X-From: git-owner@vger.kernel.org Tue Jun 26 19:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3FFs-0006RV-P2
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 19:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399AbXFZRzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 13:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756771AbXFZRzE
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 13:55:04 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:39177 "EHLO
	asav01.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757396AbXFZRzD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 13:55:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq1HAB/vgEZKhvbzR2dsb2JhbACBT4Vdh28BAT8B
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav01.insightbb.com with ESMTP; 26 Jun 2007 13:55:00 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 8E531309F31; Tue, 26 Jun 2007 12:54:52 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1182825801300-git-send-email-mdl123@verizon.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50969>

Mark Levedahl wrote:
> Cygwin's tk by default uses a very dark selection background color
> that makes the currently selected text almost unreadable. On linux,
> the default selection background is a light gray which is very usable.
> This makes the default a light gray everywhere but allows the user to
> configure the color as well.

I noticed this, and also noticed that the dark color in question was
in fact the default Windows selection background color.  Unfortunately,
wish/gitk doesn't also use the default Windows selection foreground color
(white), so the result is pretty unreadable.

When playing with Git on Windows I worked around the problem by changing
the selection color system-wide.

(This patch is perhaps better than making it work the "Windows way"
with the right system foreground color, though, as the tag and branch
markers are also pretty ugly against a dark background...)

-bcd
-- 
*** Brian Downing <bdowning@lavos.net> 

From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [Fwd: [FORCEDETH]: Fix reversing the MAC address on suspend.]
Date: Thu, 10 Jan 2008 09:17:36 +0000
Message-ID: <1199956656.4111.471.camel@shinybook.infradead.org>
References: <1199902258.2978.93.camel@pmac.infradead.org>
	 <20080109.154431.128118336.davem@davemloft.net>
	 <alpine.LFD.1.00.0801091620450.3148@woody.linux-foundation.org>
	 <20080109.164149.264906319.davem@davemloft.net>
	 <alpine.LFD.1.00.0801091934160.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>, B.Steinbrink@gmx.de,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 10:19:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCtZM-0008G5-NH
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 10:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYAJJS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 04:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbYAJJSz
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 04:18:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48611 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbYAJJSy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 04:18:54 -0500
Received: from shinybook-bcm.infradead.org ([2001:8b0:10b:1:20a:95ff:fef3:9992])
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JCtYb-0003S1-HM; Thu, 10 Jan 2008 09:18:37 +0000
In-Reply-To: <alpine.LFD.1.00.0801091934160.3148@woody.linux-foundation.org>
X-Mailer: Evolution 2.12.2 (2.12.2-3.fc8.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70054>


On Wed, 2008-01-09 at 19:47 -0800, Linus Torvalds wrote:
> If you can make your editor/mail setup (I assume it's Gnu "bovine 
> excrement" Emacs, since you say that you use your editor for email) use 
> utf8 natively for saving any results, then all your problems should go 
> away.

Careful with that approach. You don't necessarily want to convert the
patch; only the author info and the comments. I think git-mailinfo does
the right thing.

-- 
dwmw2

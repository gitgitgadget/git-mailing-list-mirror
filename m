From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: gitweb - encoding problems
Date: Mon, 21 May 2007 20:33:32 -0400
Message-ID: <1179794012.2771.112.camel@shinybook.infradead.org>
References: <20070521205721.GA21771@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <junkio@cox.net>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue May 22 02:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqIK0-0006Hl-Ud
	for gcvg-git@gmane.org; Tue, 22 May 2007 02:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762038AbXEVAda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 20:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759365AbXEVAda
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 20:33:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37400 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762038AbXEVAd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 20:33:29 -0400
Received: from 1cc-dhcp-81.media.mit.edu ([18.85.46.81])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HqIJa-0003xm-VK; Tue, 22 May 2007 01:33:27 +0100
In-Reply-To: <20070521205721.GA21771@auto.tuwien.ac.at>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7.dwmw2.2) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48065>

On Mon, 2007-05-21 at 22:57 +0200, Martin Koegler wrote:
> I use ISO-8859-1 as my locale, so my blobs, commits and tags are in
> this encoding. 

That's a very strange thing for anyone to do in the 21st century.
Did you configure this archaic thing correctly in .git/config?

Otherwise, gitweb will assume that you're using utf-8 like any normal
person would, and of course you'll have problems when it tries to deal
with your legacy character set as if it were something sensible.

-- 
dwmw2

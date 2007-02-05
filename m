From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Why is git-clone --reference so slow?
Date: Mon, 05 Feb 2007 15:35:30 +0000
Message-ID: <1170689730.29759.822.camel@pmac.infradead.org>
References: <1170676004.29759.767.camel@pmac.infradead.org>
	 <Pine.LNX.4.63.0702051629450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 05 16:35:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE5sY-0001NT-EW
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 16:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933002AbXBEPfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 10:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933005AbXBEPfd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 10:35:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56152 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933002AbXBEPfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 10:35:32 -0500
Received: from pmac.infradead.org ([81.187.2.168])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HE5sR-0006gD-96; Mon, 05 Feb 2007 15:35:31 +0000
In-Reply-To: <Pine.LNX.4.63.0702051629450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38754>

On Mon, 2007-02-05 at 16:31 +0100, Johannes Schindelin wrote:
> Is this a Mac? Is it Mac OS X? Which git version do you use?
> 
> We recently had a case like this, and it was fixed: apparently, mmap()
> on Mac OS X is less than fast... 

Yes, it's a Mac G5. No, it's not OSX; it's Fedora Core 6. As far as I
can tell it's downloading far more than it needs before discarding
objects which are already in the local repository used in --reference.


-- 
dwmw2

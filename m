From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: OT: character encodings
Date: Mon, 08 Jan 2007 09:53:51 +0800
Message-ID: <1168221232.14763.80.camel@shinybook.infradead.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	 <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc>
	 <1168182838.14763.24.camel@shinybook.infradead.org>
	 <20070107153833.GA21133@flint.arm.linux.org.uk>
	 <1168187346.14763.70.camel@shinybook.infradead.org>
	 <20070107170656.GC21133@flint.arm.linux.org.uk> <45A14A2A.9060306@imap.cc>
	 <20070107195051.GF21133@flint.arm.linux.org.uk>  <45A17645.1030905@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 02:53:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3jhq-0000Em-9u
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 02:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbXAHBxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 20:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbXAHBxn
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 20:53:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44909 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030438AbXAHBxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 20:53:42 -0500
Received: from mail3.quantacn.com ([61.152.217.200] helo=[172.21.170.25])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1H3jhc-0007S2-DU; Mon, 08 Jan 2007 01:53:35 +0000
To: Tilman Schmidt <tilman@imap.cc>
In-Reply-To: <45A17645.1030905@imap.cc>
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36220>

On Sun, 2007-01-07 at 23:37 +0100, Tilman Schmidt wrote:
> > That depends on your point of view.  David's assertion was that git
> > internally uses UTF-8.
> 
> Well, I'm inclined to say he was wrong. Git internally is completely
> oblivious to character encoding.

See the 'i18n.commitencoding' property, stored in the repository config
and defaulting to UTF-8. Git is certainly capable of converting to its
internal storage encoding when you commit; if it doesn't do so by
default then that would be a bug.

-- 
dwmw2

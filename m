From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 2/2] Check for IO errors after running a command
Date: Tue, 26 Jun 2007 15:33:08 +0200
Message-ID: <20070626133308.GA11504@moooo.ath.cx>
References: <87abuq1z6f.fsf@rho.meyering.net> <7vzm2pwws8.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org> <alpine.LFD.0.98.0706241010480.3593@woody.linux-foundation.org> <7vy7i8xtap.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 15:33:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3BAP-0006HX-Lv
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 15:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbXFZNdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 09:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbXFZNdM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 09:33:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:52460 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753039AbXFZNdL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 09:33:11 -0400
Received: (qmail invoked by alias); 26 Jun 2007 13:33:10 -0000
Received: from pD9EBB580.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.128]
  by mail.gmx.net (mp029) with SMTP; 26 Jun 2007 15:33:10 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19g2uoY7ZJg1mN7jTL8FCELpnL7UUc0X+WVV83d4z
	zWF/shoWZPG7ee
Content-Disposition: inline
In-Reply-To: <7vy7i8xtap.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50960>

Junio C Hamano <gitster@pobox.com> wrote:
> The changes to git.c (run_command) conflicted with GIT_WORK_TREE
> changes in a minor way.  Matthias, could you sanity check the
> result once I push it out to 'next', please?

The changes look fine, the tests pass and my own short manual test
passed.

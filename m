From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Mon, 3 Sep 2007 15:35:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031534300.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC11F4.5060406@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 16:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISD1k-0000ip-Ga
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 16:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbXICOfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 10:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbXICOfd
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 10:35:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:51366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751058AbXICOfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 10:35:33 -0400
Received: (qmail invoked by alias); 03 Sep 2007 14:35:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 03 Sep 2007 16:35:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19iT6g5bjFia517vlazFzdjlkwZxKCXPmX52khY+S
	dElMHhPl9YRRe2
X-X-Sender: gene099@racer.site
In-Reply-To: <46DC11F4.5060406@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57489>

Hi,

On Mon, 3 Sep 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > I saw some funny stuff on Windows, like test cases succeeding when run
> > interactively, but failing when run from "make test".
> 
> That's very likely the issue that we work around by inserting "sleep 1" at
> strategic points, which is a timing (race condition) issue and does not
> depend on interactive vs. "make test".

Makes sense to me now.  Especially around t5510 -- t5701 I see those (and 
I do not run "make test" often, since it takes _ages_.

Thanks,
Dscho

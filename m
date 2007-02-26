From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch--tool: fix uninitialized buffer when reading from
 stdin
Date: Mon, 26 Feb 2007 18:28:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702261827510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702261306140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702260821310.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702261741360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702260905420.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 18:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLjeT-0003Yr-Fe
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 18:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbXBZR2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 12:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbXBZR2i
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 12:28:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:46552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030358AbXBZR2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 12:28:37 -0500
Received: (qmail invoked by alias); 26 Feb 2007 17:28:36 -0000
X-Provags-ID: V01U2FsdGVkX194vlttc5p47tWA+l/tm6u/p0aRh6tZ2uLnmvUMNe
	4yBQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702260905420.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40634>

Hi,

On Mon, 26 Feb 2007, Linus Torvalds wrote:

> I suspect you only tested with small input to stdin.

Addendum: yes, I only tested with a reflist which was smaller than one 
megabyte ;-)

Ciao,
Dscho

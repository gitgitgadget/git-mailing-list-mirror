From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MinGW port - initial work uploaded
Date: Wed, 24 Jan 2007 08:42:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701240834190.3606@woody.linux-foundation.org>
References: <200701192148.20206.johannes.sixt@telecom.at> 
 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com> 
 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org> 
 <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
 <fcaeb9bf0701232312t5889efa6w58bb3abfa2f53ebd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian MICHON <christian.michon@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 17:42:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9lCz-00012A-85
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 17:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbXAXQmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 11:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbXAXQmq
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 11:42:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43192 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbXAXQmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 11:42:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0OGgUpa016750
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 Jan 2007 08:42:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0OGgTCj021354;
	Wed, 24 Jan 2007 08:42:29 -0800
In-Reply-To: <fcaeb9bf0701232312t5889efa6w58bb3abfa2f53ebd@mail.gmail.com>
X-Spam-Status: No, hits=-0.669 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.171 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37653>



On Wed, 24 Jan 2007, Nguyen Thai Ngoc Duy wrote:
> 
> At least I can say that wine 0.9.27 can run git.exe, git-log.exe,
> git-diff.exe. I have not tested others yet. git binaries were cross
> compiled from Linux.

Ahh, that's perfect. There are even RPM's for mingw around, since that 
seems to be what some Wine people use for testing.

And I don't really want to _work_ inside some wine setup anyway, so being 
able to try to cross-compile from a sane development environment was 
exactly what I was hoping for.

No promises, but if I get any free time, I'll look at it a bit. 

		Linus

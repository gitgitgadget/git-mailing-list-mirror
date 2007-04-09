From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 9 Apr 2007 11:02:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704091059240.6730@woody.linux-foundation.org>
References: <11760951973172-git-send-email-nico@cam.org> <20070409171925.GS5436@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:34:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HayDB-00011O-M2
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbXDISDW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbXDISDW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:03:22 -0400
Received: from smtp.osdl.org ([65.172.181.24]:53495 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbXDISDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:03:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l39I2pPD008673
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Apr 2007 11:02:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l39I2oFT019441;
	Mon, 9 Apr 2007 11:02:50 -0700
In-Reply-To: <20070409171925.GS5436@spearce.org>
X-Spam-Status: No, hits=-0.455 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44059>



On Mon, 9 Apr 2007, Shawn O. Pearce wrote:
> 
> I like this series.  I haven't had time to test it myself yet,
> and probably won't be able to do so before Junio merges it into a
> pu or next release.  But it looks OK on a first read.

Me too.. I just wonder whether it should have some more test coverage:
 - force v2 index by default
 - force a mode where a random smattering of index entries are done using 
   64-bit notation (even if they obviously won't need the high 33 bits)

As it is, nobody would normally even *use* the new format, much less the 
new capabilities.. And if it's not used, it's not tested, and it's going 
to have bugs.

		Linus

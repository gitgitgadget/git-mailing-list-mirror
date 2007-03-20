From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Mon, 19 Mar 2007 21:57:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703192154390.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
 <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
 <7v3b40d2os.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703192116020.6730@woody.linux-foundation.org>
 <20070320043902.GB29288@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 05:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTWQ4-00007t-2P
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 05:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933999AbXCTE5Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 00:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934004AbXCTE5Y
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 00:57:24 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46365 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933999AbXCTE5W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 00:57:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2K4v3cD022959
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 21:57:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2K4v2YR026102;
	Mon, 19 Mar 2007 20:57:03 -0800
In-Reply-To: <20070320043902.GB29288@spearce.org>
X-Spam-Status: No, hits=-0.977 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42708>



On Tue, 20 Mar 2007, Shawn O. Pearce wrote:

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Btw, Dscho's slightly more invasive patch seems to *just* edge out Nico's 
> > one-liner for me, with best-of-ten being 6.17s.
> 
> Uh, instead of Nico here don't you mean DrNick on #git?  He is in
> real life Nicholas Miell.  Google says he's somewhat active in the
> kernel world, so maybe you know him?  ;-)

I actually meant you.

For some reason, I confuse you and Nico. I've done it several times, and 
even without any DrNick mention.

Time to take my meds, 

		Linus

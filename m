From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Reverting the whole index-base series
Date: Mon, 16 Apr 2007 09:32:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704160931550.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
 <7vbqhp4diw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704151356450.5473@woody.linux-foundation.org>
 <7vfy712uva.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704151632140.5473@woody.linux-foundation.org>
 <7vhcrh1a2w.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704151652420.5473@woody.linux-foundation.org>
 <7v8xct18m0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:32:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdU86-0001SL-D7
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030872AbXDPQce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030871AbXDPQce
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:32:34 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40885 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030872AbXDPQcd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:32:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GGWUIs027057
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 09:32:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GGWTve006897;
	Mon, 16 Apr 2007 09:32:30 -0700
In-Reply-To: <7v8xct18m0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.45 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44675>



On Sun, 15 Apr 2007, Junio C Hamano wrote:
> 
> > ... That said, maybe we could make it an option. There's really a few 
> > different things we could do:
> 
> Yeah, throw another one in:
> 
>  (d) what we do now, but detach HEAD.

Yeah, that actually sounds like a really nice option. I think that's the 
one I'd personally use.

		Linus

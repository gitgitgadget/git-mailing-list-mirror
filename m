From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Tue, 30 Jan 2007 09:02:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701300901220.3611@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
 <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
 <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org>
 <7vveirdkpb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org>
 <7vodog3m3f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 30 18:02:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBwN5-00040c-L7
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 18:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965628AbXA3RCI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 12:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965629AbXA3RCI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 12:02:08 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38186 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965628AbXA3RCH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 12:02:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0UH221m015882
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Jan 2007 09:02:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0UH20CY023110;
	Tue, 30 Jan 2007 09:02:01 -0800
In-Reply-To: <7vodog3m3f.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.464 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38171>



On Tue, 30 Jan 2007, Junio C Hamano wrote:
> 
> This is still very rough; the existing diff frontends are mess
> and making diff-cache and diff-tree behave more or less
> interchangeably is quite a pain.

Ahh. If it's that painful, then perhaps it's not worth it. It was just a 
"wouldn't it be nice" - I don't think anybody will really *depend* on this 
kind of politeness..

		Linus

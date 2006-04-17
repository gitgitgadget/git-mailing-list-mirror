From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fixes for option parsing
Date: Mon, 17 Apr 2006 07:51:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604170747580.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
 <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604161938070.3701@g5.osdl.org>
 <7vu08soou3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 16:52:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVV5C-0002XR-9b
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 16:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWDQOv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 10:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWDQOv6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 10:51:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61093 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751060AbWDQOv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 10:51:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3HEpotH017058
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Apr 2006 07:51:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3HEpnHJ009055;
	Mon, 17 Apr 2006 07:51:49 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu08soou3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18822>



On Sun, 16 Apr 2006, Junio C Hamano wrote:
> 
> I am not sure if that belongs to diffstat flush.  I was instead
> planning to  move it to diff-flush code

Well, that's broken right now with the stat part, for some reason.

> and show it only when we actually show any diffs.  IOW, I think we would 
> want it even when we are doing "--pretty -p", not "--pretty 
> --patch-with-stat".

I'd personally prefer to see it only in front of diffstat, and leave the 
patches the way they have been before. For patches, I find the indentation 
of the commit message to be visually (a) much more pleasing and (b) more 
pronounced than a "---" anyway.

Perhaps configurable? git-format-patch doesn't want the indentation (and 
thus "---" makes sense for both patches and diffstat), while "git log" 
definitely does, because it's much more visually clear _and_ it makes the 
header/comment structure totally unambiguous.

			Linus

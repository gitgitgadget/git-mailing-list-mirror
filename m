From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "Child" information in commit window - and cleanups
Date: Mon, 8 Aug 2005 20:09:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508082007380.3258@g5.osdl.org>
References: <Pine.LNX.4.58.0508081957150.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 09 05:10:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2KVX-0008SQ-Cs
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 05:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVHIDKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 23:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVHIDKO
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 23:10:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26579 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932428AbVHIDKN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 23:10:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7939njA006664
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Aug 2005 20:09:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7939l9Q014525;
	Mon, 8 Aug 2005 20:09:48 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0508081957150.3258@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 8 Aug 2005, Linus Torvalds wrote:
> 
> It also cleans things up: it marks the text widget as no-wrap, which means
> that it doesn't need to truncate the commit description arbitrarily by
> hand.

Btw, in case anybody wondered: there is no x-axis scroll-bar. I don't 
think one is needed, and if you _really_ want to scroll, you can do so 
by dragging with the middle-mouse-button.

I have to say, with tcl/tk, "google" + "random typing" can make you appear
to know what the hell you're doing.

			Linus

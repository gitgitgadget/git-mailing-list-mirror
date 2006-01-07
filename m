From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-ls-files -o no recurse?
Date: Sat, 7 Jan 2006 11:34:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601071131570.3169@g5.osdl.org>
References: <1136400692.5919.11.camel@localhost.localdomain>
 <Pine.LNX.4.64.0601041330550.3668@g5.osdl.org> <7vk6ddq8x2.fsf@assigned-by-dhcp.cox.net>
 <1136658207.6141.4.camel@localhost.localdomain> <7vace7khbi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Darrin Thompson <darrint@progeny.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 07 20:35:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvJqM-00079b-Ab
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 20:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWAGTei (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 14:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWAGTei
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 14:34:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161030AbWAGTeh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 14:34:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k07JYRDZ026813
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 7 Jan 2006 11:34:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k07JYOQf021847;
	Sat, 7 Jan 2006 11:34:25 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vace7khbi.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14271>



On Sat, 7 Jan 2006, Junio C Hamano wrote:
> 
> I have been unsure about the name "--directory", like you said.

Well, I didn't like "--directory" either, but couldn't come up with 
anything better. How about just "--no-recurse", which is not technically 
accurate (we always recurse into directories we know about), but might be 
more understandable.

The reason I called it "--directory" was that it would talk about 
directories that it doesn't know about (as opposed to individual files it 
doesn't know about). So "--other --directory" kind of makes sense if you 
read it that way ("show files and directories we don't know about").

But yeah, it's not a great name.

		Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-am: "Patch fragment without a header"
Date: Tue, 7 Feb 2006 07:46:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602070744250.3854@g5.osdl.org>
References: <43E80D23.4070007@zytor.com> <7vwtg73ld7.fsf@assigned-by-dhcp.cox.net>
 <43E814C2.6090104@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 16:48:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6V4Q-00047Z-Ts
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 16:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWBGPqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 10:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWBGPqb
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 10:46:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965134AbWBGPqU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 10:46:20 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k17Fk6DZ022588
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 7 Feb 2006 07:46:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k17Fk4ai002380;
	Tue, 7 Feb 2006 07:46:05 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43E814C2.6090104@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15695>



On Mon, 6 Feb 2006, H. Peter Anvin wrote:
> 
> Unfortunately git-mailinfo is in C, otherwise I'd have suggested using the
> Perl MIME-tools, which seems to have all this stuff in it.
> 
> It might just be easier to try to rewrite git-mailinfo in Perl...

It might just be easier to make the mime checking go the hell away.

I do _not_ want to see some random perl code for the stuff I use (hundreds 
of times) a day. I can apply 5 patches a second right now, and more 
importantly, I know what it does.

Partly because I always edit out the stupid MIME stuff. I think it was a 
mistake to accept MIME patches in the first place.

		Linus

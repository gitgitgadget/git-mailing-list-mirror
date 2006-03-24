From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cloning from sites with 404 overridden
Date: Fri, 24 Mar 2006 09:53:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603240945470.26286@g5.osdl.org>
References: <20060322025921.1722.qmail@science.horizon.com> <442152E0.4020604@op5.se>
 <slrne28b3a.cp6.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 18:54:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMqUJ-00051f-RA
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 18:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWCXRyN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 12:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWCXRyN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 12:54:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751320AbWCXRyL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 12:54:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2OHs0DZ019807
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Mar 2006 09:54:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2OHrxx2019183;
	Fri, 24 Mar 2006 09:53:59 -0800
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne28b3a.cp6.mdw@metalzone.distorted.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17931>


On Fri, 24 Mar 2006, Mark Wooding wrote:
> 
> (Aside: `C-u 38 0' doesn't work because Emacs hears `C-u 380' and waits
> for a key.  `M-: (insert-char ?0 38) RET' does the right thing, but is
> ugly.  Any better suggestions?)

I don't do GNU emacs, but the way to do it in some other editors that do
repeats somewhat similarly is to do the action that starts with a number
as a macro, and do that macro 37 more times. 

On uemacs: ^X '(' '0' ^X ')' ESC '3' '7' ^X 'E'

(Of course, the easier way is to just do '0' LEFT ^K to put the 0 in the
buffer, and than ESC '3' '8' ^Y to yank it 38 times, but the macro trick
is generic, even if it's a few more keystrokes). 

		Linus "teaching people the one true editor" Torvalds

From: Phil Richards <news@derived-software.ltd.uk>
Subject: Re: Enable the packed refs file format
Date: Wed, 20 Sep 2006 21:19:30 +0100 (BST)
Organization: Derived Software Ltd
Message-ID: <20060920201930.9E48F487D@derisoft.derived-software.demon.co.uk>
References: <Pine.LNX.4.64.0609141005440.4388@g5.osdl.org> <20060919205554.GA8259@pasky.or.cz> <Pine.LNX.4.64.0609191407340.4388@g5.osdl.org>
Reply-To: spams@derived-software.demon.co.uk
X-From: git-owner@vger.kernel.org Wed Sep 20 22:20:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ8Xj-0008U0-6C
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 22:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWITUTd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 16:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWITUTd
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 16:19:33 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:41742 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750726AbWITUTc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 16:19:32 -0400
Received: from derived-software.demon.co.uk ([83.104.60.195] helo=derisoft.derived-software.demon.co.uk)
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.42)
	id 1GQ8Xb-0009r2-Aw
	for git@vger.kernel.org; Wed, 20 Sep 2006 20:19:31 +0000
Received: by derisoft.derived-software.demon.co.uk (Postfix, from userid 9)
	id 9E48F487D; Wed, 20 Sep 2006 21:19:30 +0100 (BST)
Received: from 127.0.0.1 by 127.0.0.1 with nntp; 20 Sep 2006 21:19:30 BST
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0609191407340.4388@g5.osdl.org>
X-Newsreader: slrn/0.9.8.1 (Linux)
NNTP-Posting-Host: 127.0.0.1
NNTP-Posting-Date: Wed, 20 Sep 2006 20:19:30 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27398>

On 2006-09-19, Linus Torvalds <torvalds@osdl.org> wrote:
>  Too bad that we can't get gcc to warn on these things. We do mark it as 
>  "format(printf)", but I don't know of any way to tell gcc that it _has_ to 
>  have that initial constant string.

Not sure if it just a gcc 4.x-ism, but -Wformat-nonliteral or -Wformat-security
might be what you are looking for.

`-Wformat-nonliteral'
     If `-Wformat' is specified, also warn if the format string is not a
     string literal and so cannot be checked, unless the format function
     takes its format arguments as a `va_list'.

`-Wformat-security'
     If `-Wformat' is specified, also warn about uses of format
     functions that represent possible security problems.  At present,
     this warns about calls to `printf' and `scanf' functions where the
     format string is not a string literal and there are no format
     arguments, as in `printf (foo);'.  This may be a security hole if
     the format string came from untrusted input and contains `%n'.
     (This is currently a subset of what `-Wformat-nonliteral' warns
     about, but in future warnings may be added to `-Wformat-security'
     that are not included in `-Wformat-nonliteral'.)


phil
-- 
change name before "@" to "phil" for email

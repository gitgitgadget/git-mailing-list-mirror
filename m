From: Junio C Hamano <junkio@cox.net>
Subject: Re: ls-files and read-tree need core.filemode
Date: Tue, 08 Nov 2005 00:55:29 -0800
Message-ID: <7vacgfldry.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0511080023k1384dc26j944e9a07987be436@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 09:57:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZPGR-0005aH-CJ
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 09:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVKHIzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 03:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVKHIzc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 03:55:32 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:55496 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932498AbVKHIzb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 03:55:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108085508.DTNC1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 03:55:08 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511080023k1384dc26j944e9a07987be436@mail.gmail.com>
	(Alex Riesen's message of "Tue, 8 Nov 2005 09:23:37 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11317>

Alex Riesen <raa.lkml@gmail.com> writes:

> As usual, sorry for attachments.

Attachments are a bit cumbersome to quote but otherwise OK, at
least for me.  Linus never admits it, but I am hoping that he is
having a bit easier time applying e-mailed patches ever since
rudimentally MIME attachment handling was added.

However, please note that git-mailinfo which splits a piece of
e-mail into metainformation and patch part takes commit log
material only from the main message part, so having this
one-line explanation inside attachment is like having it under
the three-dash line.

>>    ls-files needs default config to ignore filemode on cygwin

I think this case you meant to do that; your main message part
was almost fine as is, as a commit log message (except perhaps
the initial "Hi," part ;-).

>>diff --git a/ls-files.c b/ls-files.c
>>--- a/ls-files.c
>>+++ b/ls-files.c
>>@@ -569,10 +569,11 @@ int main(int argc, const char **argv)
>> 	argv0 = *argv;

I wonder what this thing is, though.  I sense that usage()
cleanup patch that makes programs state their names
semi-automatically is coming...

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Sat, 19 Nov 2005 09:52:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511190950161.13959@g5.osdl.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org>
 <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
 <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
 <7vek5deam6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511181653191.13959@g5.osdl.org>
 <7v7jb57wud.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 18:54:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdWtY-0006W8-5b
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 18:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVKSRwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 12:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVKSRwm
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 12:52:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50323 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750739AbVKSRwm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 12:52:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAJHqZnO010391
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 19 Nov 2005 09:52:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAJHqYJA004692;
	Sat, 19 Nov 2005 09:52:34 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jb57wud.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12345>



On Sat, 19 Nov 2005, Junio C Hamano wrote:
> 
> Well, some people on the list seem to think UTF-8 is the one and
> only right encoding, so for them if the message does not
> identify what it is in, assuming UTF-8 and not doing any
> conversion is probably the right thing ;-).

If you replace "assume" with "verify", then I agree.

It's pretty easy to verify whether something is valid utf-8 or not (not 
trivial - you have to also check the sequences for minimality, which adds 
a few extra tests, but it's certainly not complicated).

And text with 8-bit latin1 is almost never valid utf-8. 

			Linus

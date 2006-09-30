From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Sat, 30 Sep 2006 10:36:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609301033460.3952@g5.osdl.org>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
 <Pine.LNX.4.64.0609272232040.9349@xanadu.home> <7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609281029300.9349@xanadu.home> <7vd59ejokp.fsf@assigned-by-dhcp.cox.net>
 <20060930045037.GB18479@spearce.org> <7v4pupizix.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 19:36:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTilT-0003Yk-Px
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 19:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWI3Rgg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 13:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWI3Rgg
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 13:36:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751331AbWI3Rgf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Sep 2006 13:36:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8UHaRaX002708
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Sep 2006 10:36:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8UHaQcQ026572;
	Sat, 30 Sep 2006 10:36:26 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pupizix.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.45 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28145>



On Sat, 30 Sep 2006, Junio C Hamano wrote:

> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Agreed.  I've been missing such a command and have wanted to add
> > one but it wasn't important enough to me to actually code it.  :)
> 
> Everything you said in your message sounds sane and makes sense
> to me.  Now we have to find a sucker^Wvolunteer to implement it
> ;-).

Ehh. As far as I can see it's 
 - a damn hard thing to do efficiently
 - essentially exactly the same problem you already solved with "git 
   describe"

In other words, I think you could make git describe do it, by simply 
making it parse not just all tags, but also walking the branch log.

		Linus

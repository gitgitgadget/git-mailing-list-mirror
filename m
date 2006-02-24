From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Removal of "--merge-order"?
Date: Fri, 24 Feb 2006 12:32:58 -0500
Message-ID: <20060224173258.GA16500@mythryan2.michonline.com>
References: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org> <Pine.LNX.4.58.0602240840520.7894@shark.he.net> <Pine.LNX.4.64.0602240918030.3771@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 18:34:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCgpN-0003Qy-96
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 18:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWBXRdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 12:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWBXRdz
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 12:33:55 -0500
Received: from mail.autoweb.net ([198.172.237.26]:5764 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932401AbWBXRdy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 12:33:54 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FCgp6-00048w-E6; Fri, 24 Feb 2006 12:33:47 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FCgp0-0004Rm-Ca; Fri, 24 Feb 2006 12:33:38 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FCgok-0004Kg-Ub; Fri, 24 Feb 2006 12:33:22 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602240918030.3771@g5.osdl.org>
User-Agent: Mutt/1.5.9i
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16717>

On Fri, Feb 24, 2006 at 09:23:24AM -0800, Linus Torvalds wrote:
> On Fri, 24 Feb 2006, Randy.Dunlap wrote:
> > 
> > I'm just a lowly user, but I see people trying to export git
> > trees to other SCMs, and they seem to prefer merge-order.
> > This is your chance to correct me about:
> > (a) how I am wrong; (b) how they are wrong.  8;)
> 
> Well, I didn't even realize anybody at all was using it. I've never seen 
> any mention of it, and considering how ungodly slow it is, I would have 
> expected somebody to pipe up about it..
> 
> I did a google search for "git" and "merge-order", and the only actual use 
> (as opposed to mention in a man-page) I found in the 20 hits google showed 
> was an old version of gitk.

http://www.gelato.unsw.edu.au/archives/git/0511/12965.html

But topo-order would probably work as well, the default ordering just
didn't work correctly in my tests.

Certainly not a case that votes *against* removal, just noting an actual
user at one point.

-- 

Ryan Anderson
  sometimes Pug Majere

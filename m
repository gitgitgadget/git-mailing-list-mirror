From: Johan Herland <johan@herland.net>
Subject: Re: RFC: submodule terminology
Date: Mon, 21 May 2007 00:06:47 +0200
Message-ID: <200705210006.47266.johan@herland.net>
References: <20070520214417.GM5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Martin Waitz <tali@admingilde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 00:07:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HptYK-0003mP-DV
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292AbXETWGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757425AbXETWGz
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:06:55 -0400
Received: from smtp.getmail.no ([84.208.20.33]:60082 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757292AbXETWGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:06:54 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JID00D0B1FDC800@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 21 May 2007 00:06:49 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JID00KI21FBUF40@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 21 May 2007 00:06:48 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JID00HW71FB0880@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 21 May 2007 00:06:47 +0200 (CEST)
In-reply-to: <20070520214417.GM5412@admingilde.org>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47933>

On Sunday 20 May 2007, Martin Waitz wrote:
> hoi :)
> 
> I think we should agree to one name for what currently is named
> submodule / subproject / dirlink / gitlink.
> 
> Or use one name for the low-level plumbing (have a tree entry
> which points to another commit): dirlink or gitlink and another
> one for the high-level UI think: submodule or subproject.
> But then we should use those names consequently.
> 
> Oppinions?


For the high-level concept, "subproject" seems to me the best 
alternative. I think it is much better than "submodule" at 
describing that the subproject is a stand-alone project/repo in
itself.

As for the low-level concept, I personally prefer "gitlink", but 
I don't have any strong feelings. The fact that "gitlink" seems 
to already be used in the code (as in resolve_gitlink_ref() etc.), 
coupled with "dirlink" being somewhat ambiguous (i.e. may also be 
interpreted as "(sym)link to directory") makes the case for me.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

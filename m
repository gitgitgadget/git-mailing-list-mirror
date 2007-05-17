From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Document core.excludesfile for git-add
Date: Thu, 17 May 2007 17:45:09 +0200
Message-ID: <200705171745.09307.johan@herland.net>
References: <1179378530822-git-send-email-michael@ndrix.org>
 <7vwsz89ftr.fsf@assigned-by-dhcp.cox.net>
 <20070517143542.GB15709@ginosko.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Michael Hendricks <michael@ndrix.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 17:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoiB2-0005dN-FI
	for gcvg-git@gmane.org; Thu, 17 May 2007 17:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbXEQPp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 11:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbXEQPp6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 11:45:58 -0400
Received: from [84.208.20.33] ([84.208.20.33]:40492 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754483AbXEQPp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 11:45:57 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JI600L0FZRTRJ00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 17:45:29 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI600C67ZR9H430@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 17:45:09 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI6009QLZR9CQA0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 17:45:09 +0200 (CEST)
In-reply-to: <20070517143542.GB15709@ginosko.local>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47534>

On Thursday 17 May 2007, Michael Hendricks wrote:
> On Wed, May 16, 2007 at 10:31:12PM -0700, Junio C Hamano wrote:
> > Thanks, but wouldn't this belong to Documentation/config.txt
> > instead, I wonder?
> 
> It appears to my untrained eye that core.excludesfiles only works for
> git-add.  It seems to have no effect on git-status and the only code
> that mentions core.excludesfile is builtin-add.c

If so, we should probably fix that. The set of ignore files parsed by 
relevant git commands should be consistent. We don't want a situation 
where exclude patterns in a file are picked up by some git commands, but
not by others.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

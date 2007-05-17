From: Johan Herland <johan@herland.net>
Subject: Re: Commit ID in exported Tar Ball
Date: Thu, 17 May 2007 18:57:22 +0200
Message-ID: <200705171857.22891.johan@herland.net>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 18:57:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HojIF-0005RP-0v
	for gcvg-git@gmane.org; Thu, 17 May 2007 18:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbXEQQ51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 12:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754561AbXEQQ51
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 12:57:27 -0400
Received: from [84.208.20.33] ([84.208.20.33]:46613 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754417AbXEQQ51 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 12:57:27 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JI70040X33QR300@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 18:57:26 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI7005JX33N2NA0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 18:57:23 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JI700L5N33NXU40@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 17 May 2007 18:57:23 +0200 (CEST)
In-reply-to: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47538>

On Thursday 17 May 2007, Thomas Glanzmann wrote:
> Hello,
> Michae, a friend of mine, is in the phase of migrating from git to cvs.
                                                         ^^^^^^^^^^^^^^^
Man... You are _definitely_ on the wrong list. ;)

> He releases tar balls of his software project using gitweb. He would
> love to have a way to have the commit-id of HEAD of the export contained
> in one of the files he exported that way. Is there infrastructure in git
> that makes that already possible or does he need to some kind of
> gerneration tool by himself? Maybe it would be helpful if the
> git-tar-tree would generate a file .commitid or something like that in
> the generated tar tree.

Hmm, doesn't seem like git-tar-tree (or git-archive for that matter) 
supports this out of the box. Maybe it's possible to achieve in combination 
with the $Id$ construct?

I guess it depends on whether git-tar-tree/git-archive actually does a 
checkout from the repo from which the archive is made. If so, it should 
be possible to store "$Id$" in .commitid, and check it in, and it should 
automagically appear with the correct commit-id in your archive.

Of course, it all depends on whether the $Id$ conversion is triggered by 
git-archive...


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: Linux 2.6.15-rc2
Date: Thu, 24 Nov 2005 07:37:57 -0500
Organization: me
Message-ID: <200511240737.59153.tomlins@cam.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 24 13:38:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfGMA-0005bH-MK
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 13:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbVKXMhc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 07:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVKXMhb
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 07:37:31 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:15100 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S932331AbVKXMhb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2005 07:37:31 -0500
Received: from grover (dsl-156-165.aei.ca [66.36.156.165])
	by aeimail.aei.ca (8.12.10/8.12.10) with ESMTP id jAOCbHFP025803;
	Thu, 24 Nov 2005 07:37:17 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12706>

On Saturday 19 November 2005 22:40, Linus Torvalds wrote:
> There it is (or will soon be - the tar-ball and patches are still 
> uploading, and mirroring can obviously take some time after that).

Something strange here.   After a cg-update, I had no tag for rc2.   Checking
showed no problems so I used cg-clone to get another copy of the repository.
Still no rc2.

ed@grover:/usr/src/2.6$ cg-version
cogito-0.16rc2 (73874dddeec2d0a8e5cd343eec762d98314def63)
ed@grover:/usr/src/2.6$ git --version
git version 0.99.9.GIT

cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 2.6

It looks to be the tag that is missing, gitk show commits after Nov 19.

Both git and cg were  updated just prior to the cg-update (~Nov 22 8pm EST).

What is happening?

TIA
Ed Tomlinson

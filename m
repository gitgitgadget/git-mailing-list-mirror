From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Wed, 01 Feb 2006 00:51:56 -0800
Message-ID: <7vslr3ea1f.fsf@assigned-by-dhcp.cox.net>
References: <20060201070847.2021.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 10:02:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Diq-0001wI-Db
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 09:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWBAIv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 03:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWBAIv7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 03:51:59 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:13487 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750724AbWBAIv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 03:51:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201085055.GPXZ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 03:50:55 -0500
To: linux@horizon.com
In-Reply-To: <20060201070847.2021.qmail@science.horizon.com>
	(linux@horizon.com's message of "1 Feb 2006 02:08:47 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15397>

linux@horizon.com writes:

> At the risk of complicating something already very complicated, and
> possibly breaking on Microsoft file systems, that case can be detected
> by reading the directory and noticing that the inode number changed.
>
> Would it be worth validating the inode numbers (which can be retrieved
> in a batch) even if you don't do a full lstat()?

I suspect that what you said about Microsoft filesystems is even
stronger. IIRC the latest Cygwin stopped giving d_ino regardless
of the filesystem type; you need to do a stat() anyway.

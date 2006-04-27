From: Wolfgang Denk <wd@denx.de>
Subject: cg-clone not fetching all tags?
Date: Thu, 27 Apr 2006 12:52:51 +0200
Message-ID: <20060427105251.AA4B2353DAC@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Apr 27 12:54:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ48V-0003QF-LJ
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 12:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWD0Kwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 06:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWD0Kwz
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 06:52:55 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:16819 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S965110AbWD0Kwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 06:52:53 -0400
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 59B2E70802
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 12:52:52 +0200 (CEST)
X-Auth-Info: kH+dan83ChvGu1KhqN8dcRi0JpNJWmuYLZb+FZlnYrs=
Received: from mail.denx.de (p54965C06.dip.t-dialin.net [84.150.92.6])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 42B08909C1
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 12:52:52 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id C31126D0112
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 12:52:51 +0200 (CEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id AA4B2353DAC
	for <git@vger.kernel.org>; Thu, 27 Apr 2006 12:52:51 +0200 (MEST)
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19227>

Hi,

it seems that "cg-clone" does not fetch all tags any more - only  the
most  recent ones (modiufied in the last N days?) seem to be fetched?
[Eventually the "N days"  might  correspond  to  "changing  tools  to
version X", but I have no way to find out.]

This happens only when using HTTP; using ssh  or  rsync  works  fine.
Also,  if  we follow the "cg-clone" by a "git-fetch -t" command, this
will load the missing tags.

Is this intentional, or am I doing anything wrong?

[For testing, try "cg-clone http://www.denx.de/git/u-boot.git"]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In theory, there is no difference between  theory  and  practice.  In
practice, however, there is.

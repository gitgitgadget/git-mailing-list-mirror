From: Wolfgang Denk <wd@denx.de>
Subject: Re: cg-clone not fetching all tags?
Date: Sat, 29 Apr 2006 16:00:42 +0200
Message-ID: <20060429140042.1FB37353DAC@atlas.denx.de>
References: <20060427105251.AA4B2353DAC@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Apr 29 16:00:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZq07-0006YP-4w
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 16:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWD2OAo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 10:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWD2OAo
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 10:00:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:1239 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1750726AbWD2OAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 10:00:43 -0400
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id B501B70D7B
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 16:00:42 +0200 (CEST)
X-Auth-Info: 0un+arvgBxAVJQiePPTHVRvE14Ad+Kv9g6knsYERZ8s=
Received: from mail.denx.de (p54966E7A.dip.t-dialin.net [84.150.110.122])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id A0BF692289
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 16:00:42 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 3C0B76D0112
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 16:00:42 +0200 (CEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 1FB37353DAC
	for <git@vger.kernel.org>; Sat, 29 Apr 2006 16:00:42 +0200 (MEST)
To: Git Mailing List <git@vger.kernel.org>
In-reply-to: Your message of "Thu, 27 Apr 2006 12:52:51 +0200."
             <20060427105251.AA4B2353DAC@atlas.denx.de> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19304>

[Repost because there was zero response, not even somebody telling me
to RTFM or so.]

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

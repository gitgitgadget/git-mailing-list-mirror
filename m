From: Wolfgang Denk <wd@denx.de>
Subject: Re: Cannot get git any more?
Date: Wed, 20 Jul 2005 01:50:46 +0200
Message-ID: <20050719235046.8245A352676@atlas.denx.de>
References: <20050719233839.GC2255@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 20 01:51:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dv1ri-0006lS-QC
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 01:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVGSXu6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jul 2005 19:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVGSXu6
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jul 2005 19:50:58 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:20202 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261684AbVGSXu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2005 19:50:56 -0400
Received: from fwd23.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1Dv1rQ-00057l-00; Wed, 20 Jul 2005 01:50:52 +0200
Received: from denx.de (GcHOpOZTweallxWRYTTuYZHXjAgC1lZpU2DTkkhJH00SrmaV0LATcj@[84.150.100.121]) by fwd23.sul.t-online.de
	with esmtp id 1Dv1rL-1v2Fcm0; Wed, 20 Jul 2005 01:50:47 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id A590542E8F; Wed, 20 Jul 2005 01:50:46 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 8245A352676;
	Wed, 20 Jul 2005 01:50:46 +0200 (MEST)
To: Petr Baudis <pasky@suse.cz>
In-reply-to: Your message of "Wed, 20 Jul 2005 01:38:39 +0200."
             <20050719233839.GC2255@pasky.ji.cz> 
X-ID: GcHOpOZTweallxWRYTTuYZHXjAgC1lZpU2DTkkhJH00SrmaV0LATcj@t-dialin.net
X-TOI-MSGID: af0c3213-0477-4a08-a998-af7843a086ab
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <20050719233839.GC2255@pasky.ji.cz> you wrote:
>
> > -> cg-clone rsync://rsync.kernel.org/pub/scm/git/git.git
> > /usr/local/src/git
> > defaulting to local storage area
> > @ERROR: Unknown module 'pub'
> > rsync: connection unexpectedly closed (41 bytes read so far)
> > rsync error: error in rsync protocol data stream (code 12) at io.c(342)
> > cg-pull: unable to get the head pointer of branch master
> > cg-init: pull failed
> 
> That's puzzling. Try just
> 
> 	rsync -a rsync://rsync.kernel.org/pub/scm/git/git.git /usr/local/src/git

Thanks for the tip. You are right. This  was  caused  by  an  unlucky
change to one of our firewall rules ;-(

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Applying computer technology is simply finding the  right  wrench  to
pound in the correct screw.

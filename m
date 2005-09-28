From: Wolfgang Denk <wd@denx.de>
Subject: Re: git cvsimport?
Date: Wed, 28 Sep 2005 18:35:08 +0200
Message-ID: <20050928163508.3CDB4352B7B@atlas.denx.de>
References: <20050928160427.GU15165MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 18:39:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKeuG-0007th-Cr
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 18:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVI1Qfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 12:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVI1Qfk
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 12:35:40 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:21381 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751400AbVI1Qfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 12:35:39 -0400
Received: from fwd29.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1EKeu4-0002Db-04; Wed, 28 Sep 2005 18:35:32 +0200
Received: from denx.de (rXRIA2ZpoeYu28+4Dz4QLxkyiIIPdby5lx7xe-U8amykCe6rybA1UU@[84.150.99.17]) by fwd29.sul.t-online.de
	with esmtp id 1EKetn-0M58Vc0; Wed, 28 Sep 2005 18:35:15 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 52DA042F90; Wed, 28 Sep 2005 18:35:14 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 3CDB4352B7B;
	Wed, 28 Sep 2005 18:35:08 +0200 (MEST)
To: skimo@liacs.nl
In-reply-to: Your message of "Wed, 28 Sep 2005 18:04:27 +0200."
             <20050928160427.GU15165MdfPADPa@greensroom.kotnet.org> 
X-ID: rXRIA2ZpoeYu28+4Dz4QLxkyiIIPdby5lx7xe-U8amykCe6rybA1UU@t-dialin.net
X-TOI-MSGID: 8df60755-47cc-4e3a-a2ca-0a4c581ebb62
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9437>

In message <20050928160427.GU15165MdfPADPa@greensroom.kotnet.org> you wrote:
>
> > -> cvsps -u -A --cvs-direct --root :pserver:denx@cvs.semihalf.com:/cvs duts
> > connect error: Network is unreachable
> > cvs rlog: cannot find module `duts' - ignored
> 
> Does leaving out the --cvs-direct have any effect ?

Yes, the "Network is unreachable" disappears:

-> cvsps -u -A --root :pserver:denx@cvs.semihalf.com:/cvs duts
cvs rlog: cannot find module `duts' - ignored

This is cvsps version 2.1.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Your csh still thinks true is false. Write to your vendor  today  and
tell them that next year Configure ought to "rm /bin/csh" unless they
fix  their blasted shell. :-)
                 - Larry Wall in Configure from the perl distribution

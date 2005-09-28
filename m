From: Wolfgang Denk <wd@denx.de>
Subject: Re: git cvsimport?
Date: Wed, 28 Sep 2005 17:49:55 +0200
Message-ID: <20050928154955.EB723353BE5@atlas.denx.de>
References: <20050928151812.GS15165MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 17:50:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKeCQ-0002qA-JJ
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 17:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbVI1PuX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVI1PuX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 11:50:23 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:37331 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751010AbVI1PuX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 11:50:23 -0400
Received: from fwd26.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1EKeCE-0001D0-03; Wed, 28 Sep 2005 17:50:14 +0200
Received: from denx.de (V+j34MZ6oez+abJN-119Q-ANEv24OwKzj5w9jQI9WVb6eTfEQD2Ig2@[84.150.99.17]) by fwd26.sul.t-online.de
	with esmtp id 1EKeC3-0yHHhQ0; Wed, 28 Sep 2005 17:50:03 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 1EDCF42B8F; Wed, 28 Sep 2005 17:50:01 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id EB723353BE5;
	Wed, 28 Sep 2005 17:49:55 +0200 (MEST)
To: skimo@liacs.nl
In-reply-to: Your message of "Wed, 28 Sep 2005 17:18:12 +0200."
             <20050928151812.GS15165MdfPADPa@greensroom.kotnet.org> 
X-ID: V+j34MZ6oez+abJN-119Q-ANEv24OwKzj5w9jQI9WVb6eTfEQD2Ig2@t-dialin.net
X-TOI-MSGID: 895e4f1a-4466-48bc-9796-1c4a3c24b449
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9435>

In message <20050928151812.GS15165MdfPADPa@greensroom.kotnet.org> you wrote:
>
> > I have problems importing a CVS repository:
...
> What does 
> cvsps -u -A --cvs-direct --root :pserver:denx@cvs.semihalf.com:/cvs duts
> say ?

-> cvsps -u -A --cvs-direct --root :pserver:denx@cvs.semihalf.com:/cvs duts
connect error: Network is unreachable
cvs rlog: cannot find module `duts' - ignored


But "cvs -d :pserver:denx@cvs.semihalf.com:/cvs co duts" works fine...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I have a very small mind and must live with it.    -- Edsger Dijkstra

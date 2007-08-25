From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: how do you "force a pull"?
Date: Sat, 25 Aug 2007 07:53:26 -0400
Message-ID: <20070825115326.GB7122@falcon.digizenstudio.com>
References: <20070825111946.GA7122@falcon.digizenstudio.com> <20070825113747.GA21030@mimvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 13:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOuDP-0002Xw-Gu
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 13:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933530AbXHYLxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 07:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933504AbXHYLxh
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 07:53:37 -0400
Received: from k2smtpout01-02.prod.mesa1.secureserver.net ([64.202.189.89]:60428
	"HELO k2smtpout01-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1765059AbXHYLxg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 07:53:36 -0400
Received: (qmail 29429 invoked from network); 25 Aug 2007 11:53:36 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout01-01.prod.mesa1.secureserver.net (64.202.189.88) with ESMTP; 25 Aug 2007 11:53:36 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 2742B100A0F
	for <git@vger.kernel.org>; Sat, 25 Aug 2007 11:53:36 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UM9MpvPBLPx8 for <git@vger.kernel.org>;
	Sat, 25 Aug 2007 07:53:27 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id D08E2100587
	for <git@vger.kernel.org>; Sat, 25 Aug 2007 07:53:27 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id DC62F7B51B; Sat, 25 Aug 2007 07:53:26 -0400 (EDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070825113747.GA21030@mimvista.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56633>

On Sat, Aug 25, 2007 at 07:37:47AM -0400, David Watson wrote:
> $ git reset --hard origin/master

Ah, this is what I was looking for. Not very intuitive, but works like a
charm!

> You may be getting the "cannot merge message" if you have uncommitted
> changes, as git won't let you merge when the working copy is changed.
> git-pull is really git-fetch + git-merge.

Right, because I used "--soft" in the earlier reset.

Thanks!
-- 
Jing Xue

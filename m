From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Mon, 24 Apr 2006 14:24:47 -0400
Message-ID: <9EB87AF5-ACC3-4213-81B9-EF87AE68401C@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <444A2334.3030501@lsrfire.ath.cx> <20060424025741.GA636@adacore.com> <Pine.LNX.4.64.0604232327500.3603@localhost.localdomain> <20060424151901.GA2663@adacore.com> <Pine.LNX.4.64.0604241123490.18520@localhost.localdomain> <D1E1F442-2CE8-4CA0-A6E6-94B8FFC5E82D@adacore.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 24 20:25:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY5jz-0006gD-SL
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 20:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWDXSYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 14:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWDXSYw
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 14:24:52 -0400
Received: from nile.gnat.com ([205.232.38.5]:21433 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1751070AbWDXSYv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 14:24:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 649D648CC13;
	Mon, 24 Apr 2006 14:24:48 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 19154-01-6; Mon, 24 Apr 2006 14:24:47 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id E860B48CBE6;
	Mon, 24 Apr 2006 14:24:47 -0400 (EDT)
In-Reply-To: <D1E1F442-2CE8-4CA0-A6E6-94B8FFC5E82D@adacore.com>
To: Geert Bosch <bosch@adacore.com>
X-Mailer: Apple Mail (2.749.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19098>


On Apr 24, 2006, at 12:31, Geert Bosch wrote:
> BTW, I still get:
> potomac%git-rev-list --objects  
> e64961b0573b0e72bd55eab6d36bd97f859f9516 | ./git-pack-objects --no- 
> reuse-delta --stdout
> Generating pack...
> Done counting 17005 objects.
> Deltifying 17005 objects.
> 100% (17005/17005) done
> fatal: delta size changed
> (This is for my git.git tree.)

Ignore this, I hadn't had my coffee yet.

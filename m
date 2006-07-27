From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] mailinfo: accept >From in message header
Date: Thu, 27 Jul 2006 14:22:07 -0700
Message-ID: <7vbqraoi9s.fsf@assigned-by-dhcp.cox.net>
References: <20060727140343.GS9411@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 23:22:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6DJ8-0005Pu-KX
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 23:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWG0VWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 17:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWG0VWJ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 17:22:09 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40190 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751298AbWG0VWI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 17:22:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060727212208.MOVQ27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Jul 2006 17:22:08 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060727140343.GS9411@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 27 Jul 2006 17:03:43 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> From Majordomo@vger.kernel.org  Thu Jul 27 16:39:36 2006
>>From mtsirkin  Thu Jul 27 16:39:36 2006
> Received: from yok.mtl.com [10.0.8.11]
> ....
>
> which confuses git-mailinfo since that does not recognize >From
> as a valid header line. The following patch makes git-applymbox
> work for me:

Wouldn't that kind of breakage confuse git-mailsplit as well?

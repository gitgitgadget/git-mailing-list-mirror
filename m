From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] Use a hashtable for objects instead of a sorted list
Date: Sun, 12 Feb 2006 09:52:15 +0100
Message-ID: <87oe1dez7k.fsf@wine.dyndns.org>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.63.0602120254260.10235@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virrli9am.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 09:52:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Cy5-0000TG-5Z
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 09:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWBLIwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 03:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWBLIwY
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 03:52:24 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:40634 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932247AbWBLIwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 03:52:23 -0500
Received: from adsl-84-226-38-133.adslplus.ch ([84.226.38.133] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1F8Cxu-0001Gw-MN; Sun, 12 Feb 2006 02:52:20 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 12B364F92A; Sun, 12 Feb 2006 09:52:16 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virrli9am.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 11 Feb 2006 18:46:09 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-SA-Exim-Connect-IP: 84.226.38.133
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15989>

Junio C Hamano <junkio@cox.net> writes:

> I am also interested to find out how much the rehashing you do
> when you update obj_allocs to a larger value is costing.
>
> Alexandle, if you have a chance, could you try Johannes' patch
> on your workload to see if it works OK for you?

It works great for me, CPU time is down to 15 sec instead of 20 sec
with my patch.

-- 
Alexandre Julliard
julliard@winehq.org

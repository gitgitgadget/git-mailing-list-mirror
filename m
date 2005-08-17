From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Wed, 17 Aug 2005 13:36:51 -0400
Message-ID: <430375B3.3050307@pobox.com>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>	<7vek8t7bva.fsf@assigned-by-dhcp.cox.net> <7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 19:37:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Rqd-0003d1-4f
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 19:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVHQRhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 13:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVHQRhE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 13:37:04 -0400
Received: from mail.dvmed.net ([216.237.124.58]:53188 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751170AbVHQRhC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 13:37:02 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1E5RqR-00007Z-Ra; Wed, 17 Aug 2005 17:36:58 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


If someone is thus motivated, I have two requests in this area:

1) Fix applymbox such that it understands RFC822-valid Subject lines 
which wrap across multiple text lines.

2) Teach it to understand MIME, and not treat the MIME headers like part 
of the message.

From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Today's kernel git snapshot broke.
Date: Wed, 29 Jun 2005 17:39:16 -0400
Message-ID: <42C31504.3030502@pobox.com>
References: <1120078535.3690.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 23:34:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnkAv-0001TQ-Qv
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 23:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVF2VkD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 17:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVF2Vj3
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 17:39:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:22495 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262474AbVF2VjZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 17:39:25 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DnkHA-0000jO-3t; Wed, 29 Jun 2005 21:39:23 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1120078535.3690.12.camel@localhost.localdomain>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse wrote:
> /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/73/3ad933f62e82ebc92fed988c7f0795e64dea62: No such file or directory
> fatal: git-cat-file 733ad933f62e82ebc92fed988c7f0795e64dea62: bad file
> Invalid id: 733ad933f62e82ebc92fed988c7f0795e64dea62

This.  Linus uploaded a tag in .git/tags/v2.6.13-rc1, but did not upload 
the associated tag object.

	Jeff

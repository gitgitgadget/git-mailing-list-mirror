From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Add git-relink-script to fix up missing hardlinks
Date: Sun, 26 Jun 2005 14:36:58 -0400
Message-ID: <42BEF5CA.1060809@pobox.com>
References: <20050626181516.GC20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 26 20:30:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmbtl-0004Ys-Ej
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 20:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVFZShM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 14:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVFZShM
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 14:37:12 -0400
Received: from mail.dvmed.net ([216.237.124.58]:28364 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261469AbVFZShI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 14:37:08 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Dmc05-0006uF-IX; Sun, 26 Jun 2005 18:37:02 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050626181516.GC20369@mythryan2.michonline.com>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson wrote:
> Add git-relink-script
> 
> This will scan 2 or more object repositories and look for common objects, check
> if they are hardlinked, and replace one with a hardlink to the other if not.
> 
> This version warns when skipping files because of size differences, and
> handle more than 2 repositories automatically.
> 
> Signed-off-by: Ryan Anderson <ryan@michonline.com>

Thanks for posting this.

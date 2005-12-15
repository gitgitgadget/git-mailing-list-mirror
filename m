From: Don Zickus <dzickus@gmail.com>
Subject: bad git pull
Date: Thu, 15 Dec 2005 18:37:47 -0500
Message-ID: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Dec 16 00:39:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En2fZ-0006OS-6G
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 00:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVLOXhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 18:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVLOXhs
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 18:37:48 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:15034 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751207AbVLOXhs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 18:37:48 -0500
Received: by zproxy.gmail.com with SMTP id 12so544600nzp
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 15:37:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RlhFhxR1Q5ZRbNLukjETEZUIRyokFTaPG5toBt49Qn/1eCjYKLaUm4j5RNHHSNiw2OPR7adViwhQ5OVxHCTNyrmovPjyVo3MXbR4JJJoHCuctnLDmTgFTKhsjjzx+ymGmBO0LTTS0lqKK6nvYlrfCWOh8swdibknKxwb36fj/2s=
Received: by 10.65.139.11 with SMTP id r11mr1587990qbn;
        Thu, 15 Dec 2005 15:37:47 -0800 (PST)
Received: by 10.65.240.20 with HTTP; Thu, 15 Dec 2005 15:37:47 -0800 (PST)
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13719>

Hello,

I notice if I create a branch (and switch to it) in the linux kernel
off of say version 2.6.14, then later do a git pull, things get ugly. 
It seems like all the upstream changes are being merged into the
2.6.14 branch (instead of the latest kernel tag).

Is this a user error because the tool is still fragile?

Thanks,
Don

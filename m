From: Nemina Amarasinghe <neminaa@gmail.com>
Subject: Re: [PATCH] simplifying =?utf-8?b?YnJhbmNoLmM6aW5zdGFsbF9icmFuY2hfY29uZmlnKCk=?= if()
Date: Fri, 14 Mar 2014 04:22:56 +0000 (UTC)
Message-ID: <loom.20140314T051213-863@post.gmane.org>
References: <1394761558-4888-1-git-send-email-neminaa@gmail.com> <20140314021052.GH15625@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 05:23:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOJf0-0003Hx-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 05:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbaCNEXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 00:23:24 -0400
Received: from plane.gmane.org ([80.91.229.3]:36904 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbaCNEXY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 00:23:24 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WOJeT-0002i6-1D
	for git@vger.kernel.org; Fri, 14 Mar 2014 05:23:21 +0100
Received: from 61.245.163.11 ([61.245.163.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 05:23:21 +0100
Received: from neminaa by 61.245.163.11 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 05:23:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 61.245.163.11 (Mozilla/5.0 (Linux; Android 4.3; GT-N7100 Build/JSS15J) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.136 Mobile Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244073>

 Is this safe?  Today branch.c::create_branch 
checks that the argument
> to e.g. --set-upstream-to is either in 
refs/heads/* or the image of
> some remote, but what is making sure that remains 
true tomorrow?
> 
> So if changing this, I would be happier if the 
"if" condition were
> still (!remote_is_branch && origin) so the 
impossible case could emit
> a BUG.
> 
> Hope that helps,
> Jonathan
> 

Thanks for the coments Jonathan,
Yes you are correct... I was just thought about how 
to simplify this chain of if() statement. Not the 
big picture. Now I understand when I change or 
implenet something I have to think not only about 
the current matter but abot the future also.

Nemina

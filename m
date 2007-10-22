From: "Scott R Parish" <srp@srparish.net>
Subject: Re: [PATCH] use only the PATH for exec'ing git commands
Date: Mon, 22 Oct 2007 17:12:02 -0500 (CDT)
Message-ID: <1193091122.v2.fusewebmail-240137@f>
Reply-To: srp@srparish.net
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
To: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 00:12:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik5Vy-0005Fe-TM
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 00:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbXJVWMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 18:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbXJVWMG
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 18:12:06 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:49009 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbXJVWME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 18:12:04 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtpa (MailAnyone extSMTP srp)
	id 1Ik5VD-00023a-F0; Mon, 22 Oct 2007 17:12:03 -0500
Received: from 127.0.0.1
        (FuseMail web AccountID 240137)
        by webmail.fusemail.com with HTTP;
        Mon, 22 Oct 2007 17:12:02 -0500 (CDT)
User-Agent: FuseMail W
X-Priority: 3
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62049>

> Alex Riesen, Mon, Oct 22, 2007 12:01
> Scott R Parish, Mon, Oct 22, 2007 19:01:48 +0200:
> > +                strbuf_addch(out, ':');
>
> Shouldn't it break MingW32 native port?

What can i do here to better accommodate MingW32? You're
right, just because the original code did it this way
isn't a good excuse for me not to do it better.

sRp

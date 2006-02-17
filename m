From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Fri, 17 Feb 2006 21:57:49 +0000
Message-ID: <43F646DD.8040103@gmail.com>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 22:58:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FADbw-0007Ry-Gp
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 22:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWBQV5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 16:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWBQV5x
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 16:57:53 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:16254 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751022AbWBQV5x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 16:57:53 -0500
Received: from aamta10-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20060217215751.XIPW23947.mta09-winn.ispmail.ntl.com@aamta10-winn.ispmail.ntl.com>;
          Fri, 17 Feb 2006 21:57:51 +0000
Received: from [192.168.1.101] (really [86.15.186.141])
          by aamta10-winn.ispmail.ntl.com with ESMTP
          id <20060217215751.ZESF6973.aamta10-winn.ispmail.ntl.com@[192.168.1.101]>;
          Fri, 17 Feb 2006 21:57:51 +0000
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060213210001.GA31278@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16372>

Petr Baudis wrote:
> 	* I can't just get the patch in its "canonical ready-to-mail
> 	form" on stdout so that I could easily review it. Why is
> 	pg-export insisting to dump it to a file?

I pushed tonight 2 patches for this. One of them adds a --stdout option
to 'export' so that you can see the patches. The other patch adds a
--mbox option to 'mail' that generates an mbox file on the stdout. This
is useful not only for reviewing patches.

-- 
Catalin

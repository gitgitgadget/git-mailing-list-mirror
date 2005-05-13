From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Improve option parsing for cg-log
Date: Fri, 13 May 2005 11:05:34 +0200
Message-ID: <1115975134.18499.94.camel@pegasus>
References: <1115931114.18499.66.camel@pegasus>
	 <20050512211315.GP324@pasky.ji.cz> <1115934586.18499.70.camel@pegasus>
	 <20050513054140.GF16464@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 13 10:58:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWVz8-0004qq-Qj
	for gcvg-git@gmane.org; Fri, 13 May 2005 10:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVEMJFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 05:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVEMJFO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 05:05:14 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:28337 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262313AbVEMJFJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 05:05:09 -0400
Received: from pegasus (p5487CC4D.dip.t-dialin.net [84.135.204.77])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4D96XWX023364
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Fri, 13 May 2005 11:06:34 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513054140.GF16464@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.83/875/Tue May 10 13:27:59 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > > > the attached patch changes the option parsing, because otherwise we are
> > > > stuck to a specific order.
> > > 
> > > thanks, applied. However, you didn't include the -r options parsing in
> > > there yet.
> > 
> > what do you mean by that?
> 
> The -r option still must be after all the other options.

I see what you mean and it seems that I missed that option. Must be
because you put the list_commit_files() between them and I assumed that
there is no further option parsing.

Do you really wanna keep the double meaning of -r. Depending on a
previous -r it is $log_start or $log_end.

Regards

Marcel



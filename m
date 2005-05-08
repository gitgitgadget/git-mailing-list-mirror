From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: cg-log patches
Date: Sun, 08 May 2005 21:27:03 +0200
Message-ID: <1115580423.8949.23.camel@pegasus>
References: <1742.10.10.10.24.1115573750.squirrel@linux1>
	 <1115574136.9031.147.camel@pegasus>
	 <1856.10.10.10.24.1115576809.squirrel@linux1>
	 <1115578807.8949.12.camel@pegasus>  <20050508191831.GD9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 21:22:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrLp-000265-9e
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbVEHT2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbVEHT2l
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:28:41 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:63917 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262982AbVEHT0o
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 15:26:44 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48JRwWX004941
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 21:27:58 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508191831.GD9495@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > However there is another thing that I am missing. With Bitkeeper I was
> > able to do something like "bk changes -umarcel" to list all changes done
> > by the user "marcel". I like to have something similar with cg-log. Any
> > ideas on how to do that?
> 
> What should it take in regard? Username portion of the email address?
> The email address itself? The realname?

good question. Bitkeeper was only able to handle the user part of the
address. Maybe we can make cg-log a little bit more intelligent. We also
have the author and the committer. My idea would be to use -A for the
author and -C for the committer and maybe -U to search in both. If the
value contains and "@" it should search in the email address part and
otherwise in the username portion. Some regular expression stuff like
"^marcel" (case insensitive) would also be great.

I have no idea how to realize it, but would be thankful for such an
option. It is one of the last pieces that I miss.

Regards

Marcel



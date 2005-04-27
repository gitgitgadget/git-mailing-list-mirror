From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: git add / update-cache --add fails.
Date: Wed, 27 Apr 2005 12:35:26 +1000
Organization: Core
Message-ID: <E1DQcOc-00054l-00@gondolin.me.apana.org.au>
References: <200504260726.04908.rhys@rhyshardwick.co.uk>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 04:31:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQcKF-0000e9-3g
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 04:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVD0Cfp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 22:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVD0Cfp
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 22:35:45 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:25353 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261893AbVD0Cfk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 22:35:40 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DQcOj-0002jQ-00; Wed, 27 Apr 2005 12:35:34 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DQcOc-00054l-00; Wed, 27 Apr 2005 12:35:26 +1000
To: rhys@rhyshardwick.co.uk
In-Reply-To: <200504260726.04908.rhys@rhyshardwick.co.uk>
X-Newsgroups: apana.lists.os.linux.git
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Rhys Hardwick <rhys@rhyshardwick.co.uk> wrote:
> 
> rhys@metatron:~/repo/learning.repo$ strace update-cache --add w1d4p1.c
...
> open("w1d4p1.c", O_RDONLY)              = -1 ENOENT (No such file or 
> directory)

The file that you're trying to add doesn't exist.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

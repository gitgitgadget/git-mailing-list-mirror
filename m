From: David Greaves <david@dgreaves.com>
Subject: Re: GIT compile error on Sun Sparc SB2000
Date: Wed, 11 May 2005 09:01:08 +0100
Message-ID: <4281BBC4.8060709@dgreaves.com>
References: <200505111141.27725.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 09:55:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVm3C-0008Qh-L8
	for gcvg-git@gmane.org; Wed, 11 May 2005 09:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVEKIBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 04:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVEKIBq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 04:01:46 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:29587 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261917AbVEKIBW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 04:01:22 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 6DCEFE6DE3; Wed, 11 May 2005 09:00:07 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15317-18; Wed, 11 May 2005 09:00:07 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.151.182])
	by mail.ukfsn.org (Postfix) with ESMTP
	id C1518E6DDF; Wed, 11 May 2005 09:00:06 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DVm9U-000281-OW; Wed, 11 May 2005 09:01:08 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Alexey Nezhdanov <snake@penza-gsm.ru>
In-Reply-To: <200505111141.27725.snake@penza-gsm.ru>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alexey Nezhdanov wrote:

>Hello. GIT refuses to compile on Debian sarge on sparc64.
>Probably some compile flag is incompartible but can't figure out which.
>  
>
read the error message:

>/usr/bin/ld: skipping 
>incompatible /usr/lib/gcc-lib/sparc-linux/3.3.3/../../../libz.so when 
>  
>
hmm...
libz.so

>/usr/bin/ld: cannot find -lz
>  
>
Can't find often equals "not installed"

So go to aptitude, search for zlib
You'll find libz-dev
Install it

Or just run
apt-get install libz-dev

And try again

David


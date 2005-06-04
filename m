From: Dave Airlie <airlied@gmail.com>
Subject: Re: [doc]playing with git, and netdev/libata-dev trees
Date: Sat, 4 Jun 2005 18:40:40 +1000
Message-ID: <21d7e99705060401405cfd5a11@mail.gmail.com>
References: <42955DF7.4000805@pobox.com>
Reply-To: Dave Airlie <airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 10:38:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeU9y-0007GG-Rf
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 10:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFDIku (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 04:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFDIkt
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 04:40:49 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:48879 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261304AbVFDIkk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 04:40:40 -0400
Received: by rproxy.gmail.com with SMTP id 1so59806rny
        for <git@vger.kernel.org>; Sat, 04 Jun 2005 01:40:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PA4nriGNJchqVZQag6hy3aY649G16aV58zA093xGy0yWA7WEGhY4YXt/HhS1uHxeg3IXrvR7+iUte89DOKAk0CybGVVwSeaZz915ezv0Pdgp08LweFhbTHNPgum3RJYj11BHiuidaiaJnzN1DT8JgjI/qBBBmPQLxvAWV/fJQNk=
Received: by 10.11.117.68 with SMTP id p68mr89452cwc;
        Sat, 04 Jun 2005 01:40:40 -0700 (PDT)
Received: by 10.11.117.46 with HTTP; Sat, 4 Jun 2005 01:40:40 -0700 (PDT)
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42955DF7.4000805@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 
> When I merge a patch for drivers/net/forcedeth.c, I merge it into a
> brand new 'forcedeth' repository, a peer to the 40+ other such
> repository.  Under BitKeeper, I made these repositories available merged
> together into one big "netdev-2.6" repository because it was too time
> consuming to make the individual 50+ trees publicly available.  With
> git, developers have direct access to the individual trees.
> 
> I thought I would write up a quick guide describing how to mess around
> with the netdev and libata-dev trees, and with git in general.
> 

Thanks for this, I'm starting to get up to speed on git now...

Two questions,

1. when you want to publish your tree what do you do? just rsync it
onto kernel.org?
2. When you are taking things from your queue for Linus do you create
another tree and merge your branches into it or what?

Dave.

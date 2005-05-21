From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: gitk-1.0 released
Date: Sat, 21 May 2005 16:40:09 +1000
Message-ID: <2cfc40320505202340e5d1aee@mail.gmail.com>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
	 <20050519132411.GA29111@elte.hu>
	 <17037.5109.556362.904185@cargo.ozlabs.ibm.com>
	 <d6l9l1$ttd$1@sea.gmane.org>
	 <Pine.LNX.4.58.0505201150220.2206@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Kari Hameenaho <khaho@kolumbus.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:39:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZNdy-0007Np-6B
	for gcvg-git@gmane.org; Sat, 21 May 2005 08:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVEUGkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 02:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVEUGkS
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 02:40:18 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:33064 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261685AbVEUGkM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 02:40:12 -0400
Received: by rproxy.gmail.com with SMTP id i8so563326rne
        for <git@vger.kernel.org>; Fri, 20 May 2005 23:40:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kG3RMCN1+8tAhC+8p00UR36keEiaiFmhJJZ4KvyG9bZyqH7tbqibdv8hajwj6KUfZYa4UzQwV9hUS3VaxOHhEq3a/r6CegJJmTTWKKnjGY6YVpQKTARMWPAK72hE1o3EvRXBpBCrwj1MXJcODB9PzeicGh7s42zbm1yJFYsvWiY=
Received: by 10.38.96.6 with SMTP id t6mr2138777rnb;
        Fri, 20 May 2005 23:40:09 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Fri, 20 May 2005 23:40:09 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505201150220.2206@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>     - mark everything reachable from OLD_HEAD as being uninteresting (aka
>       "seen"), and everything that reaches OLD_HEAD as being interesting
>       and print it out.

Won't this step end up traversing back to the root anyway?

jon.


-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/

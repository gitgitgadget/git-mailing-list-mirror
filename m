From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add support for author-oriented git-rev-list switches [rev 8]
Date: Fri, 10 Jun 2005 01:53:45 +1000
Message-ID: <2cfc4032050609085341e46242@mail.gmail.com>
References: <20050609090141.21555.qmail@blackcubes.dyndns.org>
	 <2cfc403205060902373e5c284f@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: jon.seymour@gmail.com, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:54:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgPI0-000130-9n
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 17:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVFIPxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 11:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVFIPxy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 11:53:54 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:2901 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261973AbVFIPxs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 11:53:48 -0400
Received: by rproxy.gmail.com with SMTP id i8so221930rne
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 08:53:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EJaNUaglhRQChBl+fe1kid8IKEt0JQeOAxp1mouNeW1O3geakG0AdcDwwTvArdzl63PF1lxcihB820RYBGkktajnHSWwbVpzhhuvKTWKPQXwzIpIfuEskI0Ht1aanE71YJqSJ1mQ3tcmD1H8IhWx9IZwLSARJpb/wC8Uo/FmAE4=
Received: by 10.39.2.70 with SMTP id e70mr284891rni;
        Thu, 09 Jun 2005 08:53:45 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 9 Jun 2005 08:53:45 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <2cfc403205060902373e5c284f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Since no-one had pulled the rev-7 patch to review, I have tweaked and
simplified the test cases some more. In particular, I removed the need
for /dev/urandom.

http://blackcubes.dyndns.org/epoch/wrt-patch-latest.patch

Junio: you might be interested in a new bash function I wrote in

           t/t6001-rev-list-merge-order.sh

called: test_output_expect_success

If you like, I'll generalize it and move it into testlib.sh

Linus: when you are ready, the URI above contains the latest patch.

jon.

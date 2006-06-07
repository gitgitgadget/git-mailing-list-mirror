From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH/RFC] "git --less cmd" to page anywhere
Date: Wed, 7 Jun 2006 14:29:54 +1200
Message-ID: <46a038f90606061929i68073677i686a3c1934ed64b1@mail.gmail.com>
References: <20060604211931.10117.82695.stgit@machine.or.cz>
	 <20060604212050.GV10488@pasky.or.cz>
	 <Pine.LNX.4.64.0606041621010.5498@g5.osdl.org>
	 <7vodx5n8en.fsf_-_@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0606061703380.5498@g5.osdl.org>
	 <20060607000816.GY10488@pasky.or.cz>
	 <Pine.LNX.4.64.0606061711000.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, "Junio C Hamano" <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 04:30:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnnoA-0005UJ-Br
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 04:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWFGC34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 22:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWFGC3z
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 22:29:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:27241 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750713AbWFGC3z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 22:29:55 -0400
Received: by wr-out-0506.google.com with SMTP id i20so78726wra
        for <git@vger.kernel.org>; Tue, 06 Jun 2006 19:29:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rC1ZoUpmIizEy5f3fHvj+q8BWY7dvOkem6IbjwgCvYfNFYOYfuW1/RnRpoJTIDbmGqIpv9laPC40IRCetWwozwpFrHF6MweBusFjHLcxtn1ecp+rDQahd3bWk4GM+TqBimwM5V7nKVQN3qPmkXheEwKQsluq3C+TSCDH4xq0+H8=
Received: by 10.54.140.8 with SMTP id n8mr58502wrd;
        Tue, 06 Jun 2006 19:29:21 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Tue, 6 Jun 2006 19:29:54 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606061711000.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21425>

On 6/7/06, Linus Torvalds <torvalds@osdl.org> wrote:
> For "git diff", pagination by default is definitely not the right thing to
> do, but it's something you often end up wanting.

Why is it not a good default? Unless I expect it to be shorter than
the terminal, I always tack "| less" after it. Except when I tack ">
foo.patch" and then the auto-pager knows what to do anyway.

cheers,



martin

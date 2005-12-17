From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: bad git pull
Date: Fri, 16 Dec 2005 19:37:18 -0500
Message-ID: <118833cc0512161637v1d180f9fh66a7dc6d3fe11d2b@mail.gmail.com>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
	 <7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>
	 <7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
	 <118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
	 <7vfyoshmp6.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0512161347490.3698@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Don Zickus <dzickus@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 01:38:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnQ4h-0003nq-B9
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 01:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVLQAhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 19:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVLQAhT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 19:37:19 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:53180 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964900AbVLQAhS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 19:37:18 -0500
Received: by zproxy.gmail.com with SMTP id 14so1484551nzn
        for <git@vger.kernel.org>; Fri, 16 Dec 2005 16:37:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AvGIncZAGfvkjIBTsqPs6JTV7phB4FGHQQTv2Ducbxb9RH18xDvqej4f34dsDz/HMclVp8wH8ydeKQSaQ4LT7sIDyZz1WZSzpJisNOcABuq/kA72g28uXOzITsuvrbDHSkLQ6Zy7KXaklu8fNbWyS/Lr20P0ugTXVl6or1sQLfw=
Received: by 10.36.84.20 with SMTP id h20mr3630803nzb;
        Fri, 16 Dec 2005 16:37:18 -0800 (PST)
Received: by 10.36.88.14 with HTTP; Fri, 16 Dec 2005 16:37:18 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512161347490.3698@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13764>

>  - undo the last commit entirely ("hard reset to previous state"):
>
>         git reset --hard HEAD^
>
>    This was "bk undo"
>
>  - undo the last pull ("bk unpull"): "hard reset to ORIG_HEAD":
>
>         git reset --hard ORIG_HEAD
>
>    This was "bk unpull".

It would be outright peachy if Documentation/git-commit.txt and
Documentation/git-pull.txt mentioned these.  That is certainly
where I would look first to answer the "what if I screwed up?"
question.

Morten

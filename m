From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do I track pu branch?
Date: Mon, 15 Aug 2005 19:38:32 -0700
Message-ID: <7v4q9qr4gn.fsf@assigned-by-dhcp.cox.net>
References: <46a038f9050815185629e5c4b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 04:39:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4rM0-0004B6-Be
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 04:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVHPCil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 22:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVHPCil
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 22:38:41 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9109 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964815AbVHPCik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 22:38:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816023834.LWJC17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 22:38:34 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050815185629e5c4b6@mail.gmail.com> (Martin Langhoff's
	message of "Tue, 16 Aug 2005 13:56:06 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Following an extenal repo, I am not getting all the heads. This is by
> design, AFAIK, and the question is how do I find what heads the repo
> offers and pull them in so I can call them by name?

I suspect the Subject: line and your question do not mesh well,
but anyway..

	$ git ls-remote http://www.kernel.org/pub/scm/git/git.git/
        2150cc99fe29fd81db1e9c5971e13bcb78373ebf	refs/heads/master
        ce1eb6614e4e8308585b75029ad0823389890eb9	refs/heads/pu
        14fb44880c1143ae0259842c808c036e78b516f6	refs/heads/rc
        0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
        d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
        f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
        c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
        7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
        b3e9704ecdf48869f635f0aa99ddfb513f885aff	refs/tags/v0.99.4

NOTE.  When talking to http(s) URL, the server side needs to be
prepared to support the dumb server protocol.  That is, to have
run git-update-server-info there whenever the repository is
updated.  Other transports do not have this restriction.

-jc

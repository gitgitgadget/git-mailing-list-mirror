From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Problem with cg-merge
Date: Sun, 29 May 2005 12:30:56 -0400 (EDT)
Message-ID: <3798.10.10.10.24.1117384256.squirrel@linux1>
References: <1117379092.7072.90.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@ucw.cz>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 18:28:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcQee-0000eP-UK
	for gcvg-git@gmane.org; Sun, 29 May 2005 18:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVE2QbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 12:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVE2QbD
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 12:31:03 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:22961 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261350AbVE2Qa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 12:30:58 -0400
Received: from linux1 ([70.50.38.176]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050529163056.MEMY11606.simmts5-srv.bellnexxia.net@linux1>;
          Sun, 29 May 2005 12:30:56 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4TGUtxQ027906;
	Sun, 29 May 2005 12:30:55 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 29 May 2005 12:30:56 -0400 (EDT)
In-Reply-To: <1117379092.7072.90.camel@pegasus>
To: "Marcel Holtmann" <marcel@holtmann.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 29, 2005 11:04 am, Marcel Holtmann said:
> Hi Petr,
>
> I saw that earlier, but I don't have any idea what's wrong here. If I do
> a simple cg-update, I see something like this:
>
> Tree change:
> cf1f29d97210d0594dcf5b2a734bdb714de6bf24:89a14a5bd2c880095d5c618a102319bb3dc03da9
> :100755 100755 ceda2c50fc2c2941daa34a57722df251bf892c38
> fea239b99d351502d1acb098abd725557f0af202 M      cg-diff
> :100755 100755 cc0c17beef75db41da3ad4ef8983bd7e222ac739
> 5f0bff77eb2110d52892793e5bef104acde7be32 M      cg-help
>
> Applying changes...
> Fast-forwarding cf1f29d97210d0594dcf5b2a734bdb714de6bf24 ->
> 89a14a5bd2c880095d5c618a102319bb3dc03da9
>         on top of cf1f29d97210d0594dcf5b2a734bdb714de6bf24...
> patching file cg-diff
> patching file cg-help
> cg-diff: needs update
> cg-help: needs update
>
> This is a little bit odd, because if I call "git-diff-cache HEAD" after
> it, I will see that cg-diff and cg-help are modified. After calling
> cg-cancel everything looks fine again.

Marcel,

Any chance you've installed a copy of git core in addition to your
original install of Cogito?   That looks like a problem i saw when using a
newer git installed overtop of Cogito.

Sean



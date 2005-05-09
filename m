From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: cg-log patches
Date: Sun, 8 May 2005 23:45:50 -0400 (EDT)
Message-ID: <4302.10.10.10.24.1115610350.squirrel@linux1>
References: <1742.10.10.10.24.1115573750.squirrel@linux1>
    <20050508234936.GA26624@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@ucw.cz>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 05:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUz6a-0001fj-Ko
	for gcvg-git@gmane.org; Mon, 09 May 2005 05:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbVEIDp5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 23:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVEIDp5
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 23:45:57 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:9617 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263034AbVEIDpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 23:45:50 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050509034550.CTUK1623.simmts8-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 23:45:50 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j493jnGv032050;
	Sun, 8 May 2005 23:45:50 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 23:45:50 -0400 (EDT)
In-Reply-To: <20050508234936.GA26624@diku.dk>
To: "Jonas Fonseca" <fonseca@diku.dk>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 8, 2005 7:49 pm, Jonas Fonseca said:


Hey Jonas,

>>     Fix cg-log -f option so that a complete list of files is
>>     displayed when a commit has more than one parent.
>
> This sounds great.

You might want to rip it out and submit it, because it's not likely to see
the light of day otherwise.

> The reason I put it at the top was to make it more similar to GNU-style
> changelogs (if there is such a style).

Yeah, I felt a bit guilty sliding that shift in, really I had no rationale
other than it looked better _to me_.

> I think that will make `-f' less usable because of the extra scrolling.
>
> Assuming use of wc will not create more dependency nightmares and the
> extra overhead is acceptable here is a patch that will wrap file listing
> lines near the 80th column.

Your patch will work fine but I did test my version out against the kernel
repo and it didn't seem to be a problem.

Cheers,
Sean



From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [RFC] adding merge-node to parent lines in a commit
Date: Sun, 15 May 2005 18:47:43 -0400 (EDT)
Message-ID: <1522.10.10.10.24.1116197263.squirrel@linux1>
References: <1282.10.10.10.24.1116192147.squirrel@linux1>
    <7vfywoqira.fsf@assigned-by-dhcp.cox.net>
    <1441.10.10.10.24.1116194876.squirrel@linux1>
    <7v64xkqfqg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:47:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXRtT-0001jg-Gp
	for gcvg-git@gmane.org; Mon, 16 May 2005 00:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVEOWrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 18:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVEOWrq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 18:47:46 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:17282 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261324AbVEOWro (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 18:47:44 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050515224743.DUEE19200.simmts12-srv.bellnexxia.net@linux1>;
          Sun, 15 May 2005 18:47:43 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4FMlhH3009404;
	Sun, 15 May 2005 18:47:43 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 15 May 2005 18:47:43 -0400 (EDT)
In-Reply-To: <7v64xkqfqg.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2005 6:36 pm, Junio C Hamano said:
>>>>>> "S" == Sean  <seanlkml@sympatico.ca> writes:
>
> S> Yes, it's pretty basic unless i'm overlooking something:
>
>     Rn---\
>          Mn
>          Mn-1
>     Rn-1  |
>     Rn-2  |
>     Rn-3--/
>     Initial
>
> S> So for this particular case it's rather simple, the Rn merge
> S> node would have:
>
> S> parent  Rn-1  (ommitted)
> S> parent  Mn    Rn-3
>
> Isn't that something you can obtain by scanning the parents and
> running merge-base across them without recording it in the
> commit?

Yes it is, and i was mistaken to think it gave more information.  It would
shave some time off history traversal, but nothing else.

Sean



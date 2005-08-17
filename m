From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: gitk with hyperspace support
Date: Wed, 17 Aug 2005 04:13:20 -0400 (EDT)
Message-ID: <60088.10.10.10.28.1124266400.squirrel@linux1>
References: <17154.33520.584666.701545@cargo.ozlabs.ibm.com>
    <7vr7ct124c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Paul Mackerras" <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 10:13:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5J3B-0003zJ-Ja
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 10:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVHQIN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 04:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVHQIN0
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 04:13:26 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:35549 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750976AbVHQINZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 04:13:25 -0400
Received: from linux1 ([69.156.136.246]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050817081320.UYBV23474.simmts7-srv.bellnexxia.net@linux1>;
          Wed, 17 Aug 2005 04:13:20 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j7H8DHob001352;
	Wed, 17 Aug 2005 04:13:18 -0400
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 17 Aug 2005 04:13:20 -0400 (EDT)
In-Reply-To: <7vr7ct124c.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, August 17, 2005 2:58 am, Junio C Hamano said:
> Paul Mackerras <paulus@samba.org> writes:
>
>> My reasoning is that it is the local short-range connections which are
>> interesting and informative.  The long-range connections aren't really
>> visually informative; if you want to know about the long-range
>> connections, the parent and child lists in the details pane are much
>> more useful.
>
> Correct.
>
> The new output looks a lot less cluttering and I like it very
> much, but it is confusing to me on one count.  I clicked one
> arrowhead pointing downward, expecting that the pane would jump
> scroll to show the counterpart arrowhead, and was dissapointed
> that it did not happen.  I could click the "Parent" link at that
> point, but then the upward arrow was above and outside the
> visible portion of that pane, which broke visual continuity and
> I lost track at that point.  I think my being color challenged
> exacerbated the resulting confusion; otherwise I could have
> probably found the line with the same color as the color of the
> downarrow I clicked.

This change looks really good in gitk and clicking on an arrowhead to hop
to the corresponding arrowhead would sure be great too.  There's may be a
way to further reduce the line clutter too; once a line is terminated with
an arrowhead, it could often be trimmed back much further.

For instance looking at Linus' tree:

  03938c3f1062b0f279a0ef937a471d4db83702ed
  powernow-k8 requires that a data structure for

The line flowing from this commit extends ~200 more commits downward
before it is finally terminated with an arrowhead.   It would be nice if
this line could be made shorter, such that the arrowhead was drawn much
closer to commit in question.

Cheers,
Sean

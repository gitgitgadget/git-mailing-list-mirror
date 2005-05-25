From: Russ Allbery <rra@stanford.edu>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Tue, 24 May 2005 19:16:20 -0700
Organization: The Eyrie
Message-ID: <87u0kscaob.fsf@windlord.stanford.edu>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org>
	<7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org>
	<7v3bscqdlr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 25 04:15:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DalQ1-0004EK-Jd
	for gcvg-git@gmane.org; Wed, 25 May 2005 04:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVEYCQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 22:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVEYCQZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 22:16:25 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:19425 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262236AbVEYCQW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 22:16:22 -0400
Received: from windlord.stanford.edu (windlord.Stanford.EDU [171.64.19.147])
	by smtp3.Stanford.EDU (8.12.11/8.12.11) with SMTP id j4P2GKsG030769
	for <git@vger.kernel.org>; Tue, 24 May 2005 19:16:21 -0700
Received: (qmail 16291 invoked by uid 1000); 25 May 2005 02:16:20 -0000
To: git@vger.kernel.org
In-Reply-To: <7v3bscqdlr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 24 May 2005 18:49:20 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Yes, I was trained by Paul Eggert (me says that proudly).

> Practically speaking, the only time I deliberately used > and >=
> was when I was doing some dialect of SQL that always wanted
> literal on fixed side and column on the other; I do not remember
> which was which and whose SQL anymore.

> Of course I sometimes end up using them when I am trying to
> match the style of existing code.  However, for that particular
> comparison in diff-cache, there weren't any other around there
> to match, other than the "if (argc < 2 || ...)" after the loop,
> which was what I myself wrote so it does not count.

My prior programming experience has taught me to read argv > 1 as an
assertion about argv, as opposed to 1 < argv, which would be an assertion
about 1.  In other words, as I code, I'm generally thinking about testing
a variable against some sort of boundary condition (which may or may not
be itself variable), and the thing that I'm testing goes first, followed
by the test.  As a result, 1 < argv throws me for a moment, since on first
read it seems to imply the programmer was expecting the value of 1 to
change.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>

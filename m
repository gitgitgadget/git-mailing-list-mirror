From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Alphabetize the glossary.
Date: Fri, 05 May 2006 12:02:15 -0700
Message-ID: <7vu084xpl4.fsf@assigned-by-dhcp.cox.net>
References: <E1FbVFi-0004Tt-Aw@jdl.com>
	<Pine.LNX.4.63.0605041238240.26488@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 21:02:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc5ZF-0000LH-30
	for gcvg-git@gmane.org; Fri, 05 May 2006 21:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWEETCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 15:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWEETCR
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 15:02:17 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:15234 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751525AbWEETCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 15:02:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505190216.WPAG21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 May 2006 15:02:16 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605041238240.26488@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 4 May 2006 12:41:19 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The idea of having it not alphabetized, but doing it by a script, was to 
> let people actually _read_ it. There is nothing more annoying than having 
> to jump forward and backward and eventually be lost.
>
> glossary, as I started it, was topologically ordered: no Git term was used 
> before it was described (at least that was the plan).

I myself rarely read either man nor html formatted ones.  When I
need to find something, I go straight to Documentation/
directory looking for *.txt files.  Being able to find things
from an alphabetized list is very handy.

On the other hand, we would want to make it easy for people to
read it in the logical order.  For that purpose, html formatted
version, thanks to the cross references the script creates, is a
lot easier than the plain text version.

Maybe we should do both.  We _could_ teach the sort script to
also do an topological sort, and have two sections in the
resulting formatted documentation, the top part being
"alphabetical", and the second part being "bedtime reading".

A random sort that is merely topologically correct probably is
not what we want, so it might make sense to have a hint that
instructs "these should come first before those although they
are topologically independent" to the sort script.  Of course
that "hint" could be the order entries appear in the source text
(which was what you had originally), but when somebody wants to
add a new entry to the glossary, it makes unambiguous where the
new entry should go if the source text is already sorted, which
I am hoping would make it somewhat easier to maintain.

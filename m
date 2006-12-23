From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git reflog show
Date: Sat, 23 Dec 2006 02:42:54 -0800
Message-ID: <7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
References: <20061223101956.GD9396@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 11:43:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy4LD-00044M-D8
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 11:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbWLWKm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 05:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbWLWKm4
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 05:42:56 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:51667 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbWLWKmz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 05:42:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061223104255.CMWD3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Dec 2006 05:42:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2AiC1W0021kojtg0000000; Sat, 23 Dec 2006 05:42:12 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061223101956.GD9396@spearce.org> (Shawn Pearce's message of
	"Sat, 23 Dec 2006 05:19:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35312>

Shawn Pearce <spearce@spearce.org> writes:

> I'm toying with what a 'git reflog show' might look like.  I attached
> the prototype code below.  Here's the output from the recent part of
> my mmap pack window topic:
>
>   $ ./git-reflog show refs/heads/sp/mapwin
>   ...clipped for space...
>   

The output should look almost the same as "git log" for the part
that represents a series of normal branch activity where commits
are built up one-by-one.  I think it would be useful if you can
somehow make parts that are _not_ linear stand out and perhaps
allow omitting a stretch of ordinary single strand of pearls.

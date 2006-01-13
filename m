From: Junio C Hamano <junkio@cox.net>
Subject: Re: merging initial part of a branch?
Date: Thu, 12 Jan 2006 20:00:06 -0800
Message-ID: <7v8xtkhj5l.fsf@assigned-by-dhcp.cox.net>
References: <20060111230451.GH8618@fieldses.org>
	<7vek3epbs9.fsf@assigned-by-dhcp.cox.net>
	<20060112005531.GB14599@fieldses.org>
	<7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net>
	<20060113030837.GD27214@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 13 05:00:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExG7D-0001VK-Au
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 05:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161314AbWAMEAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 23:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbWAMEAM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 23:00:12 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:38368 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161315AbWAMEAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 23:00:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113035740.UERH17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 22:57:40 -0500
To: git@vger.kernel.org
In-Reply-To: <20060113030837.GD27214@fieldses.org> (J. Bruce Fields's message
	of "Thu, 12 Jan 2006 22:08:37 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14607>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> That's the only reference I can find to the "tag <tag>" notation, and
> it's a bit unhelpful as written.  (What backward compatibility?)
>
> How about the following?--b.

Makes sense.  Thanks.

Backward compatibility is that it was only either "<branch>" or
"tag <tag>".  When heads/branch or tags/tag came later,
supporting the separate word form "tag <tag>" was a bit
cumbersome but was done for b/c.

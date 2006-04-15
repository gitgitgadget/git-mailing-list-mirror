From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 17:38:02 -0700
Message-ID: <7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141637230.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 02:38:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUYnh-0005qC-RE
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 02:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWDOAiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 20:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWDOAiG
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 20:38:06 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:10885 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751450AbWDOAiF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 20:38:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415003804.MTSO2467.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 20:38:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604141637230.3701@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 14 Apr 2006 16:52:13 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18714>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 14 Apr 2006, Junio C Hamano wrote:
>> 
>> * Message-ID: <Pine.LNX.4.64.0604121828370.14565@g5.osdl.org>
>>   Common option parsing (Linus Torvalds)
>
> Ok, here's a first cut at starting this.

Hmph.  You did it while I was still thinking about it ;-).

I was thinking long because I had an impression that anything
based on revision.c interface, if it wants to do a tree-diff on
the commit stream, would need two different diff options.  One
is used by revision.c internally so that it can use its own
add_remove/change for parent pruning, and another to control the
way diff is run by the user of revision.c.

I'll take a look at it tonight.  Thanks.

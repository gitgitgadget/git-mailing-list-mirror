From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-files -o no recurse?
Date: Fri, 06 Jan 2006 14:38:17 -0800
Message-ID: <7vk6ddq8x2.fsf@assigned-by-dhcp.cox.net>
References: <1136400692.5919.11.camel@localhost.localdomain>
	<Pine.LNX.4.64.0601041330550.3668@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Darrin Thompson <darrint@progeny.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 23:39:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0EW-0007m3-EQ
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWAFWiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWAFWiU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:38:20 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:60098 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964870AbWAFWiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:38:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223558.HYMF17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:35:58 -0500
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14223>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 4 Jan 2006, Darrin Thompson wrote:
>> 
>> Would it be hard to make git-ls-files optionally do this?
>
> Something like the appended may or may not be what you're looking for..
>
> 		Linus

Not to mention test scripts, I suspect that making this the
default would break existing callers including the famous
"git-init-db && git-add ." pattern.  The other commonplace use
is git-status, which might benefit from this option.  If we are
going to use it in git-status, we may want to give them trailing
slashes to make them stand out, though.

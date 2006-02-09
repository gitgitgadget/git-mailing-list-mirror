From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb using "--cc"?
Date: Thu, 09 Feb 2006 12:52:13 -0800
Message-ID: <7v4q389rwi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<43EAA560.8030504@didntduck.org>
	<Pine.LNX.4.64.0602081817040.2458@g5.osdl.org>
	<7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	<7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091235210.2458@g5.osdl.org>
	<7v8xsk9s3v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 21:52:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Im4-0002P4-HP
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 21:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWBIUwP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 15:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWBIUwP
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 15:52:15 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:51954 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750758AbWBIUwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 15:52:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209205218.DKHS25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 15:52:18 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v8xsk9s3v.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 09 Feb 2006 12:47:48 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15828>

Junio C Hamano <junkio@cox.net> writes:

> So obviously it would show the final paths and would not talk
> about which different path from each parent contributed to the
> result, but otherwise it should not be broken too much.  At
> least that was the way I intended..

Sorry, I am wrong again.  That was the way how I planned to, but
I think I forgot to pass the diff-options from the caller to
diff_tree_combined_merge(), so it does not do renames/copies.

Shouldn't be too hard to change it though...

From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Thu, 09 Feb 2006 15:40:22 -0800
Message-ID: <7vmzh06qzd.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0602081643570.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602081719250.2458@g5.osdl.org>
	<87d5hwxhb5.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 00:40:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7LOo-0007du-7w
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 00:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWBIXk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 18:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWBIXk0
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 18:40:26 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:19192 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750829AbWBIXkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 18:40:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209233747.WLFN26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 18:37:47 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87d5hwxhb5.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	09 Feb 2006 15:07:10 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15839>

Carl Worth <cworth@cworth.org> writes:

> I still think the three above operations are the most commonly needed,
> but I don't yet have good suggestions for names for them.

By "three" do you mean these three?

	HEAD -> index
        HEAD -> files
        index -> files

The reason I am asking is because you already have them.

> I think I'll be back with some new proposals after considering your
> suggestion to expand git status.

I agree with Linus that "git status -v" with commit options to
give a commit preview is a very good change.  That is one thing
I pointed out lacking from the current set of the tools in one
of the earlier message.  I am not sure if you read what I wrote
in that message, but one approach I suggested for this thread to
take is to come up with a list of "useful comparisons" that the
current set of tools, especially "git diff" wrapper, does not
give you.

The three you listed above are not.  They are useful, the
low-level natively support them, and "git diff" wrapper gives
easy shortcut for them.  And one known "useful but not supported
one" will be tackled soon with "git status -v" change.  Are
there other useful comparisons you wish you had that we do not
currently give you easily?

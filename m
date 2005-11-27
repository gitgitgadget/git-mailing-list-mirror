From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Reference technical/trivial-merge.txt in git-read-tree documentation
Date: Sun, 27 Nov 2005 13:16:07 -0800
Message-ID: <7v1x11dc6g.fsf@assigned-by-dhcp.cox.net>
References: <20051111205140.5719.68724.stgit@machine.or.cz>
	<20051127124108.GB22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 22:17:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgTsb-0003wW-Ca
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 22:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVK0VQK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 16:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVK0VQK
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 16:16:10 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53422 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751098AbVK0VQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 16:16:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051127211451.VTPQ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 16:14:51 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051127124108.GB22159@pasky.or.cz> (Petr Baudis's message of
	"Sun, 27 Nov 2005 13:41:08 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12827>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Fri, Nov 11, 2005 at 09:51:40PM CET, I got a letter
> where Petr Baudis <pasky@suse.cz> said that...
>> That file, with the so valuable (and so confusing) tables describing
>> the precise resolution rules git-read-tree follows, silently sat in
>> the corner and almost noone knew about it (well, I didn't, at least).
>> This references it from the git-read-tree documentation, so that there
>> is some chance that interested people will find it.
>> 
>> Signed-off-by: Petr Baudis <pasky@suse.cz>
>
> Any gripes, or just forgotten?

What happened was that I thought I'd apply after rewording the
sarcasm and maybe moving the existing table to the one in
technical/ (or just removing the old table), and forgot about it.

One thing I do not like the table in technical/ is that it is
harder to read as the "case table" than the original.
Admittedly, it is meant to describe more complex situation, so
it _is_ harder to understand, but a major difference is that the
original table was designed to decribe things orthogonally and
you did not have to read from top to bottom (any situation would
have fallen in one case no matter what order you checked the
condition for each case), while the updated table in technical/
_must_ be read from top to bottom and take the first match, and
that was what made me feel reluctant to remove the existing one
from the original document.

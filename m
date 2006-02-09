From: Tony Luck <tony.luck@intel.com>
Subject: Re: What's in git.git
Date: Thu, 9 Feb 2006 15:14:59 -0800
Message-ID: <12c511ca0602091514p35c3904bha8d5d406e5472969@mail.gmail.com>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 00:15:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7L0G-0001tU-EO
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 00:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWBIXPC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 18:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWBIXPB
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 18:15:01 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:16702 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750823AbWBIXPB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 18:15:01 -0500
Received: by zproxy.gmail.com with SMTP id o1so308959nzf
        for <git@vger.kernel.org>; Thu, 09 Feb 2006 15:15:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TPeNf3Fo/DyJVhTlJ6WMGQUeLSbbhYYYNG97QG52OCcUdQBr9jRzTjjxoNX2of4TDFY/9vNnUdwy06UiQxD3XNSZVTQb9d6x25wHPbhg9yvr0pwlQ+9MRXrWOOQWsi5y6khqmaagfV7xjNVBqkCTL9s8vr3nq9s7nRlFj81KU38=
Received: by 10.65.110.19 with SMTP id n19mr235509qbm;
        Thu, 09 Feb 2006 15:14:59 -0800 (PST)
Received: by 10.64.27.15 with HTTP; Thu, 9 Feb 2006 15:14:59 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15837>

On 2/8/06, Junio C Hamano <junkio@cox.net> wrote:
>  * If there are patches sent to improve a topic branch in it,
>    they will be applied to the topic branch, and then the topic
>    branch is merged into "next", without any funny rewinding or
>    rebasing of "next".  This will make the "next" branch
>    cluttered with repeated merges from the same topic branch,
>    but that is OK.  "next" will not be merged into "master",
>    ever.
>
>  * Once a topic is fully cooked, the topic branch will be merged
>    into "master".

This is pretty much the workflow in my test/release branches (mostly
documented in Documentation/howto/using-topic-branches.txt).

I've sometimes wondered about re-creating the topic branches in
the case where there have been a series of follow-on commits
before pulling them into the release branch.  The goal would be
to present history not as it was, but as it should have been if we
didn't have all the dumb mistakes and typos.

So is there an easy way in git to take the series of commits
from a topic branch, make a new branch with all those commits
as just one commit ... with an open editor on the concatenated
commit comments (If there were just typo fixes the comment
from the first commit would apply, but sometimes the follow-on
commits would have substantive changes).

-Tony

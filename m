From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (part #2)
Date: Mon, 05 Jun 2006 23:16:50 -0700
Message-ID: <7vhd2yzu3x.fsf@assigned-by-dhcp.cox.net>
References: <7v64jli66m.fsf@assigned-by-dhcp.cox.net>
	<20060602023545.GA5039@spearce.org>
	<7v3beodpqs.fsf@assigned-by-dhcp.cox.net>
	<20060606053905.GA9797@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 08:16:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnUs5-0008Ca-5L
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 08:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWFFGQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 02:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWFFGQw
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 02:16:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:36233 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750820AbWFFGQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 02:16:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606061651.ICZR11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 02:16:51 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060606053905.GA9797@spearce.org> (Shawn Pearce's message of
	"Tue, 6 Jun 2006 01:39:05 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21365>

Shawn Pearce <spearce@spearce.org> writes:

>> I find it interesting to be able to say:
>> 
>> 	$ git log next@{yesterday}..next
>> 
>> I often find myself getting curious to see:
>> 
>> 	$ git reflog next
>>         Wed May 31 14:23:58 2006 -0700
>>                 62b693a... Merge branch 'master' into next
>>         ...
>
> Hmm, looks like nobody has actually implemented that - at least not
> in 'next'.  :-)
>
> Is that a serious feature request?

I've written it but it was so trivial I threw it away after
writing the e-mail you are responding to with it.

As I said, I _think_ I was interested in seeing it primarily
because reflog was a new curiosity to me.  It is more like
wanting to know how the new tool works more than using the new
tool effectively to improve my productivity.  In a "serious"
environment, a tool is just something you would use to get the
real job done, not to toy around to see how _it_ works, so I
suspect the above would not be so useful in practice, as I wrote
in the message.

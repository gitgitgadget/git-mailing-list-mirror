From: Chris Mason <mason@suse.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 10:36:50 -0500
Message-ID: <20051101153650.GB26847@watt.suse.com>
References: <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com> <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com> <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz> <b0943d9e0511010123i1f9eb679w@mail.gmail.com> <436787BD.9080705@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 16:37:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWyC3-00068s-1f
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 16:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVKAPg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 10:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVKAPg4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 10:36:56 -0500
Received: from ns.suse.de ([195.135.220.2]:28397 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750897AbVKAPgy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 10:36:54 -0500
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id BF9A6E339;
	Tue,  1 Nov 2005 16:36:53 +0100 (CET)
To: Chuck Lever <cel@citi.umich.edu>
Content-Disposition: inline
In-Reply-To: <436787BD.9080705@citi.umich.edu>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10935>

On Tue, Nov 01, 2005 at 10:20:29AM -0500, Chuck Lever wrote:
[ ... ]
> would show pretty-printed commit information for change 45.
> 
>    stg revisions --revert=45
> 
> would revert the patch back to the way it was in change 45.  notably, 
> you don't throw away changes 46 through 90 when you do this.  a new 
> change is added which changes the state of the patch to the way it was 
> in change 45.  (well, that's how it's supposed to work, anyway).
> 
> i'm interested to hear what folks on the list think of the idea.

I'm probably not familiar enough with stgit, but it
looks to me as though you're tracking individual patch history only.

In trees I work with, patches rarely stand alone.  There are typically
collections of patches implementing a given feature, or a change to one
patch requires rebasing a number of (perhaps unrelated) others.

I think the command set you describe above will lose that grouping.

-chris

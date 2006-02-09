From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: gitweb using "--cc"?
Date: Wed, 08 Feb 2006 21:13:52 -0500
Message-ID: <43EAA560.8030504@didntduck.org>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@suse.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 03:12:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F71IN-0001Bx-LB
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 03:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422772AbWBICMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 21:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbWBICMI
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 21:12:08 -0500
Received: from quark.didntduck.org ([69.55.226.66]:30438 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1422772AbWBICMH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 21:12:07 -0500
Received: from [192.168.1.2] (66-227-170-68.dhcp.aldl.mi.charter.com [66.227.170.68])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id k192Btv11201;
	Wed, 8 Feb 2006 21:11:55 -0500
User-Agent: Thunderbird 1.5 (X11/20060128)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15783>

Linus Torvalds wrote:
> I just did an arm merge that needed some (very trivial) manual fixups 
> (commit ID cce0cac1, in case anybody cares).
> 
> As usual, git-diff-tree --cc does a beautiful job on it, but I also 
> checked the gitweb output, which seems to not do as well (the commit 
> message about a manual conflict merge doesn't make any sense at all).
> 
> Now, in this case, what gitweb shows is actually "sensible": it will show 
> the diff of what the merge "brought in" to the mainline kernel, and in 
> that sense I can certainly understand it. It basically diffs the merge 
> against the first parent.
> 
> So looking at that particular example, arguably gitweb does something 
> "different" from what the commit message is talking about, but in many 
> ways it's a perfectly logical thing.
> 
> However, diffing against the first parent, while it sometimes happens to 
> be a sane thing to do, really isn't very sane in general. The merge may go 
> the other way (subdevelopers merging my code), like in commit b2faf597, 
> and sometimes there might not be a single reference tree, but more of a 
> "couple of main branches" approach with merging back and forth). Then the 
> current gitweb behaviour makes no sense at all.
> 
> So it would be much nicer if gitweb had some alternate approach to showing 
> merge diffs. My suggested approach would be to just let the user choose: 
> have separate "diff against fist/second[/third[/..]] parent" buttons. And 
> one of the choices would be the "conflict view" that git-diff-tree --cc 
> gives (I'd argue for that being the default one, because it's the only one 
> that doesn't have a "preferred parent").
> 
> Kay?
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

git-whatchanged doesn't show that merge commit either.

--
				Brian Gerst

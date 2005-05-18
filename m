From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/1] Diff-helper update
Date: Wed, 18 May 2005 11:14:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org> <7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Wed May 18 20:15:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYT1d-0006iN-3B
	for gcvg-git@gmane.org; Wed, 18 May 2005 20:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVERSMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 14:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVERSMo
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 14:12:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:31177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262218AbVERSMl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 14:12:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4IICYU3029181
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 May 2005 11:12:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4IICX2j010939;
	Wed, 18 May 2005 11:12:33 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 18 May 2005, Junio C Hamano wrote:
> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> However, git-diff-helper doesn't understand these things, and the builtin
> LT> diff doesn't do the rename thing. Yet it would be very very useful to do.
> 
> It is unclear what you meant by "these things" in "doesn't
> understand these things", and what you meant by "it" in "it
> would be very very useful to do."  Could you explain?

"These things" being the extra output from "diff-tree" that is not a "diff 
line".

If diff-helper just passes the lines it doesn't understand through
unmodified (_after_ having handled any pending rename logic), it will 
automatically do the right thing.

> About the built-in diff not doing the rename , I have a bit
> longer term (knowing _my_ timescale I'd imagine you would
> understand that is not that long ;-) plan to have -p option for
> diff-* family to use the same rename detection logic that I
> added to diff-helper in the patch you are commenting on.

Goodie. I was hoping that was the case, but felt that the diff-helper 
thing should be pretty easy to do.

			Linus

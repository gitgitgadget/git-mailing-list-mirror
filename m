X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 19:48:15 -0800
Message-ID: <7v4psmzx4w.fsf@assigned-by-dhcp.cox.net>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
	<ekafpm$fs7$1@sea.gmane.org> <7vvel3yuzz.fsf@assigned-by-dhcp.cox.net>
	<20061126031421.GC29394@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 03:48:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061126031421.GC29394@spearce.org> (Shawn Pearce's message of
	"Sat, 25 Nov 2006 22:14:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32323>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoB0L-0002Dd-8R for gcvg-git@gmane.org; Sun, 26 Nov
 2006 04:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967285AbWKZDsR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 22:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967286AbWKZDsR
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 22:48:17 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:5080 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S967285AbWKZDsQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 22:48:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126034816.QWGP20330.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Sat, 25
 Nov 2006 22:48:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rFnk1V00a1kojtg0000000; Sat, 25 Nov 2006
 22:47:45 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> We moved away from the $GIT_DIR/branches directory to
> $GIT_DIR/remotes, yet we still support $GIT_DIR/branches in
> remote handling code.

IIRC, git never used "branches", so there was no "moving away".
It was merely to interpret what cg-init left in the repository.
Since the very early days remotes/ has been _the_ format git
used, and I do not see any strong reason to change it now.  The
continued support for branches is an irrelevant topic and is not
a justification to favor configuration over remotes/ nor the
other way around.

> For one thing the newer remote.<name>.fetch seems to make more sense
> to new users than Pull: lines do.

That is quite subjective.

> ..., so there is probably low risk of
> breakage ...

Again, "low risk of breakage" does not justify switching.

As I said in the other message, I think configuration vs remotes/
is futile subject and premature topic to talk about before
nailing down what semantics we would want.  Either format can
have the expressive power, once we know what we want to express.


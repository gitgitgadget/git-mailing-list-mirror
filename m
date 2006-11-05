X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: bash completion in backticks partially broken
Date: Sun, 05 Nov 2006 01:48:03 -0800
Message-ID: <7vpsc2teb0.fsf@assigned-by-dhcp.cox.net>
References: <20061105090540.GA4843@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 09:48:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061105090540.GA4843@spearce.org> (Shawn Pearce's message of
	"Sun, 5 Nov 2006 04:05:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30962>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggebw-0005Eg-BL for gcvg-git@gmane.org; Sun, 05 Nov
 2006 10:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932611AbWKEJsH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 04:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWKEJsH
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 04:48:07 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:18927 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S932611AbWKEJsE
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 04:48:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061105094803.AZW6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sun, 5
 Nov 2006 04:48:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ixo81V00H1kojtg0000000 Sun, 05 Nov 2006
 04:48:08 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> This is really annoying when it comes to less contrived examples.
> I find myself forming odd pipelines with commit-tree, update-ref,
> mktree, lstree, sed, rev-list, etc. and always keep bumping up on
> the limitations of git-completion.bash.
>
> Any suggestions?

I am more interested in why you would even need to use
combinations of such low-level commands in day-to-day workflow.

If they are often-needed patterns, you would have scripted them
already, so completion would not be an issue for you.  So I am
assuming these are ad-hoc one-shot needs.

While it is satisfying to know that things you would want to do
can be scripted even for one-shot use (which is how git is
designed to, and it shows that the design goal has been
achieved), maybe it's a sign that we are giving you too much
flexibility?  Under less capable/flexible system that puts you
in a straightjacket, you would not even be tempted to do oddball
things to begin with...



X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] merge-recursive: make empty tree a known object
Date: Sun, 10 Dec 2006 13:21:05 -0800
Message-ID: <7vpsar4fcu.fsf@assigned-by-dhcp.cox.net>
References: <20061207101707.GA19139@spearce.org>
	<Pine.LNX.4.63.0612100055390.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0612101030390.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 21:21:28 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612101030390.12500@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 10 Dec 2006 10:37:57 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33929>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtW6j-0003zk-Kk for gcvg-git@gmane.org; Sun, 10 Dec
 2006 22:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762594AbWLJVVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 16:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762616AbWLJVVJ
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 16:21:09 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58009 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1762594AbWLJVVG (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 16:21:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210212106.BZBQ25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Sun, 10
 Dec 2006 16:21:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id x9LU1V0061kojtg0000000; Sun, 10 Dec 2006
 16:20:29 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> So you could make "read_sha1_file()" just have a special case for known 
> objects at the end. If the pack entry fails, the loose file case fails, 
> then rather than returning NULL at the end, you could have a list of known 
> fixed objects..

That is fine by me.  We would benefit from an empty blob and an
empty tree.

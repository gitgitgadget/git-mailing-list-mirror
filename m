X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: branch builtin
Date: Wed, 01 Nov 2006 12:50:09 -0800
Message-ID: <7v7iye51tq.fsf@assigned-by-dhcp.cox.net>
References: <454900F5.5050603@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 20:50:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <454900F5.5050603@shadowen.org> (Andy Whitcroft's message of
	"Wed, 01 Nov 2006 20:17:57 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30656>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfN2P-00070g-2X for gcvg-git@gmane.org; Wed, 01 Nov
 2006 21:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752342AbWKAUuM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 15:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbWKAUuM
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 15:50:12 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15775 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1752342AbWKAUuL
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 15:50:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101205010.FQID16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 15:50:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hYqE1V00Z1kojtg0000000 Wed, 01 Nov 2006
 15:50:15 -0500
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> writes:

> Since the branch command moved built-in it no longer works in
> sub-directories.  I've futzed with it and it seems adding RUN_SETUP to
> the command table for branch makes 'git branch' work.  Is this safe to do?

"git branch" is usable only within a git repository, so
RUN_SETUP should be the sane thing to do.  Thanks for noticing.

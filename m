From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Thu, 9 May 2013 01:05:12 +0000
Message-ID: <20130509010512.GA25945@dcvr.yhbt.net>
References: <1438528085.20130501090926@gmail.com>
 <1409591910.20130501123153@gmail.com>
 <7vhaim8w48.fsf@alter.siamese.dyndns.org>
 <455264907.20130501235104@gmail.com>
 <20130501213031.GA13056@dcvr.yhbt.net>
 <7v1u9q5pu5.fsf@alter.siamese.dyndns.org>
 <20130502024926.GA12172@dcvr.yhbt.net>
 <12810110770.20130502213124@gmail.com>
 <366899002.20130506125846@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 03:05:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFIR-0005Ad-L1
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317Ab3EIBFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:05:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50120 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab3EIBFP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:05:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4271F6BF;
	Thu,  9 May 2013 01:05:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <366899002.20130506125846@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223693>

Ilya Basin <basinilya@gmail.com> wrote:
> Hi Eric. I'm out of spare time and I still unable to import my repo.
> The code of SVN.pm is too complex. Please help me.

Sorry, most what I do nowadays for git-svn is ACK/NACK changes.

git-svn has made itself obsolete for most contributors, myself included;
so it's hard for us to devote significant amounts of time on it since
we no longer see SVN repos in our day-to-day work.

Given the differences between branching/tagging in SVN and git, I
suspect some history may always be too complex/convoluted to
automatically import.  Perhaps an interactive mode can be introduced
to follow history...

Anyways, thank you for documenting these issues and suggesting fixes.
Hopefully somebody with sufficient motivation can continue your work
down the line.

From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git svn: reset invalidates the memoized mergeinfo
 caches
Date: Fri, 10 Aug 2012 14:30:28 -0700
Message-ID: <20120810213028.GA8660@dcvr.yhbt.net>
References: <20120807200207.GA10899@m62s10.vlinux.de>
 <20120807204510.GA10453@dcvr.yhbt.net>
 <20120808054129.GB10899@m62s10.vlinux.de>
 <20120808225258.GA24956@dcvr.yhbt.net>
 <20120809064253.GC10899@m62s10.vlinux.de>
 <20120810202211.GA16606@dcvr.yhbt.net>
 <7vmx22iggu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Myrick <amyrick@apple.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:30:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szwmw-0004yD-O5
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757647Ab2HJVa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 17:30:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54066 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab2HJVa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:30:29 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019531F42C;
	Fri, 10 Aug 2012 21:30:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vmx22iggu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203265>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > Peter Baumann (1):
> >       git svn: reset invalidates the memoized mergeinfo caches
> >
> > Robert Luberda (1):
> >       git svn: handle errors and concurrent commits in dcommit
> 
> OK, so these two are fit for 1.7.12-rc3 and later?

Yes.

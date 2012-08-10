From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git svn: handle errors and concurrent commits in
 dcommit
Date: Fri, 10 Aug 2012 19:51:33 +0000
Message-ID: <20120810195133.GA16423@dcvr.yhbt.net>
References: <1343856397-6536-1-git-send-email-robert@debian.org>
 <20120802104421.GA13271@dcvr.yhbt.net>
 <5021F9D4.1010700@debian.org>
 <20120808230754.GB24956@dcvr.yhbt.net>
 <7v1ujgot8h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Luberda <robert@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:51:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzvFE-0002fM-VF
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 21:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab2HJTvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 15:51:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52576 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab2HJTve (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 15:51:34 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDE01F42C;
	Fri, 10 Aug 2012 19:51:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v1ujgot8h.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203253>

Junio C Hamano <gitster@pobox.com> wrote:
> I should have asked this yesterday, but do you mean you want to have
> your "maint" in the upcoming 1.7.12?  This does look like a useful
> thing to do, but does not seem like a regression fix to me.

Yeah, I wasn't sure what to name it since my master is still carrying
Michael's larger SVN 1.7 changes.   Perhaps I should've named my "maint"
"for-git-master" in this case...

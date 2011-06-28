From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/3] git-svn: Handle git root commits in mergeinfo
 ranges
Date: Tue, 28 Jun 2011 03:37:32 +0000
Message-ID: <20110628033732.GA14132@dcvr.yhbt.net>
References: <1308379680-17188-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	bert.wesarg@googlemail.com, git@drmicha.warpmail.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 05:39:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbP9W-0001Jt-T8
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 05:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435Ab1F1DjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 23:39:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42875 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756281Ab1F1Dhd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 23:37:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CEA8296893;
	Tue, 28 Jun 2011 03:37:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1308379680-17188-1-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176380>

Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I don't believe the extra "git rev-parse" invocation to be a
> performance problem, but I am not familiar enough with the code to be
> certain.

It shouldn't be a problem.  Sam Vilain did all the merge tracking code,
but this looks entirely reasonable.

> Michael Haggerty (3):
>   git-svn: Demonstrate a bug with root commits in mergeinfo ranges
>   git-svn: Disambiguate rev-list arguments to improve error message
>   git-svn: Correctly handle root commits in mergeinfo ranges

Thanks Michael.

All acked and pushed to "master" for Junio at git://bogomips.org/git-svn
These should go to maint, too.

-- 
Eric Wong

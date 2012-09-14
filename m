From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Make git-svn branch patterns match complete URL
Date: Fri, 14 Sep 2012 21:45:08 +0000
Message-ID: <20120914214508.GA16293@dcvr.yhbt.net>
References: <1346367237-28242-1-git-send-email-ammon.riley@gmail.com>
 <7vtxv02vta.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcin Owsiany <marcin@owsiany.pl>,
	"Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	Ammon Riley <ammon.riley@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 23:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCdhR-00037G-Nm
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 23:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757063Ab2INVpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 17:45:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43466 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756511Ab2INVpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 17:45:09 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA831F50D;
	Fri, 14 Sep 2012 21:45:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vtxv02vta.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205535>

Junio C Hamano <gitster@pobox.com> wrote:
> Any comment from "git svn" stakeholders on this one?

Looks good to me.
Signed-off-by: Eric Wong <normalperson@yhbt.net>

Pushed to master of git://bogomips.org/git-svn.git
(commit 059058765ea2b0abd88001ea1f0f866daf7d0e4c)

  Ammon Riley (1):
        Make git-svn branch patterns match complete URL

  Robert Luberda (1):
        t9164: Add missing quotes in test

  Steven Walter (2):
        git-svn.perl: consider all ranges for a given merge, instead of only tip-by-tip
        git-svn.perl: keep processing all commits in parents_exclude

Will followup on some other pending patches soon...

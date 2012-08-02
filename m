From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fix git-svn for SVN 1.7
Date: Thu, 2 Aug 2012 20:51:23 +0000
Message-ID: <20120802205123.GA14391@dcvr.yhbt.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120802103122.GA24385@dcvr.yhbt.net>
 <20120802160753.GA17158@copier>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:51:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx2Mk-0002Ce-KL
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 22:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab2HBUvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 16:51:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60898 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab2HBUvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 16:51:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11BC1F42D;
	Thu,  2 Aug 2012 20:51:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120802160753.GA17158@copier>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202790>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Thanks from me as well.  I'm still worried about whether the increased
> use of canonicalize_url will introduce regressions for the existing
> SVN 1.6 support, and I should have time to look it over this weekend.
> 
> The comment in canonicalize_url "There wasn't a 1.6 way to do it" is
> not true.  The relevant thread on the git list had a little
> conversation about keeping svn 1.4 support, but I'm not sure why
> that's relevant, given that svn_canonicalize_path has worked largely
> the same way starting with SVN 1.1 (and on the other hand had
> significant changes in SVN 1.7).
> 
> Hopefully you've looked this over carefully already and I'm worrying
> needlessly.

Thanks for reminding me, I went back to an old chroot 1.4.2 indeed
does fail canonicalization.

Will bisect and squash a fix in.

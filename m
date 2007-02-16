From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [CFT] git-svn - almost a rewrite...
Date: Thu, 15 Feb 2007 18:09:35 -0800
Message-ID: <20070216020935.GA21483@localdomain>
References: <20070201132934.GB7800@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 03:11:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHsYu-00022h-Sm
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 03:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423029AbXBPCKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 21:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423030AbXBPCKN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 21:10:13 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58975 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423027AbXBPCKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 21:10:12 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2F8BD7DC091;
	Thu, 15 Feb 2007 18:10:10 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 15 Feb 2007 18:09:35 -0800
Content-Disposition: inline
In-Reply-To: <20070201132934.GB7800@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39877>

Eric Wong <normalperson@yhbt.net> wrote:
> Repository available here, this is based against Junios git.git master:
> 
>   git://git.bogomips.org/git-svn.git
>   http://git.bogomips.org/git-svn.git

> As great as these changes sound, I don't feel they bring significant
> enough improvement to risk introducing brokeness for 1.5.0.  I would
> like to wait until 1.5.0 has passed before merging into mainline.  I
> still have _not_ used this version of git-svn for any real work yet.

I've been dogfooding my current version today and it everything seems to
be working as expected.

I'm glad I didn't introduce it into 1.5.0, however; as I introduced (but
later fixed) a major bug between Saturday and Wednesday where revisions
were being skipped.

-- 
Eric Wong

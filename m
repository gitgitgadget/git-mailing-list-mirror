From: Tim Stoakes <tim@stoakes.net>
Subject: Re: [PATCH/RFC] git-svn: Allow multiple branch and tag patterns
Date: Tue, 23 Feb 2010 13:20:17 +1030
Message-ID: <20100223025017.GB4906@mail.stoakes.net>
References: <c8b3bef91002221429l3b277429l56f4e4cac4fdeb43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 03:59:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njl08-0005yx-Ry
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 03:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab0BWC7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 21:59:49 -0500
Received: from outbound-mail04.westnet.com.au ([203.10.1.245]:23143 "EHLO
	outbound-mail04.westnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753157Ab0BWC7s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2010 21:59:48 -0500
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2010 21:59:47 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAGLRgkvKrYlp/2dsb2JhbACbAXS7NYRrBA
X-IronPort-AV: E=Sophos;i="4.49,523,1262534400"; 
   d="scan'208";a="21777993"
Received: from dsl-202-173-137-105.sa.westnet.com.au (HELO mail.stoakes.net) ([202.173.137.105])
  by outbound-mail04.westnet.com.au with ESMTP/TLS/ADH-CAMELLIA256-SHA; 23 Feb 2010 10:50:21 +0800
Received: from noodle.stoakes.net (unknown [192.168.20.220])
	by mail.stoakes.net (Postfix) with ESMTP id BFC271A400C;
	Tue, 23 Feb 2010 13:20:17 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id 88F857F0BC; Tue, 23 Feb 2010 13:20:17 +1030 (CST)
Mail-Followup-To: Michael Olson <mwolson@gnu.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <c8b3bef91002221429l3b277429l56f4e4cac4fdeb43@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140764>

Michael Olson(mwolson@gnu.org)@220210-14:29:
> This change allows multiple branch and tag patterns to be specified in
> .git/config for git-svn projects.  This is useful for fetching several
> different parts out of the namespace of an svn repository.
> Additionally, a new repeatable directive called "skip" has been added
> to specify a specific tag or branch to ignore.
> 
> Signed-off-by: Michael W. Olson <mwolson@gnu.org>
> ---
> I've been using this patch regularly for over a year on a very large
> svn repository.
> 
> This patch is known to work on git 1.6.3.3 specifically.  Once I get a
> few responses about whether or not it is useful, I'll rebase it
> against the git.git master branch.

Yes please!

Tim

-- 
Tim Stoakes

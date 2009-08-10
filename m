From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/1] git-svn: ignore leading blank lines in svn:ignore
Date: Mon, 10 Aug 2009 02:38:27 -0700
Message-ID: <20090810093827.GA28489@dcvr.yhbt.net>
References: <e6857eacc53d862018138bd8d9e1ab778e8f5725.1249672562.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Adam Brewster <adambrewster@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:39:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaRKv-0003rI-GM
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 11:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbZHJJi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 05:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZHJJi1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 05:38:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53025 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbZHJJi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 05:38:26 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 940191F585;
	Mon, 10 Aug 2009 09:38:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <e6857eacc53d862018138bd8d9e1ab778e8f5725.1249672562.git.mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125427>

Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Subversion ignores all blank lines in svn:ignore properties.  The old
> git-svn code ignored blank lines everywhere except for the first line
> of the svn:ignore property.  This patch makes the "git svn
> show-ignore" and "git svn create-ignore" commands ignore leading blank
> lines, too.
> 
> Also include leading blank lines in the test suite.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Thanks Michael,

Acked out and pushed out along with two of Adam's to
git://yhbt.net/git-svn:

Adam Brewster (2):
      svn: Add && to t9107-git-svn-migrate.sh
      svn: Honor --prefix option in init without --stdlayout

Michael Haggerty (1):
      git-svn: ignore leading blank lines in svn:ignore

-- 
Eric Wong

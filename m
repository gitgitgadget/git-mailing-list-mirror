From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: Re: git-svn uses uninitialized value $lc_rev at line 1141
Date: Thu, 13 May 2010 08:40:15 +0000
Message-ID: <20100513084015.GA20917@sajinet.com.pe>
References: <4BEB88ED.3080609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Mike.lifeguard" <mike.lifeguard@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 10:48:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCU5U-0003Ku-Lo
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 10:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab0EMIsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 04:48:06 -0400
Received: from sajino.sajinet.com.pe ([76.74.239.193]:45107 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab0EMIsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 04:48:04 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2010 04:48:04 EDT
Received: by sajino.sajinet.com.pe (Postfix, from userid 1000)
	id E0DA5A582BE; Thu, 13 May 2010 08:40:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4BEB88ED.3080609@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146978>

On Thu, May 13, 2010 at 02:06:53AM -0300, Mike.lifeguard wrote:
> 
> I'm using git version 1.7.1, and found a tiny bug:
> 
> mikelifeguard@arbour:~/git/perlwikibot (master)$ git svn info
> Use of uninitialized value $lc_rev in concatenation (.) or string at
> /usr/lib/git-core/git-svn line 1141.

this shouldn't happen unless you are doing git svn info in a tree
that has no metadata (or lost it somehow).

does git log show any git-svn-id tags?

Carlo

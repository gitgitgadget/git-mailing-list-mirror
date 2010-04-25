From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/5] gitweb: Miscellaneous improvements, in preparation
 for caching support
Date: Sun, 25 Apr 2010 11:20:35 +0200
Message-ID: <20100425092035.GO3563@machine.or.cz>
References: <20100424132255.30511.98829.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 11:20:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5y18-0000Sm-U2
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 11:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab0DYJUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 05:20:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53266 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab0DYJUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 05:20:39 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C1962125A0EB; Sun, 25 Apr 2010 11:20:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100424132255.30511.98829.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145733>

On Sat, Apr 24, 2010 at 03:46:25PM +0200, Jakub Narebski wrote:
> Jakub Narebski (5):
>       gitweb: Move generating page title to separate subroutine
>       gitweb: Add custom error handler using die_error
>       gitweb: Use nonlocal jump instead of 'exit' in die_error
>       gitweb: href(..., -path_info => 0|1)
>       Export more test-related variables when running external tests
> 
>  gitweb/gitweb.perl |   69 ++++++++++++++++++++++++++++++++++++++--------------
>  t/test-lib.sh      |    3 ++
>  2 files changed, 53 insertions(+), 19 deletions(-)
>  mode change 100644 => 100755 t/test-lib.sh

Except the last one, I don't think the patches bring something useful
in on their own so ordinarily they would probably have to be a part of
some series that makes use of them, but there's no harm done either.

Acked-by: Petr Baudis <pasky@suse.cz>

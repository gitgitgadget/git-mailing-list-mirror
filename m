From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] guilt(1): fix path to git-sh-setup
Date: Thu, 17 Jul 2008 12:02:17 +0200
Message-ID: <20080717100217.GT32184@machine.or.cz>
References: <20080716232339.GC22919@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Alex Chiang <achiang@hp.com>, jeffpc@josefsipek.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 12:03:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJQKU-0004Ri-9b
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 12:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbYGQKCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 06:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYGQKCT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 06:02:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37445 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbYGQKCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 06:02:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 632F22C4C025; Thu, 17 Jul 2008 12:02:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080716232339.GC22919@ldl.fc.hp.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88823>

On Wed, Jul 16, 2008 at 05:23:39PM -0600, Alex Chiang wrote:
> diff --git a/guilt b/guilt
> index 50414a4..ba4593a 100755
> --- a/guilt
> +++ b/guilt
> @@ -23,7 +23,7 @@ esac
>  # we change directories ourselves
>  SUBDIRECTORY_OK=1
>  
> -. git-sh-setup
> +. `git --exec-path`/git-sh-setup

Beware of the proverbial "/Program Files/Git" location, however.

				Petr "Pasky" Baudis

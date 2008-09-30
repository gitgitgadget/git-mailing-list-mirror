From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] Use git_editor
Date: Tue, 30 Sep 2008 15:07:44 -0400
Message-ID: <20080930190744.GO32444@josefsipek.net>
References: <48E27366.3080503@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 30 21:09:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkkae-00072m-3I
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 21:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbYI3THq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 15:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbYI3THq
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 15:07:46 -0400
Received: from josefsipek.net ([141.211.133.196]:53150 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbYI3THp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 15:07:45 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id CB89B1C00E1C; Tue, 30 Sep 2008 15:07:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48E27366.3080503@tuffmail.co.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97144>

On Tue, Sep 30, 2008 at 07:43:50PM +0100, Alan Jenkins wrote:
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> 
> diff --git a/guilt b/guilt
> index 1cef7b9..8d023e9 100755
> --- a/guilt
> +++ b/guilt
> @@ -693,10 +693,6 @@ fi
>  series="$GUILT_DIR/$branch/series"
>  applied="$GUILT_DIR/$branch/status"
>  
> -# determine an editor to use for anything interactive (fall back to vi)
> -editor="vi"
> -[ ! -z "$EDITOR" ] && editor="$EDITOR"
> -

Looks good from a quick glance. Any chance there's a git_pager?

Josef 'Jeff' Sipek.

-- 
Bad pun of the week: The formula 1 control computer suffered from a race
condition

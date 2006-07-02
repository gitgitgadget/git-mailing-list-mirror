From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.xs: older perl do not know const char *
Date: Sun, 02 Jul 2006 15:39:26 -0700
Message-ID: <7v1wt33a3l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607021152200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060702215249.GK29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 00:39:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxAbD-00010g-Es
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 00:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWGBWj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 18:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWGBWj2
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 18:39:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:37630 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750749AbWGBWj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 18:39:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702223927.WKFK6385.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 18:39:27 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060702215249.GK29115@pasky.or.cz> (Petr Baudis's message of
	"Sun, 2 Jul 2006 23:52:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23131>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sun, Jul 02, 2006 at 11:53:03AM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
>> Both of these casts _should_ be safe, since you do not want to muck around 
>> with the version or the path anyway.
>> 
>> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> Acked-by: Petr Baudis <pasky@suse.cz>
>
> It isn't all that great but it seems everything xs does with this is to
> feed it to sv_setpv() which AFAIK copies it around.

Thanks.  Already applied but not pushed out yet (I am working on
tracking down unrelated breakage in tests).

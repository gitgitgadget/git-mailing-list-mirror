From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: if mtime (or size) of the config file changed since last read, reread it
Date: Sun, 07 May 2006 01:42:10 -0700
Message-ID: <7v8xpep6ot.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605070125010.6597@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0605070144530.7578@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060507073052.GC17031@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 10:42:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FceqJ-0002zI-St
	for gcvg-git@gmane.org; Sun, 07 May 2006 10:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWEGImM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 04:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWEGImM
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 04:42:12 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63117 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932105AbWEGImM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 04:42:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060507084211.OVXJ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 04:42:11 -0400
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060507073052.GC17031@lug-owl.de> (Jan-Benedict Glaw's message
	of "Sun, 7 May 2006 09:30:52 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19696>

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

>> +	if (in_fd < 0 && ENOENT != errno )
>
> I admit that I don't like the (constant -operator- variable) notation,
> but mixing both in one line..?

Lol.

I would have written it as (in_fd < 0 && errno != ENOENT) BTW.

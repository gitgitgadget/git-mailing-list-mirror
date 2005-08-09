From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Mon, 08 Aug 2005 19:48:39 -0700
Message-ID: <7vpssnyge0.fsf@assigned-by-dhcp.cox.net>
References: <1123306575.7588.17.camel@dv.roinet.com>
	<7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
	<20050808231036.GA22778@mythryan2.michonline.com>
	<Pine.LNX.4.63.0508090140100.3695@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 04:49:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2KAW-0006uU-W3
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 04:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVHICsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 22:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVHICsm
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 22:48:42 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38317 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932420AbVHICsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 22:48:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809024841.RRCT12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 22:48:41 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I, for one, like the layout. There are not yet enough files to merit a 
> hierarchy, and what's more: I can add the source-directory to my PATH and 
> be done by compiling every time I pull.
>
> But you're right in any case, it is post 1.0 discussion material.

For quite some time, I've been wanting to install some of the
stuff under /usr/lib{,exec}/git-core/, but that is a post 1.0
material.  I do not care much about the way we organize the
sources at this stage.

Johannes, could you sanity check the commit change I have in the
proposed updates branch when things percolate through kernel.org
mirror network?  I ended up pushing it out before I found you
already did a patch.

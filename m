From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Command preparation cleanup in "connect.c"
Date: Sun, 10 Sep 2006 23:03:30 -0700
Message-ID: <7v3bazndn1.fsf@assigned-by-dhcp.cox.net>
References: <20060907055952.dafffe2b.chriscool@tuxfamily.org>
	<7vwt8g48rt.fsf@assigned-by-dhcp.cox.net>
	<200609110643.13486.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 08:02:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMesf-00031G-63
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 08:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWIKGCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 02:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWIKGCt
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 02:02:49 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32167 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964897AbWIKGCs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 02:02:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911060248.YYSL6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Mon, 11 Sep 2006 02:02:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lu2o1V0071kojtg0000000
	Mon, 11 Sep 2006 02:02:49 -0400
To: Christian Couder <chriscool@tuxfamily.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26838>

Christian Couder <chriscool@tuxfamily.org> writes:

> The following two patches clean "connect.c" up using "add_to_string" 
> from "rsh.c". The code is still longer, but there is no leak and it may be 
> better to die with an error message than to truncate a too long command.

Nice, clean, simple and obviously correct.

Thanks.

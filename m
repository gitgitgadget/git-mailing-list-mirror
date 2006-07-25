From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git wrapper: add --git-path=<path> and --bare options
Date: Tue, 25 Jul 2006 14:01:58 -0700
Message-ID: <7v4px5e6ux.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607251926190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0607251042120.29649@g5.osdl.org>
	<Pine.LNX.4.63.0607251952000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0607252022370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 23:02:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5U2V-0005Dp-Ry
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 23:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWGYVCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 17:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWGYVCA
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 17:02:00 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:56482 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751593AbWGYVB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jul 2006 17:01:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060725210159.VMVG6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Jul 2006 17:01:59 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607252022370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 25 Jul 2006 20:24:22 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24187>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With this, you can say
>
> 	git --bare repack -a -d
>
> inside a bare repository, and it will actually work. While at it,
> also move the --version, --help and --exec-path options to the
> handle_options() function.

Thanks.  Took a liberty cleaning up a few stuff, but will have
both alias-p and this patch in "next" shortly.

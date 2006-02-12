From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach repo-config the -l and --get-regexp options
Date: Sat, 11 Feb 2006 19:05:17 -0800
Message-ID: <7vlkwhgtua.fsf@assigned-by-dhcp.cox.net>
References: <43ED0368.7020204@gmail.com>
	<7vhd76vqrg.fsf@assigned-by-dhcp.cox.net> <43ED3FD3.7020005@gmail.com>
	<7vvevmtza4.fsf@assigned-by-dhcp.cox.net> <43ED5F60.1010408@gmail.com>
	<7v1wyasfam.fsf@assigned-by-dhcp.cox.net>
	<7vwtg2pkt2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0602111306450.25997@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 04:05:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F87YC-0004sq-G2
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 04:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWBLDFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 22:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWBLDFU
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 22:05:20 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1722 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750941AbWBLDFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 22:05:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212030413.VNOH3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 22:04:13 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15974>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Happier?

Not really.

It still dumps core with:

	[core]
        	boolvarsaretrueiftheirnamesarelisted

The patch does not address any of the more important issues I
listed with git-var and git-repo-config in that message.

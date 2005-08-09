From: Junio C Hamano <junkio@cox.net>
Subject: Re: Sanity check of git-commit patch, was Re: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Tue, 09 Aug 2005 05:53:50 -0700
Message-ID: <7vu0hzw9sx.fsf@assigned-by-dhcp.cox.net>
References: <1123306575.7588.17.camel@dv.roinet.com>
	<7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
	<20050808231036.GA22778@mythryan2.michonline.com>
	<Pine.LNX.4.63.0508090140100.3695@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vpssnyge0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508091212170.6752@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 14:54:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2TcC-0000yc-8H
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 14:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVHIMxw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 08:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVHIMxw
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 08:53:52 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45269 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932529AbVHIMxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 08:53:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809125351.VDHR16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 Aug 2005 08:53:51 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508091212170.6752@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 9 Aug 2005 12:17:54 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I just checked. Three nitpicks:
>
> - I don't like the GNU way to abbreviate long options too much...

True.  My bad old habit.

> - Multiple -m options was actually a feature of my version of the patch.

Ah, OK.

> - The "case .. in x) .. ;; esac;" construct is sometimes more confusing 
>   than a simple "if", or even a "[ .. = x ] && ..".

Yes sometimes.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: Sanity check of git-commit patch, was Re: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Tue, 09 Aug 2005 22:45:44 -0700
Message-ID: <7vd5oms5tj.fsf@assigned-by-dhcp.cox.net>
References: <1123306575.7588.17.camel@dv.roinet.com>
	<7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
	<20050808231036.GA22778@mythryan2.michonline.com>
	<Pine.LNX.4.63.0508090140100.3695@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vpssnyge0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508091212170.6752@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vu0hzw9sx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 07:46:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2jPV-0008AV-Dg
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 07:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVHJFpr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 01:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVHJFpr
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 01:45:47 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:22001 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965003AbVHJFpq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 01:45:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050810054545.FOBK8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 10 Aug 2005 01:45:45 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vu0hzw9sx.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 09 Aug 2005 05:53:50 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>> - Multiple -m options was actually a feature of my version of the patch.
>
> Ah, OK.

I said "OK" and thought about it again.  While thinking about
what is the right inter-message-piece separator for multiple -m
parameters (you use "\n"), I got a headache.  I decided to keep
what is already there after all ;-).

I'll push things out tonight and expect to tag things tomorrow
late afternoon to declare 0.99.4

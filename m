From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 17:29:20 -0800
Message-ID: <7vd56e3ukv.fsf@assigned-by-dhcp.cox.net>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	<86wt4mximh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	<7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net>
	<caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com>
	<7vodpy3vxi.fsf@assigned-by-dhcp.cox.net>
	<86vek6vyc7.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 02:29:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxCkW-0000hy-Tg
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 02:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWLUB3a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 20:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWLUB3a
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:29:30 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:57560 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161096AbWLUB33 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 20:29:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221012921.XDVO7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Dec 2006 20:29:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1DUf1W00C1kojtg0000000; Wed, 20 Dec 2006 20:28:40 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86vek6vyc7.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 17:20:40 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35001>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>> I'm not sure about everybody, but at least the Apple CC *is* GCC:
>
> Junio> Thanks for clarifying this; will apply.
>
> But don't because it doesn't help. :(

Won't; thanks for catching me soon enough.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move couple of ifdefs after "include config.mk"
Date: Wed, 30 Nov 2005 17:43:39 -0800
Message-ID: <7vhd9tmw1g.fsf@assigned-by-dhcp.cox.net>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
	<Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051201033201.02b47071.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 02:57:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehdfg-00076f-Ah
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 02:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbVLABzh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 20:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbVLABzh
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 20:55:37 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:39343 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751628AbVLABzh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 20:55:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201014258.DGPG6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 20:42:58 -0500
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20051201033201.02b47071.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Thu, 01 Dec 2005 03:32:01 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13035>

Honestly speaking, I'd personally prefer to just get rid of
"-include config.mak" from Makefile.  If somebody wants to keep
her customized set of configuration, she can have her own ./Make
script that would look like:

	#!/bin/sh
	make WITH_SEND_EMAIL=YesPlesae NO_EXPAT=NoThanks "$@"

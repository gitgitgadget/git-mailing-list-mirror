From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 10:58:00 -0700
Message-ID: <7vfyhmil07.fsf@assigned-by-dhcp.cox.net>
References: <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
	<E1Fw8hS-00023y-FY@moooo.ath.cx>
	<7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
	<E1FwDiI-0007Xp-2s@moooo.ath.cx>
	<7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>
	<E1FwGgm-0006Nc-9a@moooo.ath.cx>
	<7vejx6k54p.fsf@assigned-by-dhcp.cox.net>
	<E1FwMPf-0005XA-N9@moooo.ath.cx>
	<7vpsgqimu7.fsf@assigned-by-dhcp.cox.net> <e83n97$973$1@sea.gmane.org>
	<E1FwN7M-0007GI-Ng@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 30 19:58:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwNFn-0007Rq-RW
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 19:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWF3R6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 13:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWF3R6E
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 13:58:04 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:40071 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751333AbWF3R6C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 13:58:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630175801.LGWP6385.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 13:58:01 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FwN7M-0007GI-Ng@moooo.ath.cx> (Matthias Lederhofer's message
	of "Fri, 30 Jun 2006 19:49:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23006>

Matthias Lederhofer <matled@gmx.net> writes:

> -e foo --or  --near \( -e A -- or -e B \)
> would mean lines containing foo or having A or B in the context.

How would that "--near" be useful?  You will see A or B either way.

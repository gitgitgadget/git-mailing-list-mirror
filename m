From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] git.c: extra #include for dietlibc (and possibly other C libraries)
Date: Mon, 26 Dec 2005 09:01:28 -0800
Message-ID: <7v3bkflrmf.fsf@assigned-by-dhcp.cox.net>
References: <20051224121007.GA19136@mail.yhbt.net>
	<20051224121117.GB19136@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 26 18:02:13 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqvjX-0000UN-Uf
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 18:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVLZRBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 12:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVLZRBa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 12:01:30 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50661 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932068AbVLZRBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 12:01:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051226165934.RVDT17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Dec 2005 11:59:34 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051224121117.GB19136@mail.yhbt.net> (Eric Wong's message of
	"Sat, 24 Dec 2005 04:11:17 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14055>

Eric Wong <normalperson@yhbt.net> writes:

> struct winsize is defined in <termios.h>, and that's not pulled
> in by other #includes in that file

With glibc, sys/ioctl.h seems to pull it in.  Input from people
on other platforms is appreciated on this.

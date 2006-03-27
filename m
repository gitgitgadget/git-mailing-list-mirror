From: Junio C Hamano <junkio@cox.net>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 22:46:39 -0800
Message-ID: <7vu09ko04w.fsf@assigned-by-dhcp.cox.net>
References: <20060326014946.GB18185@pasky.or.cz>
	<7virq1sywj.fsf@assigned-by-dhcp.cox.net> <e06fl8$p9f$1@sea.gmane.org>
	<Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
	<e06hts$1ne$1@sea.gmane.org>
	<Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
	<e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com>
	<Pine.LNX.4.64.0603261422280.15714@g5.osdl.org>
	<e5bfff550603262147t3aec8da6p6bf2a333e2d35f1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 08:46:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNlUz-00014w-4V
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 08:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWC0Gqm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 01:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWC0Gql
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 01:46:41 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35048 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750746AbWC0Gql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 01:46:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060327064640.SOVM20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Mar 2006 01:46:40 -0500
To: Marco Costalba <mcostalba@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18073>

"Marco Costalba" <mcostalba@gmail.com> writes:

> NOTE: It seems that  git-whatchanged asks for checked the out file to
> work. It didn't work with no repository checked out.

Perhaps,

	$ git-whatchanged HEAD -- drivers/net/tg3.c

as Linus explained in a separate message today...

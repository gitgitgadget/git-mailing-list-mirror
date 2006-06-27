From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git.c: Re-introduce sane error messages on missing commands.
Date: Tue, 27 Jun 2006 15:57:45 -0700
Message-ID: <7vpsgu6wba.fsf@assigned-by-dhcp.cox.net>
References: <20060627083508.E912A5BBAB@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 00:58:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvMVD-0008Kt-Ss
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 00:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWF0W5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 18:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWF0W5s
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 18:57:48 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:11983 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932095AbWF0W5r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 18:57:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627225746.YAEN6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 18:57:46 -0400
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <20060627083508.E912A5BBAB@nox.op5.se> (Andreas Ericsson's
	message of "Tue, 27 Jun 2006 10:28:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22761>

Andreas Ericsson <ae@op5.se> writes:

> Somewhere in the alias handling git turned hostile on fat fingers:
>
> 	$ git showbranch
> 	Failed to run command '': Is a directory

Does not happen here (nor on Cygwin 1.4.1.rc1).  Care to help
reproducing it?

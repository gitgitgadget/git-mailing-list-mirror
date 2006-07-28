From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Thu, 27 Jul 2006 19:41:04 -0700
Message-ID: <7vvepimoxr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<200607262039.25155.Josef.Weidendorfer@gmx.de>
	<20060728013038.GH13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 04:41:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6IHo-0004y3-Bu
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 04:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWG1ClG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 22:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWG1ClG
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 22:41:06 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28593 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750916AbWG1ClF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 22:41:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060728024105.CGPX6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Jul 2006 22:41:05 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060728013038.GH13776@pasky.or.cz> (Petr Baudis's message of
	"Fri, 28 Jul 2006 03:30:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24362>

Petr Baudis <pasky@suse.cz> writes:

>   (i) No git-apply -R - well, it seems to me that I revert patches all
> the time, don't you?
>
>   (ii) I'd like git-apply to be as verbose as patch is, that is list
> the files it touches as it goes
>
>   (iii) There's no reject handling besides "panic" right now - it should
> be able to create .rej files so that the user can fix things up
>
>   (iv) I need git-apply to add/remove to/from index new/gone files,
> while at the same time...
>
>   (v) I want to allow applying of patches to working copy that is not
> completely clean, even on top of modified files

You probably should be able to talk me into doing these, but
doesn't it already do (iv) and (v)?

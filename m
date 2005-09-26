From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Mon, 26 Sep 2005 15:23:41 -0700
Message-ID: <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
	<20050926212536.GF26340@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:24:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK1Nz-0007DO-IH
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVIZWXo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVIZWXo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:23:44 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51407 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932399AbVIZWXo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 18:23:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926222344.KGXZ29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 18:23:44 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050926212536.GF26340@pasky.or.cz> (Petr Baudis's message of
	"Mon, 26 Sep 2005 23:25:36 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9347>

Petr Baudis <pasky@suse.cz> writes:

> Opinions?

I do not understand this part of your logic:

> .... But fetching the tags will cause all the commits
> connected to the tags getting slurped too, and we didn't want that.

What is the objective here?  If you fetch a tag without the
object being tagged (or commit without its tree), you will end
up with smaller object database but you would get yelled at by
git-fsck-objects.

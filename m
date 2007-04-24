From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Only use ETC_GITCONFIG=$(prefix)/etc/gitconfig ifeq ($(prefix),$(HOME))
Date: Mon, 23 Apr 2007 22:59:19 -0700
Message-ID: <7vlkgi9utk.fsf@assigned-by-dhcp.cox.net>
References: <462D673A.1010805@freedesktop.org>
	<7vhcr6bdmk.fsf@assigned-by-dhcp.cox.net>
	<462D9938.8020206@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 07:59:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgE3g-0007Wz-B2
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 07:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161637AbXDXF7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 01:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161651AbXDXF7V
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 01:59:21 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:55561 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161637AbXDXF7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 01:59:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424055920.RRSU1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 01:59:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qtzK1W00M1kojtg0000000; Tue, 24 Apr 2007 01:59:20 -0400
In-Reply-To: <462D9938.8020206@freedesktop.org> (Josh Triplett's message of
	"Mon, 23 Apr 2007 22:44:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45414>

Josh Triplett <josh@freedesktop.org> writes:

> Junio C Hamano wrote:
>> Is this really necessary?
>> 
>> I personally think distro people (or anybody who configures git
>> for system-wide deployment for that matter) already has Makefile
>> wrapper (a la debian/rules) to take care of this and other
>> issues.
>
> So did I.  Then I noticed (while stracing git to diagnose the issue with
> git-add searching the whole working copy for .gitignore files) that the
> Debian-packaged git looked for /usr/etc/gitconfig.  See
> <http://bugs.debian.org/420675>.  Apparently few enough people use
> /etc/gitconfig that nobody noticed and reported that it didn't work. :)
>
> Why not make the defaults more resistant to broken configuration?

Hmm.

It's tempting to leave this as is to gauge which distribution
has more competent package maintainer and which ones have sloppy
ones ;-).

Sympathetic, but still not entirely convinced.

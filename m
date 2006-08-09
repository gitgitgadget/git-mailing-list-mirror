From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Wed, 09 Aug 2006 04:11:02 -0700
Message-ID: <7vpsfa4115.fsf@assigned-by-dhcp.cox.net>
References: <200608071626.52655.jnareb@gmail.com>
	<7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org>
	<7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net> <eb8e12$2aa$1@sea.gmane.org>
	<7vejvsyum8.fsf@assigned-by-dhcp.cox.net> <ebcd8r$bi7$1@sea.gmane.org>
	<7vy7ty41xb.fsf@assigned-by-dhcp.cox.net> <ebcf9s$h32$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 13:11:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAlxs-0007kr-D4
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 13:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030681AbWHILLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 07:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030684AbWHILLF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 07:11:05 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:6654 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030681AbWHILLE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 07:11:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809111103.CGFD6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 07:11:03 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebcf9s$h32$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	09 Aug 2006 13:01:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25114>

Jakub Narebski <jnareb@gmail.com> writes:

> It's not a problem to do '...'/'next' link _after_ the body, but
> the paging navigation bar is at the _top_ of page, before 
> outputting the body.

A good web engineering practice is to prepare the data before
you generate a single line of output, so after or top should not
make a difference, I would think.

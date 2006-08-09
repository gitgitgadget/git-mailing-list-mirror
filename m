From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Wed, 09 Aug 2006 03:51:44 -0700
Message-ID: <7vy7ty41xb.fsf@assigned-by-dhcp.cox.net>
References: <200608071626.52655.jnareb@gmail.com>
	<7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org>
	<7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net> <eb8e12$2aa$1@sea.gmane.org>
	<7vejvsyum8.fsf@assigned-by-dhcp.cox.net> <ebcd8r$bi7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 12:52:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAlfB-0004Kb-0w
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 12:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030660AbWHIKvq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 06:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030669AbWHIKvq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 06:51:46 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14054 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030660AbWHIKvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 06:51:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809105145.FYDJ12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 06:51:45 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebcd8r$bi7$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	09 Aug 2006 12:26:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25110>

Jakub Narebski <jnareb@gmail.com> writes:

> It is needed in gitweb to create pagination/paging navigation bar. 
> Currently it is done by reading all the output into array, and 
> checking length of this array.

If you want to show 10 and do ... when you have more than that,
the standard technique is to ask for 11 ;-).

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] git-svn: migrate out of contrib
Date: Thu, 06 Jul 2006 17:20:51 -0700
Message-ID: <7v8xn64658.fsf@assigned-by-dhcp.cox.net>
References: <20060704215643.GA31763@localdomain>
	<11521700563472-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 02:21:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fye5Z-0000ae-8W
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 02:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWGGAUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 20:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWGGAUx
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 20:20:53 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35536 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751104AbWGGAUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 20:20:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707002052.YJW27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Jul 2006 20:20:52 -0400
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23412>

Overall it looks good.

9104 and 9105 fail when GIT_SVN_NO_LIB is unset and the
libsvn-*-perl is not available.  Maybe check this just like you
check and omit tests when svn or svnadmin is unavailable?

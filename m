From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Wed, 06 Sep 2006 15:01:13 -0700
Message-ID: <7vu03k64eu.fsf@assigned-by-dhcp.cox.net>
References: <200609061504.40725.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 00:01:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL5SI-0007Kz-Jh
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 00:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWIFWBI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 18:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWIFWBI
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 18:01:08 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:51919 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751416AbWIFWBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 18:01:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060906220105.MWEH6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Sep 2006 18:01:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KA161V00C1kojtg0000000
	Wed, 06 Sep 2006 18:01:06 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609061504.40725.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 6 Sep 2006 15:04:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26568>

Jakub Narebski <jnareb@gmail.com> writes:

> gitweb/gitweb.perl |  180 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 141 insertions(+), 39 deletions(-)-
>
> P.S. Is putting diffstat in such a series of patches actually usefull?

Very much -- it shows me that you are not damaging the core but
only touching gitweb.

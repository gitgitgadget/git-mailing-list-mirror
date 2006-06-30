From: Junio C Hamano <junkio@cox.net>
Subject: Re: Creating diff from 2.6.16 from cryptodev-2.6 git tree
Date: Thu, 29 Jun 2006 23:28:25 -0700
Message-ID: <7v1wt7ma2e.fsf@assigned-by-dhcp.cox.net>
References: <44A47BE0.9060504@logix.cz>
	<20060630013627.GA27527@gondor.apana.org.au>
	<Pine.LNX.4.64.0606291904250.12404@g5.osdl.org>
	<20060630023228.GA28850@gondor.apana.org.au>
	<Pine.LNX.4.64.0606291943010.12404@g5.osdl.org>
	<44A4BA6D.5010006@logix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 08:28:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwCUc-0003eK-Ju
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 08:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWF3G2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 02:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWF3G2a
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 02:28:30 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:54474 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751149AbWF3G23 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 02:28:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630062826.YVMU16011.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 02:28:26 -0400
To: Michal Ludvig <michal@logix.cz>
In-Reply-To: <44A4BA6D.5010006@logix.cz> (Michal Ludvig's message of "Fri, 30
	Jun 2006 17:45:17 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22960>

Michal Ludvig <michal@logix.cz> writes:

> Linus Torvalds wrote:
>
>> 	git log -p --full-diff v2.6.16.. crypto/
>
> Can I somehow get the result in a reverse order, i.e. oldest commits first?

Two ways:

	git format-patch -o patches-output/ --full-diff v2.6.16.. crypto/

would give you one file a patch in patches-output directory,
numbered.

	git format-patch --stdout --full-diff v2.6.16.. crypto/

would give you a single stream of the above to the standard output.

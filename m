From: Junio C Hamano <junkio@cox.net>
Subject: Re: Subproject clones
Date: Fri, 11 May 2007 18:32:41 -0700
Message-ID: <7vmz0a7rnq.fsf@assigned-by-dhcp.cox.net>
References: <20070512011600.GA24354@us.ibm.com>
	<7vr6pm7ry4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: apw@us.ibm.com (Amos Waterland)
X-From: git-owner@vger.kernel.org Sat May 12 03:33:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmgTr-00020I-Hx
	for gcvg-git@gmane.org; Sat, 12 May 2007 03:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759520AbXELBco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 21:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754789AbXELBco
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 21:32:44 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64305 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759520AbXELBcm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 21:32:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512013241.LQTI1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 21:32:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id y1Yh1W00h1kojtg0000000; Fri, 11 May 2007 21:32:42 -0400
In-Reply-To: <7vr6pm7ry4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 11 May 2007 18:26:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47011>

Junio C Hamano <junkio@cox.net> writes:

> apw@us.ibm.com (Amos Waterland) writes:
>
>> Is this intentional?  Shouldn't clone get the entire superproject?
>
> Yes.  As 1.5.2 draft release notes and my response to somebody
> else last night mentioned, the plumbing level subproject support
> does _NOT_ recurse into subproject and this is deliberate.

Namely:

    http://article.gmane.org/gmane.comp.version-control.git/46934
    http://article.gmane.org/gmane.comp.version-control.git/46940

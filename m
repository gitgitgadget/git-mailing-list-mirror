From: Junio C Hamano <gitster@pobox.com>
Subject: Re: problem after cvsimport
Date: Thu, 26 Jul 2007 00:02:51 -0700
Message-ID: <7vsl7b8x5w.fsf@assigned-by-dhcp.cox.net>
References: <46A7FD99.9000305@tplogic.com>
	<7vlkd3c16z.fsf@assigned-by-dhcp.cox.net>
	<46A8459C.7030202@tplogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Douglas <bertd@tplogic.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 09:02:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxN9-0002LV-9t
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758558AbXGZHCx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbXGZHCx
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:02:53 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:58679 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758159AbXGZHCw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 03:02:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726070250.FEQR1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 26 Jul 2007 03:02:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U72r1X0081kojtg0000000; Thu, 26 Jul 2007 03:02:51 -0400
In-Reply-To: <46A8459C.7030202@tplogic.com> (Bert Douglas's message of "Thu,
	26 Jul 2007 01:56:28 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53794>

Bert Douglas <bertd@tplogic.com> writes:

> Am I going to have to do "-f" a lot?
> How will I know when to do it?
> Why not do it all the time?

With recent enough git, you shouldn't even have to do that extra
"git checkout".  It was noticed and fixed quite a while ago.

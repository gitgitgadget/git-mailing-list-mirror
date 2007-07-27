From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fully resolve symlinks when creating lockfiles
Date: Fri, 27 Jul 2007 00:05:42 -0700
Message-ID: <7vk5sm2unt.fsf@assigned-by-dhcp.cox.net>
References: <7vbqe0cazy.fsf@assigned-by-dhcp.cox.net>
	<11854712542350-git-send-email-bradford.carl.smith@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bradford C. Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 09:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEJtY-00008K-BN
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 09:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761581AbXG0HFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 03:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760670AbXG0HFt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 03:05:49 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37036 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759614AbXG0HFo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 03:05:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727070543.WFVO1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Jul 2007 03:05:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UX5i1X0091kojtg0000000; Fri, 27 Jul 2007 03:05:43 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53903>

"Bradford C. Smith" <bradford.carl.smith@gmail.com> writes:

> Make the code for resolving symlinks in lockfile.c more robust as
> follows:
>
> 1. Handle relative symlinks
> 2. recursively resolve symlink chains up to OS limit

I munged this patch with Morten's comments.  Will queue for
'next'.  Further polishing will be done in 'next' as needed.

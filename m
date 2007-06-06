From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix the remote note the fetch-tool prints after storing a fetched reference
Date: Wed, 06 Jun 2007 01:14:36 -0700
Message-ID: <7v3b157b4j.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 10:14:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvqfC-00079K-1t
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbXFFIOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753935AbXFFIOi
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:14:38 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:38124 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbXFFIOh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:14:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606081436.RQYZ9600.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 04:14:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 88Ec1X0081kojtg0000000; Wed, 06 Jun 2007 04:14:36 -0400
In-Reply-To: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com>
	(Alex Riesen's message of "Wed, 6 Jun 2007 09:45:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49262>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Otherwise ".git" is removed from every remote name which has it:
>
>  $ git fetch -v
>    * refs/heads/origin: same as branch 'master' of /home/user/linux
>      commit: 5ecd310
>  $ ls /home/user/linux
>  ls: /home/user/linux: No such file or directory
>  $ ls /home/user/linux.git
>  HEAD  objects  packed-refs  ...

I suspect the above misses the point.

The test "ls /home/user/linux" is not relevant.  Ability to say
"git fetch /home/user/linux" is.

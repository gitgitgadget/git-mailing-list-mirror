From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] wcwidth redeclaration
Date: Mon, 07 May 2007 22:02:03 -0700
Message-ID: <7vmz0f52no.fsf@assigned-by-dhcp.cox.net>
References: <20070508044608.GA32223@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: apw@us.ibm.com (Amos Waterland)
X-From: git-owner@vger.kernel.org Tue May 08 07:02:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlHpx-0003bP-GJ
	for gcvg-git@gmane.org; Tue, 08 May 2007 07:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967774AbXEHFCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 01:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967841AbXEHFCG
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 01:02:06 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52610 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967774AbXEHFCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 01:02:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508050205.CIMJ6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 8 May 2007 01:02:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wV231W0071kojtg0000000; Tue, 08 May 2007 01:02:04 -0400
In-Reply-To: <20070508044608.GA32223@us.ibm.com> (Amos Waterland's message of
	"Tue, 8 May 2007 00:46:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46540>

apw@us.ibm.com (Amos Waterland) writes:

> Build fails for git 1.5.1.3 on AIX, with the message: 
>
> utf8.c:66: error: conflicting types for 'wcwidth'
> /.../lib/gcc/powerpc-ibm-aix5.3.0.0/4.0.3/include/string.h:266: error: previous declaration of 'wcwidth' was here
>
> Here is a patch that fixes it for me.  If there is a different way that
> is preferred, please let me know.

It's static in that file, so renaming our version to our own
name as you did is perfectly good.

Thanks for helping, as not many people seem to be on AIX on this
list.

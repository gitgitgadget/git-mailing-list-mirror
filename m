From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: git-svnimport.perl bug when copy source path has a revision
Date: Thu, 16 Oct 2008 11:36:33 -0700
Message-ID: <quack.20081016T1136.lthk5c8crpq@roar.cs.berkeley.edu>
References: <quack.20081015T1211.lth8wsp65dk@roar.cs.berkeley.edu>
	<48F6E29F.1050807@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 20:37:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqXjG-0006tk-OU
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 20:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbYJPSge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 14:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbYJPSge
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 14:36:34 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:59523 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbYJPSgd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 14:36:33 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 30164343ED; Thu, 16 Oct 2008 11:36:33 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <48F6E29F.1050807@pcharlan.com> (Pete Harlan's message of "Wed\, 15 Oct 2008 23\:43\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98401>

>>>>> On 2008-10-15 23:43 PDT, Pete Harlan writes:

    Pete> git svn init -T trunk -t tags $R git svn fetch git log
    Pete> tags/mytag

Thanks for the pointer.  I do know about git-svn and used it
to convert most of my repositories, but one particular repository
isn't converting with git-svn - it runs for hours before I cancel
it, whereas git-svnimport completes in minutes.

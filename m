From: Junio C Hamano <junkio@cox.net>
Subject: Re: git applymbox is too anal
Date: Thu, 08 Sep 2005 18:03:47 -0700
Message-ID: <7vd5njrr0s.fsf@assigned-by-dhcp.cox.net>
References: <20050908232535.GA7700@kroah.com>
	<20050908233906.GA7976@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 03:04:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDXJB-0002bz-2w
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 03:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVIIBDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 21:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbVIIBDv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 21:03:51 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:65234 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965097AbVIIBDs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 21:03:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050909010346.RAJK2438.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Sep 2005 21:03:46 -0400
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050908233906.GA7976@kroah.com> (Greg KH's message of "Thu, 8
	Sep 2005 16:39:06 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8231>

Greg KH <greg@kroah.com> writes:

> So, the patch shows that there was another line at the end of the file,
> while in reality it isn't (this is due to me excluding a patch from the
> series that I'm applying due to other reasons.)
>
> Is this something that git can handle without me editing the patch by
> hand?  :)

Linus was quite strict about rejecting any fuzz, but I am
sympathetic to the cause.  I do not mind if somebody comes up
with a patch to add '--fuzz' option to git-apply; we can try
applying first without --fuzz and ask the user if he wants one
from 'git applymbox' main loop when it fails.

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] diff-tree -c (not --cc) in diff-raw format?
Date: Fri, 03 Feb 2006 22:39:33 -0800
Message-ID: <7v4q3f8w62.fsf@assigned-by-dhcp.cox.net>
References: <7vfyn0asdd.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550602032218s72f91151tb8f6fcda373c2a28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 07:39:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5H5C-00078n-GY
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 07:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946317AbWBDGjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 01:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946318AbWBDGjg
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 01:39:36 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:403 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1946317AbWBDGjf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 01:39:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204063833.TPQJ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 01:38:33 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550602032218s72f91151tb8f6fcda373c2a28@mail.gmail.com>
	(Marco Costalba's message of "Sat, 4 Feb 2006 07:18:35 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15573>

Marco Costalba <mcostalba@gmail.com> writes:

> As you see -c _could_ imply -m

In case it was not clear, it already implies -m and does not
skip merges even if you do not give -m.  Otherwise you would not
see anything without saying "diff-tree -c -m' to begin with.

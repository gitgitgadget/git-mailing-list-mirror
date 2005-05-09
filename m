From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 9 May 2005 22:15:20 +0200
Message-ID: <20050509201520.GL24216@cip.informatik.uni-erlangen.de>
References: <7vis1vc27f.fsf@assigned-by-dhcp.cox.net> <2721.10.10.10.24.1115425962.squirrel@linux1> <7vbr7nbl89.fsf@assigned-by-dhcp.cox.net> <7vacn6ak7r.fsf@assigned-by-dhcp.cox.net> <427F6693.2080707@zytor.com> <7vll6oz755.fsf@assigned-by-dhcp.cox.net> <3087.10.10.10.24.1115656919.squirrel@linux1> <427FA5FD.1050000@zytor.com> <7vfywwz11t.fsf@assigned-by-dhcp.cox.net> <7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 09 22:08:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVEY2-0006kS-V7
	for gcvg-git@gmane.org; Mon, 09 May 2005 22:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVEIUP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 16:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVEIUP0
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 16:15:26 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:31181 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261503AbVEIUPV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 16:15:21 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j49KFKS8011473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 9 May 2005 20:15:20 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j49KFK4E011472
	for git@vger.kernel.org; Mon, 9 May 2005 22:15:20 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Here is a patch, requesting for comments.

sounds good. But I would forget about downward compatibility. There is
no need to maintain it at this early stage.

And one thing which bothers me all the time but never spoke up about it:
There is no way to provide a GIT_COMMIT_DATE. This would be useful for
vendortracking a CVS repository for example.

And personally I think GIT_COMMIT_AUTHOR_EMAIL and
GIT_COMMIT_AUTHOR_NAME are to long what about
GIT_COMMITTER_{NAME,EMAIL}?  Whatever. You script them or put them in
your environment anyway so no big issue.

	Thomas

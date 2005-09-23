From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.7b
Date: Fri, 23 Sep 2005 13:46:14 -0700
Message-ID: <7v8xxnbjhl.fsf@assigned-by-dhcp.cox.net>
References: <7voe6ki9x7.fsf@assigned-by-dhcp.cox.net>
	<dh0uur$h4g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 22:47:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIuR6-0003d3-Pu
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 22:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVIWUqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 16:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVIWUqQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 16:46:16 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:57833 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751231AbVIWUqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 16:46:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923204615.MOXD6597.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 16:46:15 -0400
To: walt <wa1ter@myrealbox.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9201>

walt <wa1ter@myrealbox.com> writes:

> Junio C Hamano wrote:
>> GIT 0.99.7b
> [...]
>> Or, if you use git already:
>> 	{http,rsync}://kernel.org/pub/scm/git/git.git/
>
> I did it that way and now I see this:

If you fetched v0.99.7b tag and built it, hopefully it should
say 0.99.7b otherwise you found a big bug.

If you pulled from "master" branch, then --version would still
say 0.99.7; I agree it is confusing.  On the other hand, I do
not think we would want to increment the version string with
every little changes, so...

From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Add lsremote command.
Date: Sun, 17 Apr 2005 16:03:09 +0200
Message-ID: <20050417140309.GF1487@pasky.ji.cz>
References: <200504162336.51937.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 16:00:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNAJE-0004vZ-Nj
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 15:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVDQODP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 10:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDQODP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 10:03:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56976 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261318AbVDQODM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 10:03:12 -0400
Received: (qmail 13542 invoked by uid 2001); 17 Apr 2005 14:03:10 -0000
To: Steven Cole <elenstev@mesatop.com>
Content-Disposition: inline
In-Reply-To: <200504162336.51937.elenstev@mesatop.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 07:36:51AM CEST, I got a letter
where Steven Cole <elenstev@mesatop.com> told me that...
> This is a fairly trivial addition, but if users are adding remote repositories
> with git addremote, then those users should be able to list out the remote
> list without having to know the details of where the remotes file is kept.

Could you please send your patches inline? (Either in the body or with
correct content-disposition header.)

You got the return values other way around and you are missing a
copyright notice at the top; you should also mention that you take no
parameters.

Please use -s instead of -e, since it is more appropriate in this case.
Also, you should report the "no remotes" message to stderr. And always
exit when you found that .git/remotes exists, not only if cat succeeds.

Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
